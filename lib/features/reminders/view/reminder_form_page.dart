import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_theme.dart';
import '../bloc/reminder_list_bloc.dart';
import '../cubit/reminder_form_cubit.dart';
import '../models/reminder.dart';
import 'widgets/reminder_form_sections.dart';
import 'widgets/reminder_location_section.dart';

class ReminderFormPage extends StatelessWidget {
  const ReminderFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderFormCubit, ReminderFormState>(
      builder: (context, state) {
        final isEditing = state.editing != null;
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              title: Text(
                isEditing ? 'Edit Reminder' : 'Add Reminder',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              )),
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 160),
              child: Column(
                children: [
                  ReminderTitleField(value: state.title),
                  const SizedBox(height: 20),
                  ReminderTimeSection(times: state.times),
                  const SizedBox(height: 20),
                  ReminderDateSection(date: state.date),
                  const SizedBox(height: 20),
                  ReminderRepeatSection(selected: state.repeat),
                  const SizedBox(height: 20),
                  ReminderLocationSection(
                      enabled: state.locationBased,
                      latitude: state.latitude,
                      longitude: state.longitude),
                  const SizedBox(height: 20),
                  ReminderCategorySection(selected: state.category),
                  const SizedBox(height: 20),
                  ReminderPrioritySection(selected: state.priority),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () => _submitReminder(context, isEditing),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(isEditing ? 'Update Reminder' : 'Save Reminder',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                  ),
                  if (isEditing) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => _deleteReminder(context, state.editing!),
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                          side: const BorderSide(color: AppColors.destructive),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: Text('Delete Reminder',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.destructive)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitReminder(BuildContext context, bool isEditing) {
    final reminder = context.read<ReminderFormCubit>().buildReminder();
    final bloc = context.read<ReminderListBloc>();
    if (isEditing) {
      bloc.add(ReminderListEvent.reminderUpdated(reminder));
    } else {
      bloc.add(ReminderListEvent.reminderAdded(reminder));
    }
    Navigator.of(context).pop();
  }

  void _deleteReminder(BuildContext context, Reminder reminder) {
    context
        .read<ReminderListBloc>()
        .add(ReminderListEvent.reminderDeleted(reminder.id));
    Navigator.of(context).pop();
  }
}
