import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/geofence_service.dart';
import 'core/notification_service.dart';
import 'features/reminders/bloc/reminder_list_bloc.dart';
import 'features/reminders/data/reminder_repository.dart';
import 'features/reminders/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.initialize();
  final geofenceService = ReminderGeofenceService();
  await geofenceService.initialize();
  final repository = ReminderRepository();
  runApp(ReminderApp(
    repository: repository,
    notificationService: notificationService,
    geofenceService: geofenceService,
  ));
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({
    super.key,
    required this.repository,
    required this.notificationService,
    required this.geofenceService,
  });

  final ReminderRepository repository;
  final ReminderNotificationService notificationService;
  final ReminderLocationTriggerService geofenceService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
        RepositoryProvider<ReminderNotificationService>.value(
            value: notificationService),
        RepositoryProvider<ReminderLocationTriggerService>.value(
            value: geofenceService),
      ],
      child: BlocProvider(
        create: (context) => ReminderListBloc(
          repository,
          notificationService,
          geofenceService,
        )..add(const ReminderListEvent.remindersRequested()),
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
