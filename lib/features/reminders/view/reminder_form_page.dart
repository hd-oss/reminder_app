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
              centerTitle: true,
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
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 160),
              child: Column(
                children: [
                  ReminderTitleField(value: state.title),
                  const SizedBox(height: 16),
                  ReminderDescriptionField(value: state.description),
                  const SizedBox(height: 16),
                  ReminderTypeSelector(isLocationReminder: state.locationBased),
                  const SizedBox(height: 16),
                  if (!state.locationBased) ...[
                    ReminderDateSection(date: state.date),
                    const SizedBox(height: 16),
                    ReminderTimeSection(times: state.times),
                    const SizedBox(height: 16),
                    ReminderRepeatSection(selected: state.repeat),
                    const SizedBox(height: 16),
                  ],
                  if (state.locationBased) ...[
                    ReminderLocationSection(
                      latitude: state.latitude,
                      longitude: state.longitude,
                    ),
                    const SizedBox(height: 16),
                  ],
                  ReminderCategorySection(selected: state.category),
                  const SizedBox(height: 16),
                  ReminderPrioritySection(selected: state.priority),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
    final bloc = context.read<ReminderListBloc>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<ReminderFormCubit>();
    late final Reminder reminder;

    try {
      reminder = cubit.buildReminder();
    } on ReminderValidationException catch (error) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error.message)));
      return;
    }

    void onSuccess() {
      if (!navigator.mounted) return;
      navigator.pop();
    }

    void onError(String message) {
      if (!messenger.mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    if (isEditing) {
      bloc.add(ReminderListEvent.reminderUpdated(
        reminder,
        onSuccess: onSuccess,
        onError: onError,
      ));
    } else {
      bloc.add(ReminderListEvent.reminderAdded(
        reminder,
        onSuccess: onSuccess,
        onError: onError,
      ));
    }
  }

  void _deleteReminder(BuildContext context, Reminder reminder) {
    final bloc = context.read<ReminderListBloc>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    void onSuccess() {
      if (!navigator.mounted) return;
      navigator.pop();
    }

    void onError(String message) {
      if (!messenger.mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    bloc.add(ReminderListEvent.reminderDeleted(
      reminder.id,
      onSuccess: onSuccess,
      onError: onError,
    ));
  }
}
