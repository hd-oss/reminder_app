import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Ensures location services are on and "Always" permission is granted.
/// Returns true when ready to proceed, otherwise shows a SnackBar and may
/// open the relevant settings screen.
Future<bool> ensureAlwaysLocationPermission(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);

  if (!await Geolocator.isLocationServiceEnabled()) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(
          content: Text('Enable location services to use this feature.')));
    await Geolocator.openLocationSettings();
    return false;
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.whileInUse) {
    permission = await Geolocator.requestPermission();
  }

  final isAlways = permission == LocationPermission.always;
  if (isAlways) return true;

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(const SnackBar(
      content: Text(
          'Please allow "Always" location access to use location reminders.'),
    ));

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();
  } else {
    await Geolocator.openLocationSettings();
  }

  return false;
}
