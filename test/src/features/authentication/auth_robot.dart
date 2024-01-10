import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:ecommerce_app/src/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumbEmailAndPasswordSigninScreen({
    required EmailPasswordSignInFormType formType,
    final VoidCallback? onSignedIn,
    FakeAuthRepository? authRepository,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null) authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MaterialApp(
          home: EmailPasswordSignInContents(
            onSignedIn: onSignedIn,
            formType: EmailPasswordSignInFormType.signIn,
          ),
        ),
      ),
    );
  }

  Future<void> pumpAccountScreenWidget({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null) authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> openEmailPasswordSignInScreen() async {
    final finder = find.byKey(MoreMenuButton.signInKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
  }

  Future<void> enterPassword(String password) async {
    final passwordField = find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final primaryButton = find.byType(PrimaryButton);
    await tester.tap(primaryButton);
    await tester.pump();
  }

  Future<void> tapLogoutButton() async {
    final finder = find.text('Logout');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
  }

  Future<void> expectLogoutDialogFound() async {
    final alertDialogFinder = find.byKey(kAlertDialogKey);
    expect(alertDialogFinder, findsOneWidget);
  }

  Future<void> tapCancelLogoutButton() async {
    final cancelButtonFinder = find.text('Cancel');
    expect(cancelButtonFinder, findsOneWidget);
    await tester.tap(cancelButtonFinder);
    await tester.pump();
  }

  Future<void> tapAlertLogoutButton() async {
    final logoutButtonFinder = find.byKey(kAlertLogoutKey);
    expect(logoutButtonFinder, findsOneWidget);
    await tester.tap(logoutButtonFinder);
    await tester.pump();
  }

  Future<void> expectLogoutDialogNotFound() async {
    final alertDialogFinder = find.byKey(kAlertDialogKey);
    expect(alertDialogFinder, findsNothing);
  }

  Future<void> expectErrorFound() async {
    final errorFinder = find.text('Error');
    expect(errorFinder, findsOneWidget);
  }

  Future<void> expectErrorNotFound() async {
    final errorFinder = find.text('Error');
    expect(errorFinder, findsNothing);
  }

  Future<void> expectLoadingIndicator() async {
    final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
    expect(loadingIndicatorFinder, findsOneWidget);
  }
}
