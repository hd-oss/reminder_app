import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reminder_app/main.dart';

void main() {
  testWidgets('renders home screen with reminders', (tester) async {
    await tester.pumpWidget(const ReminderApp());

    expect(find.text('Reminders'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
