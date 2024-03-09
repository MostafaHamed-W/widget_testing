import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  late FakeAuthRepository authRepository;
  setUp(() {
    authRepository = MockAuthRepository();
  });

  group(
    'Sign in screen',
    () {
      testWidgets(
        '''Given form type is signin
        when tap on sign-in button
        signinWithEmailAndPassword fn is not called''',
        (tester) async {
          AuthRobot r = AuthRobot(tester);
          await r.pumbEmailAndPasswordSigninScreen(
            formType: EmailPasswordSignInFormType.signIn,
            authRepository: authRepository,
          );
          await r.tapEmailAndPasswordSubmitButton();
          expect(find.text("Email can't be empty"), findsOneWidget);

          verifyNever(
            () => authRepository.signInWithEmailAndPassword(
              any(),
              any(),
            ),
          );
        },
      );
    },
  );
}
