import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/app_theme.dart';
import '../bloc/reminder_list_bloc.dart';
import '../cubit/reminder_form_cubit.dart';
import '../models/reminder.dart';
import '../widgets/reminder_card.dart';
import 'reminder_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: _Header(dateText: dateText)),
          const Expanded(child: _RemindersList()),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: 'add_reminder_fab',
          backgroundColor: AppColors.primary,
          onPressed: () => _openAdd(context),
          shape: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Icon(Icons.add_rounded,
                color: AppColors.primary, size: 26),
          )),
    );
  }

  void _openAdd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => ReminderFormCubit(),
          child: const ReminderFormPage(),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String dateText;
  const _Header({required this.dateText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleRow(todayCount: state.todayCount),
            const SizedBox(height: 16),
            _FilterChips(filter: state.filter),
          ],
        );
      },
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
      height: 48,
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
        if (reminders.isEmpty) return _EmptyState();

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
          itemBuilder: (context, index) => ReminderCard(
            reminder: reminders[index],
            onMenuTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (_) => ReminderFormCubit(reminder: reminders[index]),
                  child: const ReminderFormPage()),
            )),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: reminders.length,
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
