part of 'reminder_list_bloc.dart';

@freezed
class ReminderListState with _$ReminderListState {
  const ReminderListState._();

  const factory ReminderListState({
    required List<Reminder> reminders,
    required ReminderFilter filter,
    @Default(false) bool isLoading,
    String? error,
  }) = _ReminderListState;

  List<Reminder> get filteredReminders {
    final now = DateTime.now();
    switch (filter) {
      case ReminderFilter.all:
        return reminders;
      case ReminderFilter.today:
        return reminders.where((reminder) => DateUtils.isSameDay(reminder.date, now)).toList();
      case ReminderFilter.upcoming:
        return reminders.where((reminder) => reminder.date.isAfter(now)).toList();
      case ReminderFilter.location:
        return reminders
            .where(
              (reminder) =>
                  reminder.locationBased ||
                  (reminder.location ?? '').isNotEmpty ||
                  (reminder.latitude != null && reminder.longitude != null),
            )
            .toList();
    }
  }

  int get totalCount => reminders.length;

  int get todayCount => reminders.where((reminder) => DateUtils.isSameDay(reminder.date, DateTime.now())).length;
}
