import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Pump account screen',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AccountScreen(),
          ),
        ),
      );

      final finder = find.text('Logout');
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pump();
      final alertDialogFinder = find.text('Are you sure?');
      expect(alertDialogFinder, findsOneWidget);
      final cancelButtonFinder = find.text('Cancel');
      expect(cancelButtonFinder, findsOneWidget);
      await tester.tap(cancelButtonFinder);
      await tester.pump();
      expect(alertDialogFinder, findsNothing);
    },
  );
}
