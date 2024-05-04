import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/news/presentation/widgets/news_details/custom_text.dart';

void main() {
  testWidgets('CustomText renders with correct text, fontSize, and fontWeight', (WidgetTester tester) async {
    // Build the CustomText widget with test parameters
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomText(
            text: 'Hello, world!',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    // Verify that the text is rendered with the correct properties
    expect(find.text('Hello, world!'), findsOneWidget);
    final textWidget = tester.widget<Text>(find.text('Hello, world!'));
    expect(textWidget.style!.fontSize, 20);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
  });

  testWidgets('CustomText renders with default fontSize and fontWeight when not provided', (WidgetTester tester) async {
    // Build the CustomText widget with only the required text parameter
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomText(
            text: 'Hello, world!',
          ),
        ),
      ),
    );

    // Verify that the text is rendered with default properties
    expect(find.text('Hello, world!'), findsOneWidget);
    final textWidget = tester.widget<Text>(find.text('Hello, world!'));
    expect(textWidget.style!.fontSize, 14); // Default fontSize
    expect(textWidget.style!.fontWeight, FontWeight.normal); // Default fontWeight
  });
}
