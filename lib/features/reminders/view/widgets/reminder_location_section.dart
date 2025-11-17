import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../../core/app_theme.dart';
import '../../cubit/reminder_form_cubit.dart';
import '../../cubit/reminder_location_cubit.dart';
import 'reminder_form_sections.dart';

const latlng.LatLng _defaultCenter =
    latlng.LatLng(-6.2088, 106.8456); // Jakarta

class ReminderLocationSection extends StatelessWidget {
  const ReminderLocationSection({
    super.key,
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final formCubit = context.read<ReminderFormCubit>();
    final initialLabel = formCubit.state.location.trim().isEmpty
        ? null
        : formCubit.state.location.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.location_on_rounded,
          label: 'Location Reminder',
        ),
        BlocProvider(
          create: (_) => ReminderLocationCubit(
            formCubit,
            initialAddress: initialLabel,
          )..bootstrap(latitude: latitude, longitude: longitude),
          child: _LocationInputSection(
            latitude: latitude,
            longitude: longitude,
          ),
        ),
      ],
    );
  }
}

class _LocationInputSection extends StatefulWidget {
  const _LocationInputSection({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  State<_LocationInputSection> createState() => _LocationInputSectionState();
}

class _LocationInputSectionState extends State<_LocationInputSection> {
  final MapController _mapController = MapController();

  latlng.LatLng? get _selectedPoint {
    if (widget.latitude == null || widget.longitude == null) return null;
    return latlng.LatLng(widget.latitude!, widget.longitude!);
  }

  bool get _hasSelection => _selectedPoint != null;

  // @override
  // void didUpdateWidget(covariant _LocationInputSection oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   final hasNewLocation =
  //       oldWidget.latitude != widget.latitude || oldWidget.longitude != widget.longitude;
  //   final target = _selectedPoint;
  //   if (target != null && hasNewLocation) {
  //     _mapController.move(target, 15);
  //   }
  // }

  Widget locationReminderHint() {
    return Row(children: [
      const Icon(
        Icons.info_rounded,
        size: 16,
        color: AppColors.mutedForeground,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text('Remind me when I arrive at this location',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.mutedForeground)),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReminderLocationCubit, ReminderLocationState>(
      listener: (context, state) {
        final message = state.message;
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          context.read<ReminderLocationCubit>().clearMessage();
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
            color: AppColors.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ReminderFormCubit, ReminderFormState>(
              buildWhen: (previous, current) =>
                  previous.latitude != current.latitude ||
                  previous.longitude != current.longitude ||
                  previous.radiusMeters != current.radiusMeters,
              builder: (context, formState) {
                final radius = formState.radiusMeters ?? 200;
                return _LocationMap(
                  mapController: _mapController,
                  selectedPoint: _selectedPoint,
                  hasSelection: _hasSelection,
                  onPointSelected: (point) => context
                      .read<ReminderLocationCubit>()
                      .updateManualCoordinate(point.latitude, point.longitude),
                  radiusMeters: radius,
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<ReminderLocationCubit, ReminderLocationState>(
              buildWhen: (previous, current) =>
                  previous.placeInfo != current.placeInfo ||
                  previous.isResolvingAddress != current.isResolvingAddress,
              builder: (context, state) {
                if (state.placeInfo == null || state.isResolvingAddress) {
                  return const SizedBox.shrink();
                }
                return _PlaceInfoDetails(info: state.placeInfo!);
              },
            ),
            const SizedBox(height: 12),
            const _RadiusSelector(),
            const SizedBox(height: 8),
            locationReminderHint(),
          ],
        ),
      ),
    );
  }
}

class _LocationMap extends StatelessWidget {
  const _LocationMap({
    required this.mapController,
    required this.selectedPoint,
    required this.hasSelection,
    required this.onPointSelected,
    required this.radiusMeters,
  });

  final MapController mapController;
  final latlng.LatLng? selectedPoint;
  final bool hasSelection;
  final ValueChanged<latlng.LatLng> onPointSelected;
  final double radiusMeters;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2.3,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        FlutterMap(
            mapController: mapController,
            options: MapOptions(
                initialCenter: selectedPoint ?? _defaultCenter,
                initialZoom: hasSelection ? 14 : 11,
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.rotate,
                ),
                onTap: (tapPosition, point) => onPointSelected(
                      latlng.LatLng(point.latitude, point.longitude),
                    )),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.reminder_app',
              ),
              if (hasSelection && selectedPoint != null)
                CircleLayer(circles: [
                  CircleMarker(
                      point: selectedPoint!,
                      radius: radiusMeters,
                      useRadiusInMeter: true,
                      color: AppColors.primary.withOpacity(0.12),
                      borderColor: AppColors.primary.withOpacity(0.4),
                      borderStrokeWidth: 2),
                ]),
              if (hasSelection && selectedPoint != null)
                MarkerLayer(markers: [
                  Marker(
                    point: selectedPoint!,
                    width: 70,
                    height: 70,
                    child: const Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.primary,
                          size: 38,
                        )),
                  ),
                ]),
            ]),
        BlocBuilder<ReminderLocationCubit, ReminderLocationState>(
            buildWhen: (previous, current) =>
                previous.isLocating != current.isLocating,
            builder: (context, state) => _LocateButton(
                  isLoading: state.isLocating,
                  onPressed: state.isLocating
                      ? null
                      : () => context
                              .read<ReminderLocationCubit>()
                              .useCurrentLocation()
                              .then((value) {
                            if (value == null) return null;
                            return mapController.move(
                                latlng.LatLng(value.latitude, value.longitude),
                                15);
                          }),
                )),
      ]),
    );
  }
}

class _LocateButton extends StatelessWidget {
  const _LocateButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 4,
        right: 4,
        child: IconButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.muted,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          icon: isLoading
              ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
              : const Icon(Icons.my_location_rounded),
        ));
  }
}

class _PlaceInfoDetails extends StatelessWidget {
  const _PlaceInfoDetails({required this.info});

  final ResolvedPlaceInfo info;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final detailLines = info.detailLines;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.place_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.title ?? 'Unnamed place',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
                if (detailLines.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(detailLines.join(' • '),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedForeground,
                      ))
                ],
                if (info.postalCode != null) ...[
                  const SizedBox(height: 4),
                  Text('Postal code ${info.postalCode}',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedForeground,
                      )),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RadiusSelector extends StatelessWidget {
  const _RadiusSelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderFormCubit, ReminderFormState>(
      buildWhen: (previous, current) =>
          previous.radiusMeters != current.radiusMeters,
      builder: (context, state) {
        final currentRadius = state.radiusMeters ?? 200;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Radius',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text('${currentRadius.toStringAsFixed(0)} m',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.mutedForeground)),
              ],
            ),
            Slider(
              value: currentRadius.clamp(50, 1000),
              min: 50,
              max: 1000,
              divisions: 19,
              label: '${currentRadius.toStringAsFixed(0)} m',
              activeColor: AppColors.primary,
              onChanged: context.read<ReminderFormCubit>().updateRadius,
            ),
          ],
        );
      },
    );
  }
}
