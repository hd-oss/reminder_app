import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reminder_app/main.dart';
import 'package:reminder_app/features/reminders/data/reminder_repository.dart';
import 'package:reminder_app/features/reminders/models/reminder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders home screen with reminders', (tester) async {
    final repository = _FakeReminderRepository();

    await tester.pumpWidget(ReminderApp(repository: repository));
    await tester.pump();

    expect(find.text('Reminders'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}

class _FakeReminderRepository extends ReminderRepository {
  _FakeReminderRepository() : super(database: null);

  final List<Reminder> _items = [];

  @override
  Future<List<Reminder>> fetchReminders() async => List.unmodifiable(_items);

  @override
  Future<void> saveReminder(Reminder reminder) async {
    _items.removeWhere((item) => item.id == reminder.id);
    _items.add(reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    _items.removeWhere((item) => item.id == id);
  }
}
