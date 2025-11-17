import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:native_geofence/native_geofence.dart';

import '../../features/reminders/models/reminder.dart';
import '../geofence_callback.dart';

class GeofenceRegistrationException implements Exception {
  GeofenceRegistrationException(this.message, [this.cause]);
  final String message;
  final Object? cause;

  @override
  String toString() => 'GeofenceRegistrationException: $message';
}

abstract class ReminderLocationTriggerService {
  Future<void> initialize();
  Future<void> syncLocationReminders(List<Reminder> reminders);
  Future<void> registerReminder(Reminder reminder);
  Future<void> removeReminder(String reminderId);
}

class ReminderGeofenceService implements ReminderLocationTriggerService {
  ReminderGeofenceService({NativeGeofenceManager? manager})
      : _manager = manager ?? NativeGeofenceManager.instance;

  final NativeGeofenceManager _manager;
  bool _initialized = false;
  static const _logTag = '[GeofenceService]';

  static const double _defaultRadiusMeters = 200;
  static const String _geofencePrefix = 'reminder_';

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    await _manager.initialize();
    _initialized = true;
    log('initialized', name: _logTag);
  }

  @override
  Future<void> syncLocationReminders(List<Reminder> reminders) async {
    await initialize();
    final validReminders = reminders.where(_isLocationReminder).toList();
    final targetIds =
        validReminders.map((reminder) => _geofenceId(reminder.id)).toSet();
    try {
      final existingIds = await _manager.getRegisteredGeofenceIds();
      for (final id in existingIds) {
        if (_isReminderGeofenceId(id) && !targetIds.contains(id)) {
          await _manager.removeGeofenceById(id);
          log('removed stale geofence $id', name: _logTag);
        }
      }
    } catch (error, stackTrace) {
      log('Failed to synchronize geofences: $error',
          name: _logTag, stackTrace: stackTrace);
    }

    for (final reminder in validReminders) {
      await _createOrUpdate(reminder);
    }
  }

  @override
  Future<void> registerReminder(Reminder reminder) async {
    if (!_isLocationReminder(reminder)) {
      await removeReminder(reminder.id);
      return;
    }
    await _createOrUpdate(reminder);
  }

  @override
  Future<void> removeReminder(String reminderId) async {
    await initialize();
    try {
      await _manager.removeGeofenceById(_geofenceId(reminderId));
    } catch (error, stackTrace) {
      debugPrint('Failed to remove geofence $reminderId: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _createOrUpdate(Reminder reminder) async {
    await initialize();
    final radius = reminder.radiusMeters ?? _defaultRadiusMeters;
    final geofence = Geofence(
      id: _geofenceId(reminder.id),
      location: Location(
          latitude: reminder.latitude!, longitude: reminder.longitude!),
      radiusMeters: radius,
      triggers: const {GeofenceEvent.enter},
      iosSettings: const IosGeofenceSettings(initialTrigger: true),
      androidSettings: const AndroidGeofenceSettings(
        initialTriggers: {GeofenceEvent.enter},
        notificationResponsiveness: Duration(minutes: 1),
      ),
    );
    try {
      await _manager.createGeofence(geofence, geofenceTriggered);
      log(
          'registered ${reminder.id} at ${reminder.latitude},${reminder.longitude} r=${geofence.radiusMeters}',
          name: _logTag);
    } catch (error, stackTrace) {
      log('Unable to register geofence for ${reminder.id}: $error',
          name: _logTag, stackTrace: stackTrace);
      throw GeofenceRegistrationException(
          'Failed to register location reminder', error);
    }
  }

  static bool _isLocationReminder(Reminder reminder) =>
      reminder.locationBased &&
      reminder.latitude != null &&
      reminder.longitude != null;

  static String _geofenceId(String reminderId) => '$_geofencePrefix$reminderId';

  static bool _isReminderGeofenceId(String id) =>
      id.startsWith(_geofencePrefix);

  static String? reminderIdFromGeofenceId(String id) {
    if (!_isReminderGeofenceId(id)) return null;
    return id.substring(_geofencePrefix.length);
  }
}
