import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_theme.dart';
import '../../cubit/reminder_form_cubit.dart';
import '../../models/reminder.dart';

class FormSectionLabel extends StatelessWidget {
  const FormSectionLabel({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class ReminderTitleField extends StatelessWidget {
  const ReminderTitleField({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.description_rounded,
          label: 'Reminder Title',
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 45,
          child: TextFormField(
            initialValue: value,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.bodySmall,
            onChanged: context.read<ReminderFormCubit>().updateTitle,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintText: 'What do you want to be reminded about?',
            ),
          ),
        ),
      ],
    );
  }
}

class ReminderDescriptionField extends StatelessWidget {
  const ReminderDescriptionField({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const FormSectionLabel(
        icon: Icons.notes_rounded,
        label: 'Description',
      ),
      const SizedBox(height: 8),
      TextFormField(
          initialValue: value,
          maxLines: 4,
          minLines: 3,
          style: Theme.of(context).textTheme.bodySmall,
          onChanged: context.read<ReminderFormCubit>().updateDescription,
          decoration: const InputDecoration(
            hintText: 'Add any extra context or notes',
          )),
    ]);
  }
}

class ReminderTypeSelector extends StatelessWidget {
  const ReminderTypeSelector({super.key, required this.isLocationReminder});

  final bool isLocationReminder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.notifications_active_rounded,
          label: 'Reminder Type',
        ),
        const SizedBox(height: 12),
        Row(children: [
          _TypeOptionCard(
              icon: Icons.alarm_rounded,
              title: 'Date & Time',
              subtitle: 'Trigger at specific time',
              selected: !isLocationReminder,
              onTap: () {
                context.read<ReminderFormCubit>().toggleLocation(false);
              }),
          const SizedBox(width: 12),
          _TypeOptionCard(
              icon: Icons.place_rounded,
              title: 'Location',
              subtitle: 'Trigger when arriving',
              selected: isLocationReminder,
              onTap: () {
                context.read<ReminderFormCubit>().toggleLocation(true);
              }),
        ]),
      ],
    );
  }
}

class _TypeOptionCard extends StatelessWidget {
  const _TypeOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.mutedForeground;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selected ? AppColors.secondary : AppColors.card,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.mutedForeground)),
          ],
        ),
      ),
    );
  }
}

class ReminderTimeSection extends StatelessWidget {
  const ReminderTimeSection({super.key, required this.times});

  final List<String> times;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.access_time_filled_rounded,
          label: 'Time',
        ),
        const SizedBox(height: 12),
        _TimeContainer(times: times),
      ],
    );
  }
}

class _TimeContainer extends StatelessWidget {
  const _TimeContainer({required this.times});

  final List<String> times;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          color: AppColors.card),
      child: Column(
        children: [
          ...List.generate(times.length, (index) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: index == (times.length - 1) ? 0 : 12),
              child: _TimeRow(
                  label: times[index],
                  onRemove: () {
                    context.read<ReminderFormCubit>().removeTimeAt(index);
                  }),
            );
          }),
          const SizedBox(height: 4),
          OutlinedButton.icon(
            onPressed: () => _addTime(context),
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add Time'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: AppColors.border),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && context.mounted) {
      final now = DateTime.now();
      final formatted = DateFormat('h:mm a', 'en_US').format(DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      ));
      context.read<ReminderFormCubit>().addTime(formatted);
    }
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12)),
            child: Text(label,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.secondaryForeground)),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.mutedForeground,
            )),
      ],
    );
  }
}

class ReminderDateSection extends StatelessWidget {
  const ReminderDateSection({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('EEEE, dd MMM yyyy').format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
            icon: Icons.calendar_month_rounded, label: 'Date'),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => _pickDate(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            backgroundColor: AppColors.card,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border)),
          ),
          child: Row(children: [
            Expanded(
              child: Text(formatted,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black87)),
            ),
            const Icon(Icons.expand_more_rounded,
                color: AppColors.mutedForeground),
          ]),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final state = context.read<ReminderFormCubit>().state;
    final picked = await showDatePicker(
      context: context,
      initialDate: state.date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && context.mounted) {
      context.read<ReminderFormCubit>().updateDate(picked);
    }
  }
}

class ReminderRepeatSection extends StatelessWidget {
  const ReminderRepeatSection({super.key, required this.selected});

  final ReminderRepeat selected;

  static const _labels = {
    ReminderRepeat.once: 'Once',
    ReminderRepeat.daily: 'Daily',
    ReminderRepeat.weekly: 'Weekly',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.refresh_rounded,
          label: 'Repeat',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ReminderRepeat.values.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              final repeat = ReminderRepeat.values[index];
              final isSelected = repeat == selected;
              return ChoiceChip(
                label: Text(_labels[repeat] ?? ''),
                selected: isSelected,
                onSelected: (_) {
                  context.read<ReminderFormCubit>().selectRepeat(repeat);
                },
                checkmarkColor: Colors.white,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: AppColors.muted,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ReminderCategorySection extends StatelessWidget {
  const ReminderCategorySection({super.key, required this.selected});

  final ReminderCategory selected;

  static const _labels = {
    ReminderCategory.work: 'Work',
    ReminderCategory.personal: 'Personal',
    ReminderCategory.family: 'Family',
    ReminderCategory.errand: 'Errand',
    ReminderCategory.health: 'Health',
  };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReminderFormCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.sell_outlined,
          label: 'Category',
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ReminderCategory.values
                .map((category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_labels[category] ?? ''),
                        selected: category == selected,
                        onSelected: (_) => cubit.selectCategory(category),
                        selectedColor: AppColors.secondary,
                        checkmarkColor: AppColors.secondaryForeground,
                        backgroundColor: AppColors.muted,
                        labelStyle: TextStyle(
                          color: category == selected
                              ? AppColors.secondaryForeground
                              : AppColors.mutedForeground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ReminderPrioritySection extends StatelessWidget {
  const ReminderPrioritySection({super.key, required this.selected});

  final ReminderPriority selected;

  static const _labels = {
    ReminderPriority.high: 'High',
    ReminderPriority.medium: 'Medium',
    ReminderPriority.low: 'Low',
  };

  static const _colors = {
    ReminderPriority.high: AppColors.chart1,
    ReminderPriority.medium: AppColors.chart4,
    ReminderPriority.low: AppColors.mutedForeground,
  };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReminderFormCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionLabel(
          icon: Icons.flag_rounded,
          label: 'Priority',
        ),
        const SizedBox(height: 12),
        Row(
          children: ReminderPriority.values
              .map((priority) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _PriorityButton(
                        priority: priority,
                        isSelected: priority == selected,
                        onPressed: () => cubit.selectPriority(priority),
                        label: _labels[priority] ?? '',
                        color: _colors[priority] ?? AppColors.muted,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _PriorityButton extends StatelessWidget {
  const _PriorityButton({
    required this.priority,
    required this.isSelected,
    required this.onPressed,
    required this.label,
    required this.color,
  });

  final ReminderPriority priority;
  final bool isSelected;
  final VoidCallback onPressed;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? color : AppColors.muted,
        foregroundColor: isSelected ? Colors.white : AppColors.mutedForeground,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: isSelected ? color : AppColors.border,
        ),
      ),
      child: Text(label),
    );
  }
}
