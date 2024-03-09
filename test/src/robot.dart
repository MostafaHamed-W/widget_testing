import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';
import 'goldens/golden_robot.dart';

class Robot {
  Robot(this.tester)
      : authRobot = AuthRobot(tester),
        golden = GoldenRobot(tester);
  final WidgetTester tester;
  final AuthRobot authRobot;
  final GoldenRobot golden;

  Future<void> pumbMyApp({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null) authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MaterialApp(
          home: MyApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> expectFindAllProductsCard() async {
    final productCardFinder = find.byType(ProductCard);
    expect(productCardFinder, findsNWidgets(kTestProducts.length));
  }

  Future<void> tapDropDownButton() async {
    final finder = find.byType(MoreMenuButton);
    // we want to interact with this widget if it is found so we use evaluate
    final matches = finder.evaluate();
    if (matches.isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }
}
