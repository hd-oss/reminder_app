import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/reminder.dart';

part 'reminder_form_cubit.freezed.dart';

class ReminderFormCubit extends Cubit<ReminderFormState> {
  ReminderFormCubit({Reminder? reminder}) : super(ReminderFormState.initial(reminder: reminder));

  void updateTitle(String value) => emit(state.copyWith(title: value));

  void updateDate(DateTime value) => emit(state.copyWith(date: value));

  void addTime(String label) {
    if (label.trim().isEmpty) return;
    emit(state.copyWith(times: [...state.times, label]));
  }

  void removeTimeAt(int index) {
    if (index < 0 || index >= state.times.length) return;
    final next = [...state.times]..removeAt(index);
    emit(state.copyWith(times: next));
  }

  void selectRepeat(ReminderRepeat repeat) => emit(state.copyWith(repeat: repeat));

  void toggleLocation(bool enabled) {
    emit(
      state.copyWith(
        locationBased: enabled,
        location: enabled ? state.location : '',
        latitude: enabled ? state.latitude : null,
        longitude: enabled ? state.longitude : null,
      ),
    );
  }

  void updateLocation(String value) => emit(state.copyWith(location: value));

  void updateCoordinate(double latitude, double longitude) {
    final coordinateLabel = '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
    emit(
      state.copyWith(
        latitude: latitude,
        longitude: longitude,
        location: coordinateLabel,
      ),
    );
  }

  void selectCategory(ReminderCategory category) => emit(state.copyWith(category: category));

  void selectPriority(ReminderPriority priority) => emit(state.copyWith(priority: priority));

  Reminder buildReminder() {
    final title = state.title.trim().isEmpty ? 'Untitled Reminder' : state.title.trim();
    final times = state.times.where((time) => time.trim().isNotEmpty).toList();
    return Reminder(
      id: state.editing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      date: DateUtils.dateOnly(state.date),
      times: times.isEmpty ? ['9:00 AM'] : times,
      repeat: state.repeat,
      category: state.category,
      priority: state.priority,
      locationBased: state.locationBased,
      location: state.locationBased ? (state.location.trim().isEmpty ? null : state.location.trim()) : null,
      latitude: state.locationBased ? state.latitude : null,
      longitude: state.locationBased ? state.longitude : null,
    );
  }
}

@freezed
class ReminderFormState with _$ReminderFormState {
  const factory ReminderFormState({
    Reminder? editing,
    required String title,
    required DateTime date,
    required List<String> times,
    required ReminderRepeat repeat,
    required ReminderCategory category,
    required ReminderPriority priority,
    required bool locationBased,
    required String location,
    double? latitude,
    double? longitude,
  }) = _ReminderFormState;

  factory ReminderFormState.initial({Reminder? reminder}) {
    return ReminderFormState(
      editing: reminder,
      title: reminder?.title ?? '',
      date: reminder?.date ?? DateTime.now(),
      times: reminder?.times ?? const ['9:00 AM', '10:00 AM', '12:00 PM'],
      repeat: reminder?.repeat ?? ReminderRepeat.once,
      category: reminder?.category ?? ReminderCategory.work,
      priority: reminder?.priority ?? ReminderPriority.medium,
      locationBased: reminder?.locationBased ?? false,
      location: reminder?.location ?? '',
      latitude: reminder?.latitude,
      longitude: reminder?.longitude,
    );
  }
}
