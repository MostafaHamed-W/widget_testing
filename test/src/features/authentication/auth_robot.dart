import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountScreenWidget() async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    final finder = find.text('Logout');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
  }

  Future<void> expectLogoutDialogFound() async {
    final alertDialogFinder = find.text('Are you sure?');
    expect(alertDialogFinder, findsOneWidget);
  }

  Future<void> tapCancelLogoutButton() async {
    final cancelButtonFinder = find.text('Cancel');
    expect(cancelButtonFinder, findsOneWidget);
    await tester.tap(cancelButtonFinder);
    await tester.pump();
  }

  Future<void> expectLogoutDialogNotFound() async {
    final alertDialogFinder = find.text('Are you sure?');
    expect(alertDialogFinder, findsNothing);
  }
}
