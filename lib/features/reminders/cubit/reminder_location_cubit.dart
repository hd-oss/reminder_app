import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'reminder_form_cubit.dart';

class ReminderLocationState {
  const ReminderLocationState({
    this.isLocating = false,
    this.isResolvingAddress = false,
    this.message,
    this.address,
    this.placeInfo,
  });

  final bool isLocating;
  final bool isResolvingAddress;
  final String? message;
  final String? address;
  final ResolvedPlaceInfo? placeInfo;

  ReminderLocationState copyWith({
    bool? isLocating,
    bool? isResolvingAddress,
    String? message,
    bool shouldClearMessage = false,
    String? address,
    ResolvedPlaceInfo? placeInfo,
    bool shouldClearPlaceInfo = false,
  }) {
    return ReminderLocationState(
      isLocating: isLocating ?? this.isLocating,
      isResolvingAddress: isResolvingAddress ?? this.isResolvingAddress,
      message: shouldClearMessage ? null : message ?? this.message,
      address: address ?? this.address,
      placeInfo: shouldClearPlaceInfo ? null : placeInfo ?? this.placeInfo,
    );
  }
}

class ResolvedPlaceInfo {
  const ResolvedPlaceInfo(
      {this.name,
      this.street,
      this.subLocality,
      this.locality,
      this.administrativeArea,
      this.country,
      this.postalCode});

  factory ResolvedPlaceInfo.fromPlacemark(Placemark placemark) {
    String? clean(String? value) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) return null;
      return trimmed;
    }

    return ResolvedPlaceInfo(
        name: clean(placemark.name),
        street: clean(placemark.street),
        subLocality: clean(placemark.subLocality),
        locality: clean(placemark.locality),
        administrativeArea: clean(placemark.administrativeArea),
        country: clean(placemark.country),
        postalCode: clean(placemark.postalCode));
  }

  final String? name;
  final String? street;
  final String? subLocality;
  final String? locality;
  final String? administrativeArea;
  final String? country;
  final String? postalCode;

  String? get title =>
      name ??
      street ??
      subLocality ??
      locality ??
      administrativeArea ??
      country;

  List<String> get detailLines {
    final details = <String>[];
    final currentTitle = title;
    for (final value in [
      street,
      subLocality,
      locality,
      administrativeArea,
      country,
    ]) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) continue;
      if (trimmed == currentTitle) continue;
      if (!details.contains(trimmed)) details.add(trimmed);
    }
    return details;
  }
}

class ReminderLocationCubit extends Cubit<ReminderLocationState> {
  ReminderLocationCubit(
    this._formCubit, {
    String? initialAddress,
  }) : super(ReminderLocationState(address: initialAddress));

  final ReminderFormCubit _formCubit;

  Future<void> bootstrap({
    double? latitude,
    double? longitude,
  }) async {
    if (latitude == null || longitude == null || state.placeInfo != null) {
      return;
    }
    await _resolveAddress(latitude, longitude);
  }

  Future<Position?> useCurrentLocation() async {
    emit(state.copyWith(
      isLocating: true,
      shouldClearMessage: true,
    ));
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        emit(state.copyWith(
          isLocating: false,
          message: 'Location services are disabled.',
        ));
        return null;
      }

      if (!await _ensurePermissionGranted()) {
        emit(state.copyWith(
          isLocating: false,
          message: 'Location permissions are denied.',
        ));
        return null;
      }

      final position = await Geolocator.getCurrentPosition();
      await _handleCoordinateUpdate(position.latitude, position.longitude);
      emit(state.copyWith(isLocating: false));
      return position;
    } catch (_) {
      emit(state.copyWith(
        isLocating: false,
        message: 'Unable to access current location.',
      ));
    }
    return null;
  }

  Future<void> updateManualCoordinate(double latitude, double longitude) async {
    await _handleCoordinateUpdate(latitude, longitude);
  }

  void clearMessage() => emit(state.copyWith(shouldClearMessage: true));

  Future<void> _handleCoordinateUpdate(
    double latitude,
    double longitude,
  ) async {
    _formCubit.updateCoordinate(latitude, longitude);
    await _resolveAddress(latitude, longitude);
  }

  Future<void> _resolveAddress(double latitude, double longitude) async {
    final fallback =
        '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
    emit(state.copyWith(
        isResolvingAddress: true,
        shouldClearMessage: true,
        shouldClearPlaceInfo: true));
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      final firstPlacemark = placemarks.isNotEmpty ? placemarks.first : null;
      final formatted = _formatPlacemark(firstPlacemark);
      final label = formatted ?? fallback;
      if (formatted != null) {
        _formCubit.updateLocation(formatted);
      }
      emit(state.copyWith(
          isResolvingAddress: false,
          address: label,
          placeInfo: firstPlacemark != null
              ? ResolvedPlaceInfo.fromPlacemark(firstPlacemark)
              : null));
    } catch (_) {
      emit(state.copyWith(
          isResolvingAddress: false,
          message: 'Unable to resolve address.',
          address: fallback,
          shouldClearPlaceInfo: true));
    }
  }

  String? _formatPlacemark(Placemark? placemark) {
    if (placemark == null) return null;
    final values = <String>[];
    for (final value in [
      placemark.name,
      placemark.street,
      placemark.subLocality,
      placemark.locality,
      placemark.administrativeArea,
    ]) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty && !values.contains(trimmed)) {
        values.add(trimmed);
      }
    }
    if (values.isEmpty) return null;
    return values.join(', ');
  }

  Future<bool> _ensurePermissionGranted() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
