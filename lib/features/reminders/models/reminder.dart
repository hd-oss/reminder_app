import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';

@freezed
class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String title,
    required DateTime date,
    required List<String> times,
    @Default(ReminderRepeat.once) ReminderRepeat repeat,
    @Default(ReminderCategory.work) ReminderCategory category,
    @Default(ReminderPriority.medium) ReminderPriority priority,
    String? location,
    @Default(false) bool locationBased,
    double? latitude,
    double? longitude,
    String? note,
  }) = _Reminder;
}

enum ReminderFilter { all, today, upcoming, location }

enum ReminderRepeat { once, daily, weekly }

enum ReminderCategory { work, personal, family, errand, health }

enum ReminderPriority { high, medium, low }
