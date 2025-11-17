import 'package:get_it/get_it.dart';

import '../../features/reminders/bloc/reminder_list_bloc.dart';
import '../../features/reminders/cubit/reminder_form_cubit.dart';
import '../../features/reminders/cubit/reminder_location_cubit.dart';
import '../../features/reminders/data/reminder_repository.dart';
import '../../features/reminders/models/reminder.dart';
import '../services/geofence_service.dart';
import '../services/notification_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerLazySingleton<ReminderNotificationService>(
    () => NotificationService(),
  );
  getIt.registerLazySingleton<ReminderLocationTriggerService>(
    () => ReminderGeofenceService(),
  );

  // Data
  getIt.registerLazySingleton<ReminderRepository>(() => ReminderRepository());

  // Blocs / cubits
  getIt.registerFactory<ReminderListBloc>(() => ReminderListBloc(
        getIt<ReminderRepository>(),
        getIt<ReminderNotificationService>(),
        getIt<ReminderLocationTriggerService>(),
      ));

  getIt.registerFactoryParam<ReminderFormCubit, Reminder?, void>(
    (reminder, _) => ReminderFormCubit(reminder: reminder),
  );

  getIt.registerFactoryParam<ReminderLocationCubit, ReminderFormCubit,
      String?>(
    (formCubit, initialAddress) =>
        ReminderLocationCubit(formCubit, initialAddress: initialAddress),
  );
}
