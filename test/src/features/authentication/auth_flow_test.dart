import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  const testEmail = 'test@gmail.com';
  const testPassword = '123456';

  testWidgets('Auth full flow test', (tester) async {
    final r = Robot(tester);
    await r.pumbMyApp();
    await r.expectFindAllProductsCard();
    await r.tapDropDownButton();
    expect(find.byKey(MoreMenuButton.signInKey), findsOneWidget);
    await r.authRobot.openEmailPasswordSignInScreen();
    await r.authRobot.signinWithEmailAndPassword(testEmail, testPassword);
  });
}
