import 'package:caramelo_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App widget builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(Directionality), findsWidgets);
  });
}
