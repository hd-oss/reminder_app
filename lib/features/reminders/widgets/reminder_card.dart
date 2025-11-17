import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Card(
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //     color: AppColors.card,
      //     borderRadius: BorderRadius.circular(12),
      //     border: Border.all(color: AppColors.border),
      //     boxShadow: const [
      //       BoxShadow(
      //         color: Color(0x0C101828),
      //         blurRadius: 20,
      //         offset: Offset(0, 4),
      //       ),
      //     ]),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                contentPadding: EdgeInsets.zero,
                minTileHeight: 0,
                minVerticalPadding: 8,
                title: Text(reminder.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
                subtitle: (reminder.description ?? '').trim().isNotEmpty
                    ? Text(reminder.description!.trim(),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey))
                    : null,
                trailing: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: onMenuTap,
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.4)),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.more_horiz_rounded,
                        color: AppColors.card,
                      )),
                )),
            if (!reminder.locationBased && reminder.times.isNotEmpty) ...[
              _fieldbuilder(
                  theme: theme,
                  icon: Icons.access_time_filled_rounded,
                  value: reminder.times.join(' • ')),
              _fieldbuilder(
                  theme: theme,
                  icon: Icons.date_range_rounded,
                  value: DateFormat('EEEE, MM dd yyyy').format(reminder.date)),
            ],
            if (reminder.locationBased && (reminder.location ?? '').isNotEmpty)
              _fieldbuilder(
                  theme: theme,
                  icon: Icons.place_rounded,
                  value: reminder.location ?? '-'),
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
                      foregroundColor: AppColors.mutedForeground),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldbuilder({
    required ThemeData theme,
    required IconData icon,
    required String value,
  }) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: AppColors.mutedForeground),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
          ],
        ));
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
