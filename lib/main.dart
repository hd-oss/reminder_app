import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'features/reminders/bloc/reminder_list_bloc.dart';
import 'features/reminders/data/reminder_repository.dart';
import 'features/reminders/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = ReminderRepository();
  runApp(ReminderApp(repository: repository));
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key, required this.repository});

  final ReminderRepository repository;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) =>
            ReminderListBloc(repository)..add(const ReminderListEvent.remindersRequested()),
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
