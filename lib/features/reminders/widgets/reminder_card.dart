import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import '../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.reminder,
    this.onMenuTap,
  });

  final Reminder reminder;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C101828),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
                if ((reminder.description ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(reminder.description!.trim(),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                      )),
                ],
                if (!reminder.locationBased && reminder.times.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.access_time_filled_rounded,
                        size: 16, color: AppColors.mutedForeground),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(reminder.times.join(' • '),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.mutedForeground,
                          )),
                    ),
                  ]),
                ],
                if (reminder.locationBased && (reminder.location ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.place_rounded,
                        size: 16, color: AppColors.mutedForeground),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(reminder.location!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.mutedForeground,
                          )),
                    ),
                  ]),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Pill(
                      label: _categoryLabel(reminder.category),
                      backgroundColor: _categoryBackground(reminder.category),
                      foregroundColor: _categoryColor(reminder.category),
                    ),
                    _Pill(
                      label: '${_priorityLabel(reminder.priority)} Priority',
                      backgroundColor: _priorityBackground(reminder.priority),
                      foregroundColor: _priorityColor(reminder.priority),
                    ),
                    if (reminder.locationBased)
                      const _Pill(
                        label: 'Location-based',
                        backgroundColor: AppColors.muted,
                        foregroundColor: AppColors.mutedForeground,
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'More',
            style: IconButton.styleFrom(
              backgroundColor: AppColors.muted,
              shape: const CircleBorder(),
            ),
            onPressed: onMenuTap,
            icon: const Icon(Icons.more_horiz_rounded,
                color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }

  static String _categoryLabel(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.work:
        return 'Work';
      case ReminderCategory.personal:
        return 'Personal';
      case ReminderCategory.family:
        return 'Family';
      case ReminderCategory.errand:
        return 'Errand';
      case ReminderCategory.health:
        return 'Health';
    }
  }

  static String _priorityLabel(ReminderPriority priority) {
    switch (priority) {
      case ReminderPriority.high:
        return 'High';
      case ReminderPriority.medium:
        return 'Medium';
      case ReminderPriority.low:
        return 'Low';
    }
  }

  static Color _categoryColor(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.work:
        return AppColors.secondaryForeground;
      case ReminderCategory.personal:
        return AppColors.chart5;
      case ReminderCategory.family:
        return AppColors.chart3;
      case ReminderCategory.errand:
        return AppColors.chart4;
      case ReminderCategory.health:
        return AppColors.chart5;
    }
  }

  static Color _categoryBackground(ReminderCategory category) {
    return _categoryColor(category).withOpacity(0.12);
  }

  static Color _priorityColor(ReminderPriority priority) {
    switch (priority) {
      case ReminderPriority.high:
        return AppColors.chart1;
      case ReminderPriority.medium:
        return AppColors.chart4;
      case ReminderPriority.low:
        return AppColors.mutedForeground;
    }
  }

  static Color _priorityBackground(ReminderPriority priority) {
    if (priority == ReminderPriority.low) {
      return AppColors.muted;
    }
    return _priorityColor(priority).withOpacity(0.15);
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: foregroundColor),
        ));
  }
}
