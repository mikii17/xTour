// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:x_tour/main.dart';
import 'package:x_tour/screens/journal_card.dart';
import 'package:x_tour/screens/postCard.dart';
import 'package:x_tour/custom/avator_custom.dart';

void main() {
  testWidgets('Widget should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(journalCard());

    // Perform assertions on the rendered widget
    expect(find.byType(Text), findsWidgets);
  });
}
