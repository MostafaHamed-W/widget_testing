import 'package:ecommerce_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>({
    const Size(300, 600),
    const Size(600, 800),
    const Size(1001, 1000),
  });
  testWidgets(
    'Golden - products list',
    (tester) async {
      final r = Robot(tester);
      await r.golden.setSurfaceSize(sizeVariant.currentValue!);
      await r.golden.loadRobotoFont();
      await r.golden.loadMaterialIconFont();
      await r.pumbMyApp();
      await r.golden.precacheImages();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile(
            'products_list_${sizeVariant.currentValue!.width} * ${sizeVariant.currentValue!.height}.png'),
      );
    },
    variant: sizeVariant,
    tags: ['golden'],
    skip: true,
  );
}
