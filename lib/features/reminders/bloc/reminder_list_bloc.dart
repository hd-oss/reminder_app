import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/reminder.dart';

part 'reminder_list_bloc.freezed.dart';
part 'reminder_list_event.dart';
part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  ReminderListBloc()
      : super(ReminderListState(
          reminders: _seedReminders,
          filter: ReminderFilter.all,
        )) {
    on<_FilterChanged>((event, emit) {
      emit(state.copyWith(filter: event.filter));
    });
    on<_ReminderAdded>((event, emit) {
      final reminders = [...state.reminders, event.reminder];
      emit(state.copyWith(reminders: reminders));
    });
    on<_ReminderUpdated>((event, emit) {
      final reminders = state.reminders
          .map((reminder) =>
              reminder.id == event.reminder.id ? event.reminder : reminder)
          .toList();
      emit(state.copyWith(reminders: reminders));
    });
    on<_ReminderDeleted>((event, emit) {
      final reminders =
          state.reminders.where((reminder) => reminder.id != event.id).toList();
      emit(state.copyWith(reminders: reminders));
    });
  }

  static final List<Reminder> _seedReminders = [
    Reminder(
        id: '1',
        title: 'Team Meeting',
        date: DateTime.now(),
        times: const ['9:00 AM - 10:00 AM'],
        location: 'Conference Room A',
        category: ReminderCategory.work,
        priority: ReminderPriority.high),
    Reminder(
        id: '2',
        title: 'Buy Groceries',
        date: DateTime.now(),
        times: const ['12:00 PM'],
        location: 'Whole Foods Market',
        category: ReminderCategory.personal,
        priority: ReminderPriority.medium),
    Reminder(
        id: '3',
        title: 'Gym Workout',
        date: DateTime.now(),
        times: const ['6:00 PM - 7:30 PM'],
        category: ReminderCategory.health,
        priority: ReminderPriority.low,
        note: 'Recurring session'),
    Reminder(
        id: '4',
        title: 'Client Presentation',
        date: DateTime.now().add(const Duration(days: 1)),
        times: const ['2:00 PM'],
        location: 'Client Office Downtown',
        category: ReminderCategory.work,
        priority: ReminderPriority.high),
    Reminder(
        id: '5',
        title: 'Call Mom',
        date: DateTime.now(),
        times: const ['8:00 PM'],
        category: ReminderCategory.family,
        priority: ReminderPriority.medium),
    Reminder(
        id: '6',
        title: 'Pick up Package',
        date: DateTime.now(),
        times: const ['When arriving'],
        location: 'Near Post Office',
        category: ReminderCategory.errand,
        priority: ReminderPriority.low,
        note: 'Location-based',
        locationBased: true),
  ];
}
