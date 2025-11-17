import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:native_geofence/native_geofence.dart';

import '../../features/reminders/models/reminder.dart';

class GeofenceNotificationService {
  GeofenceNotificationService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  static const _channelId = 'location_reminders_channel';
  static const _channelName = 'Location Reminders';
  static const _channelDescription = 'Notifies you when you reach saved places';

  final Random _random = Random();

  Future<void> ensureInitialized() async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(initializationSettings);

    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _initialized = true;
  }

  Future<void> showLocationReminder(
    Reminder reminder,
    GeofenceEvent event,
  ) async {
    await ensureInitialized();
    const details = NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          interruptionLevel: InterruptionLevel.timeSensitive,
        ));
    final locationLabel = reminder.location?.trim().isNotEmpty == true
        ? reminder.location!.trim()
        : 'this location';
    final action = event == GeofenceEvent.exit ? 'left' : 'arrived near';
    final body = reminder.description?.trim().isNotEmpty == true
        ? reminder.description!.trim()
        : 'You have $action $locationLabel.';

    await _plugin.show(
      _random.nextInt(0x7fffffff),
      reminder.title,
      body,
      details,
      payload: reminder.id,
    );
  }
}
