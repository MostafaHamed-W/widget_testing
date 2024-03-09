import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';

class Robot {
  Robot(this.tester) : authRobot = AuthRobot(tester);
  final WidgetTester tester;
  final AuthRobot authRobot;

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
}
