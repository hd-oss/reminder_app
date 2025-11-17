import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../features/reminders/models/reminder.dart';

abstract class ReminderNotificationService {
  Future<void> initialize();
  Future<void> rescheduleAll(List<Reminder> reminders);
  Future<void> scheduleReminder(Reminder reminder);
  Future<void> cancelReminder(Reminder reminder);
}

class NotificationService implements ReminderNotificationService {
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _isInitialized = false;
  static const _channelId = 'reminder_schedule_channel';
  static const _channelName = 'Reminder Schedules';
  static const _channelDescription = 'Notifies you when reminders are due';
  static const _logTag = '[NotificationService]';

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(initializationSettings);
    await _requestPermissions();
    await _configureLocalTimeZone();
    await _createNotificationChannel();

    _isInitialized = true;
    _log('Initialized');
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    _log('Timezone set to $timeZoneName');
  }

  Future<void> _createNotificationChannel() async {
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
  }

  Future<void> _requestPermissions() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  @override
  Future<void> rescheduleAll(List<Reminder> reminders) async {
    await _ensureInitialized();
    await _plugin.cancelAll();
    _log('Cancelled all before reschedule (${reminders.length} reminders)');
    for (final reminder in reminders) {
      await scheduleReminder(reminder);
    }
  }

  @override
  Future<void> scheduleReminder(Reminder reminder) async {
    await _ensureInitialized();
    if (reminder.locationBased || reminder.times.isEmpty) return;

    for (var index = 0; index < reminder.times.length; index++) {
      final target = _nextSchedule(reminder, reminder.times[index]);
      if (target == null) continue;
      final id = _notificationId(reminder.id, index);
      // ignore: prefer_const_constructors
      final details = NotificationDetails(
          android: const AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.max,
            priority: Priority.high,
          ));

      await _plugin.zonedSchedule(
        id,
        reminder.title,
        _notificationBody(reminder),
        target,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: _matchComponents(reminder.repeat),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: reminder.id,
      );
      _log(
          'Scheduled notification id=$id for ${reminder.id} at ${target.toIso8601String()}');
    }
  }

  @override
  Future<void> cancelReminder(Reminder reminder) async {
    await _ensureInitialized();
    final count = max(reminder.times.length, 1);
    for (var index = 0; index < count; index++) {
      await _plugin.cancel(_notificationId(reminder.id, index));
    }
    _log('Cancelled notifications for ${reminder.id} ($count)');
  }

  String _notificationBody(Reminder reminder) {
    if (reminder.description != null &&
        reminder.description!.trim().isNotEmpty) {
      return reminder.description!.trim();
    }
    return reminder.times.isNotEmpty
        ? 'Scheduled at ${reminder.times.join(', ')}'
        : 'You have an upcoming reminder.';
  }

  DateTimeComponents? _matchComponents(ReminderRepeat repeat) {
    switch (repeat) {
      case ReminderRepeat.once:
        return null;
      case ReminderRepeat.daily:
        return DateTimeComponents.time;
      case ReminderRepeat.weekly:
        return DateTimeComponents.dayOfWeekAndTime;
    }
  }

  tz.TZDateTime? _nextSchedule(Reminder reminder, String label) {
    final time = _parseTime(label);
    if (time == null) return null;
    final now = tz.TZDateTime.now(tz.local);

    switch (reminder.repeat) {
      case ReminderRepeat.once:
        final date = reminder.date;
        final scheduled = tz.TZDateTime(
          tz.local,
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        if (scheduled.isBefore(now)) return null;
        return scheduled;
      case ReminderRepeat.daily:
        var scheduled = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }
        return scheduled;
      case ReminderRepeat.weekly:
        final referenceWeekday = reminder.date.weekday;
        var scheduled = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );
        while (
            scheduled.weekday != referenceWeekday || scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }
        return scheduled;
    }
  }

  TimeOfDay? _parseTime(String label) {
    final candidate = label.split('-').first.trim();
    try {
      final parsed = DateFormat('h:mm a', 'en_US').parse(candidate);
      return TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    } catch (_) {
      return null;
    }
  }

  int _notificationId(String reminderId, int index) {
    final base = reminderId.hashCode & 0x7fffffff;
    return base + index;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  void _log(String message) {
    log.log(message, name: _logTag);
  }
}
