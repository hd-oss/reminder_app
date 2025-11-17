import 'package:flutter/widgets.dart';
import 'package:native_geofence/native_geofence.dart';

import '../features/reminders/data/reminder_repository.dart';
import '../features/reminders/models/reminder.dart';
import 'geofence_notification_service.dart';
import 'geofence_service.dart';

@pragma('vm:entry-point')
Future<void> geofenceTriggered(GeofenceCallbackParams params) async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = ReminderRepository();
  final notificationService = GeofenceNotificationService();
  final seen = <String>{};

  for (final geofence in params.geofences) {
    final reminderId =
        ReminderGeofenceService.reminderIdFromGeofenceId(geofence.id);
    if (reminderId == null || seen.contains(reminderId)) {
      continue;
    }
    seen.add(reminderId);

    final reminder = await _loadReminder(repository, reminderId);
    if (reminder == null) continue;

    await notificationService.showLocationReminder(reminder, params.event);
  }
}

Future<Reminder?> _loadReminder(
  ReminderRepository repository,
  String reminderId,
) async {
  try {
    return await repository.findById(reminderId);
  } catch (_) {
    return null;
  }
}
