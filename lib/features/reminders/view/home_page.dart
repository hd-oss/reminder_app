import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../core/app_theme.dart';
import '../bloc/reminder_list_bloc.dart';
import '../cubit/reminder_form_cubit.dart';
import '../models/reminder.dart';
import '../widgets/reminder_card.dart';
import 'reminder_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkLocationPermission(),
    );
  }

  Future<void> _checkLocationPermission() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final hasService = await Geolocator.isLocationServiceEnabled();
      if (!hasService) {
        if (!mounted) return;
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
                content: Text(
              'Location services are disabled. Enable them to use location reminders.',
            )),
          );
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
                content: Text(
              'Location permission is needed for location-based reminders.',
            )),
          );
      }
    } catch (_) {
      if (!mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Unable to check location permission.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      backgroundColor: AppColors.background,
      body: BlocListener<ReminderListBloc, ReminderListState>(
          listenWhen: (previous, current) => previous.error != current.error,
          listener: (context, state) {
            final message = state.error;
            if (message == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          },
          child: SafeArea(
            child: Column(children: [
              Container(
                  color: AppColors.card,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _Header(dateText: dateText)),
              const Expanded(child: _RemindersList()),
            ]),
          )),
      floatingActionButton: FloatingActionButton(
          heroTag: 'add_reminder_fab',
          backgroundColor: AppColors.primary,
          onPressed: () => _openAdd(context),
          shape: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(Icons.add_rounded,
                color: AppColors.primary, size: 26),
          )),
    );
  }

  void _openAdd(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => ReminderFormCubit(),
                  child: const ReminderFormPage(),
                )),
      );
}

class _Header extends StatelessWidget {
  final String dateText;
  const _Header({required this.dateText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _TitleRow(todayCount: state.todayCount),
          const SizedBox(height: 8),
          _FilterChips(filter: state.filter),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final int todayCount;
  const _TitleRow({required this.todayCount});

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 0,
      minVerticalPadding: 0,
      title: Text('Reminders',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(dateText,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.mutedForeground)),
      trailing: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(100)),
        child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: todayCount.toString(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.secondaryForeground,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '\nToday',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.secondaryForeground)),
            ]),
            textAlign: TextAlign.center),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final ReminderFilter filter;
  const _FilterChips({required this.filter});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final f = ReminderFilter.values[index];
          final selected = filter == f;
          return ChoiceChip(
              label: Text(_filterLabel(f)),
              selected: selected,
              onSelected: (_) => context
                  .read<ReminderListBloc>()
                  .add(ReminderListEvent.filterChanged(f)),
              selectedColor: AppColors.primary,
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: selected ? Colors.white : AppColors.mutedForeground,
                  fontWeight: FontWeight.w600),
              side: BorderSide(
                  color: selected ? AppColors.primary : AppColors.border),
              backgroundColor: AppColors.muted,
              checkmarkColor: Colors.white);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: ReminderFilter.values.length,
      ),
    );
  }
}

class _RemindersList extends StatelessWidget {
  const _RemindersList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
      builder: (context, state) {
        final reminders = state.filteredReminders;
        if (state.isLoading && state.reminders.isEmpty) {
          return const _LoadingState();
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context
                .read<ReminderListBloc>()
                .add(const ReminderListEvent.remindersRequested());
          },
          child: reminders.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ReminderCard(
                      reminder: reminders[index],
                      onMenuTap: () => onOpenForm(context, reminders[index])),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: reminders.length)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.4,
                    child: state.error != null && reminders.isEmpty
                        ? _ErrorState(message: state.error!)
                        : _EmptyState(),
                  )),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.notifications_none_rounded,
              size: 48, color: AppColors.mutedForeground),
          const SizedBox(height: 12),
          Text('No reminders', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Text('Tap the add button to create a reminder',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.mutedForeground)),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 48, color: AppColors.destructive),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Pull to refresh or try again later.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

String _filterLabel(ReminderFilter filter) {
  switch (filter) {
    case ReminderFilter.all:
      return 'All';
    case ReminderFilter.today:
      return 'Today';
    case ReminderFilter.upcoming:
      return 'Upcoming';
    case ReminderFilter.location:
      return 'Location';
  }
}
