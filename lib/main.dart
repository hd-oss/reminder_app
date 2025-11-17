import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/di/injection.dart';
import 'core/services/geofence_service.dart';
import 'core/services/notification_service.dart';
import 'features/reminders/bloc/reminder_list_bloc.dart';
import 'features/reminders/data/reminder_repository.dart';
import 'features/reminders/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final notificationService = getIt<ReminderNotificationService>();
  final geofenceService = getIt<ReminderLocationTriggerService>();

  await notificationService.initialize();
  await geofenceService.initialize();

  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getIt<ReminderRepository>()),
        RepositoryProvider<ReminderNotificationService>.value(
            value: getIt<ReminderNotificationService>()),
        RepositoryProvider<ReminderLocationTriggerService>.value(
            value: getIt<ReminderLocationTriggerService>()),
      ],
      child: BlocProvider(
        create: (context) => getIt<ReminderListBloc>()
          ..add(const ReminderListEvent.remindersRequested()),
        child: MaterialApp(
          title: 'Reminder App',
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
