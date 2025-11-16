part of 'reminder_list_bloc.dart';

@freezed
class ReminderListEvent with _$ReminderListEvent {
  const factory ReminderListEvent.filterChanged(ReminderFilter filter) = _FilterChanged;
  const factory ReminderListEvent.reminderAdded(Reminder reminder) = _ReminderAdded;
  const factory ReminderListEvent.reminderUpdated(Reminder reminder) = _ReminderUpdated;
  const factory ReminderListEvent.reminderDeleted(String id) = _ReminderDeleted;
}
