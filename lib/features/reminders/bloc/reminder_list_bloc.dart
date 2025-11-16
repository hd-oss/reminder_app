import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/notification_service.dart';
import '../data/reminder_repository.dart';
import '../models/reminder.dart';

part 'reminder_list_bloc.freezed.dart';
part 'reminder_list_event.dart';
part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  ReminderListBloc(this._repository, this._notificationService)
      : super(const ReminderListState(
          reminders: [],
          filter: ReminderFilter.all,
          isLoading: true,
        )) {
    on<_RemindersRequested>(_onRemindersRequested);
    on<_FilterChanged>(_onFilterChanged);
    on<_ReminderAdded>(_onReminderAdded);
    on<_ReminderUpdated>(_onReminderUpdated);
    on<_ReminderDeleted>(_onReminderDeleted);
  }

  final ReminderRepository _repository;
  final ReminderNotificationService _notificationService;

  Future<void> _onRemindersRequested(
    _RemindersRequested event,
    Emitter<ReminderListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final reminders = await _repository.fetchReminders();
      final sorted = _sortReminders(reminders);
      emit(state.copyWith(
        reminders: sorted,
        isLoading: false,
      ));
      await _notificationService.rescheduleAll(sorted);
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Unable to load reminders.',
      ));
    }
  }

  void _onFilterChanged(
    _FilterChanged event,
    Emitter<ReminderListState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onReminderAdded(
    _ReminderAdded event,
    Emitter<ReminderListState> emit,
  ) async {
    final previousReminders = List<Reminder>.from(state.reminders);
    try {
      await _repository.saveReminder(event.reminder);
      final reminders = [...previousReminders, event.reminder];
      emit(state.copyWith(
        reminders: _sortReminders(reminders),
        error: null,
      ));
      await _notificationService.scheduleReminder(event.reminder);
      event.onSuccess?.call();
    } catch (_) {
      emit(state.copyWith(
        reminders: previousReminders,
        error: 'Failed to save reminder.',
      ));
      event.onError?.call('Failed to save reminder.');
    }
  }

  Future<void> _onReminderUpdated(
    _ReminderUpdated event,
    Emitter<ReminderListState> emit,
  ) async {
    final previousReminders = List<Reminder>.from(state.reminders);
    try {
      Reminder? previous;
      for (final reminder in previousReminders) {
        if (reminder.id == event.reminder.id) {
          previous = reminder;
          break;
        }
      }
      await _repository.saveReminder(event.reminder);
      final reminders = state.reminders.map((reminder) {
        return reminder.id == event.reminder.id ? event.reminder : reminder;
      }).toList();
      if (previous != null) {
        await _notificationService.cancelReminder(previous);
      }
      emit(state.copyWith(
        reminders: _sortReminders(reminders),
        error: null,
      ));
      await _notificationService.scheduleReminder(event.reminder);
      event.onSuccess?.call();
    } catch (_) {
      emit(state.copyWith(
        reminders: previousReminders,
        error: 'Failed to update reminder.',
      ));
      event.onError?.call('Failed to update reminder.');
    }
  }

  Future<void> _onReminderDeleted(
    _ReminderDeleted event,
    Emitter<ReminderListState> emit,
  ) async {
    final previousReminders = List<Reminder>.from(state.reminders);
    try {
      Reminder? target;
      for (final reminder in previousReminders) {
        if (reminder.id == event.id) {
          target = reminder;
          break;
        }
      }
      await _repository.deleteReminder(event.id);
      final reminders =
          previousReminders.where((reminder) => reminder.id != event.id).toList();
      emit(state.copyWith(
        reminders: reminders,
        error: null,
      ));
      if (target != null) {
        await _notificationService.cancelReminder(target);
      }
      event.onSuccess?.call();
    } catch (_) {
      emit(state.copyWith(
        reminders: previousReminders,
        error: 'Failed to delete reminder.',
      ));
      event.onError?.call('Failed to delete reminder.');
    }
  }

  List<Reminder> _sortReminders(List<Reminder> reminders) {
    final next = [...reminders]..sort((a, b) {
        final dateCompare = a.date.compareTo(b.date);
        if (dateCompare != 0) return dateCompare;
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });
    return next;
  }
}
