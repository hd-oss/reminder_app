import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/geofence_service.dart';
import '../../../core/notification_service.dart';
import '../data/reminder_repository.dart';
import '../models/reminder.dart';

part 'reminder_list_bloc.freezed.dart';
part 'reminder_list_event.dart';
part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  ReminderListBloc(
    this._repository,
    this._notificationService,
    this._geofenceService,
  ) : super(const ReminderListState(
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
  final ReminderLocationTriggerService _geofenceService;

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
      // await _notificationService.rescheduleAll(sorted);
      // await _geofenceService.syncLocationReminders(sorted);
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
      await _registerReminder(event.reminder);

      emit(state.copyWith(
        reminders: _sortReminders([...previousReminders, event.reminder]),
        error: null,
      ));

      event.onSuccess?.call();
    } catch (error, stackTrace) {
      _log('Failed to add reminder', error, stackTrace);
      // Rollback persisted data and scheduled tasks
      await _repository.deleteReminder(event.reminder.id);
      await _cleanupReminder(event.reminder);

      emit(state.copyWith(
        reminders: previousReminders,
        error: 'Failed to save reminder. ${_errorLabel(error)}',
      ));
      event.onError?.call('Failed to save reminder. ${_errorLabel(error)}');
    }
  }

  Future<void> _onReminderUpdated(
    _ReminderUpdated event,
    Emitter<ReminderListState> emit,
  ) async {
    Reminder? previous;
    try {
      previous = await _repository.findById(event.reminder.id);

      await _repository.saveReminder(event.reminder);

      if (previous != null) {
        await _cleanupReminder(previous);
      }

      await _registerReminder(event.reminder);

      final reminders = state.reminders.map((reminder) {
        return reminder.id == event.reminder.id ? event.reminder : reminder;
      }).toList();

      emit(state.copyWith(reminders: _sortReminders(reminders), error: null));

      event.onSuccess?.call();
    } catch (error, stackTrace) {
      _log('Failed to update reminder', error, stackTrace);
      // Rollback to previous data and schedule if available
      if (previous != null) {
        await _repository.saveReminder(previous);
        await _registerReminder(previous);
      }

      emit(state.copyWith(
          error: 'Failed to update reminder. ${_errorLabel(error)}'));
      event.onError
          ?.call('Failed to update reminder. ${_errorLabel(error)}');
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
      final reminders = previousReminders
          .where((reminder) => reminder.id != event.id)
          .toList();

      emit(state.copyWith(reminders: reminders, error: null));

      target?.locationBased ?? false
          ? await _geofenceService.removeReminder(event.id)
          : await _notificationService.cancelReminder(target!);

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

  Future<void> _registerReminder(Reminder reminder) async {
    if (reminder.locationBased) {
      await _geofenceService.registerReminder(reminder);
    } else {
      await _notificationService.scheduleReminder(reminder);
    }
  }

  Future<void> _cleanupReminder(Reminder reminder) async {
    if (reminder.locationBased) {
      await _geofenceService.removeReminder(reminder.id);
    } else {
      await _notificationService.cancelReminder(reminder);
    }
  }

  String _errorLabel(Object error) {
    final text = error.toString();
    if (text.isEmpty) return '';
    return text;
  }

  void _log(String message, Object error, StackTrace stackTrace) {
    final detail = '$message: $error';
    log(detail, name: 'ReminderListBloc', stackTrace: stackTrace);
  }
}
