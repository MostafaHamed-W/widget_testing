import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  late FakeAuthRepository authRepository;
  const testEmail = 'test@gmail.com';
  const testPassword = '123456';
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

      testWidgets(
        '''Given form type is signin
        when tap on sign-in button
        signinWithEmailAndPassword called
        And onSignedIn callback is called
         And error alert is not shown''',
        (tester) async {
          bool didSignIn = false;
          when(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword)).thenAnswer(
            (_) => Future.value(),
          );
          AuthRobot r = AuthRobot(tester);
          await r.pumbEmailAndPasswordSigninScreen(
            formType: EmailPasswordSignInFormType.signIn,
            authRepository: authRepository,
            onSignedIn: () => didSignIn = true,
          );
          await r.enterEmail(testEmail);
          await r.enterPassword(testPassword);
          await r.tapEmailAndPasswordSubmitButton();
          verify(
            () => authRepository.signInWithEmailAndPassword(testEmail, testPassword),
          ).called(1);
          await r.expectErrorNotFound();
          expect(didSignIn, true);
        },
      );
    },
  );
}
