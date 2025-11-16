part of 'reminder_list_bloc.dart';

@freezed
class ReminderListEvent with _$ReminderListEvent {
  const factory ReminderListEvent.remindersRequested() = _RemindersRequested;
  const factory ReminderListEvent.filterChanged(ReminderFilter filter) = _FilterChanged;
  const factory ReminderListEvent.reminderAdded(
    Reminder reminder, {
    VoidCallback? onSuccess,
    void Function(String message)? onError,
  }) = _ReminderAdded;
  const factory ReminderListEvent.reminderUpdated(
    Reminder reminder, {
    VoidCallback? onSuccess,
    void Function(String message)? onError,
  }) = _ReminderUpdated;
  const factory ReminderListEvent.reminderDeleted(
    String id, {
    VoidCallback? onSuccess,
    void Function(String message)? onError,
  }) = _ReminderDeleted;
}
