import 'package:flutter_test/flutter_test.dart';

import '../../auth_robot.dart';

void main() {
  testWidgets(
    'Pump account screen',
    (tester) async {
      final r = AuthRobot(tester);
      await r.pumpAccountScreenWidget();
      await r.tapLogoutButton();
      await r.expectLogoutDialogFound();
      await r.tapCancelLogoutButton();
      await r.expectLogoutDialogNotFound();
    },
  );
}
