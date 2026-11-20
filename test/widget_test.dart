import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:studytrack/app/app.dart';
import 'package:studytrack/features/auth/viewmodels/login_view_model.dart';

void main() {
  group('LoginViewModel', () {
    final viewModel = LoginViewModel();

    test('validates email', () {
      expect(viewModel.validateEmail(''), 'Enter your email.');
      expect(
        viewModel.validateEmail('not-an-email'),
        'Enter a valid email address.',
      );
      expect(viewModel.validateEmail(' student@example.com '), isNull);
    });

    test('validates password', () {
      expect(viewModel.validatePassword(''), 'Enter your password.');
      expect(viewModel.validatePassword('secret'), isNull);
    });
  });

  testWidgets('shows login screen', (tester) async {
    await tester.pumpWidget(const StudyTrackApp());

    expect(find.text('StudyTrack'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Log in'), findsOneWidget);
  });

  testWidgets('shows validation errors for empty form', (tester) async {
    await tester.pumpWidget(const StudyTrackApp());

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Enter your email.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);
  });

  testWidgets('shows error for wrong credentials', (tester) async {
    await tester.pumpWidget(const StudyTrackApp());

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'student@example.com');
    await tester.enterText(fields.at(1), 'wrong');
    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Wrong email or password. Try again.'), findsOneWidget);
  });

  testWidgets('signs in with demo account', (tester) async {
    await tester.pumpWidget(const StudyTrackApp());

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'student@example.com');
    await tester.enterText(fields.at(1), 'StudyTrack123');
    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Demo login successful.'), findsOneWidget);
  });
}
