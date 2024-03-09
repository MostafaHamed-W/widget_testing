import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets(
    'Cancel logout success test',
    (tester) async {
      final r = AuthRobot(tester);
      await r.pumpAccountScreenWidget();
      await r.tapLogoutButton();
      await r.expectLogoutDialogFound();
      await r.tapCancelLogoutButton();
      await r.expectLogoutDialogNotFound();
    },
  );

  testWidgets(
    'Submit logout sucess',
    (tester) async {
      final r = AuthRobot(tester);
      await r.pumpAccountScreenWidget();
      await r.tapLogoutButton();
      await r.expectLogoutDialogFound();
      await r.tapAlertLogoutButton();
      await r.expectLogoutDialogNotFound();
      await r.expectErrorNotFound();
    },
  );
  testWidgets(
    'Submit logout failure',
    (tester) async {
      final r = AuthRobot(tester);
      final mockAuthRepository = MockAuthRepository();

      final exception = Exception('Connection Failure');
      when(mockAuthRepository.signOut).thenThrow(exception);
      when(mockAuthRepository.authStateChanges).thenAnswer(
        (_) => Stream.value(
          const AppUser(uid: 'wafy', email: 'xwafy@gmail.com'),
        ),
      );
      await r.pumpAccountScreenWidget(authRepository: mockAuthRepository);
      await r.tapLogoutButton();
      await r.tapAlertLogoutButton();
      await r.expectErrorFound();
    },
  );
}
