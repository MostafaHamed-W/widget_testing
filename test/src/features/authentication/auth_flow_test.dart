import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  testWidgets('Auth full flow test', (tester) async {
    final r = Robot(tester);
    await r.pumbMyApp();
    await r.expectFindAllProductsCard();
  });
}
