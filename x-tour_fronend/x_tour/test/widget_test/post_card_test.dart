import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:x_tour/screens/postCard.dart';
import 'package:x_tour/screens/commentScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';

void main() {
  testWidgets('PostCard should render correctly', (WidgetTester tester) async {
    // Build the PostCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostCard(
            post: null, // Provide any necessary post data here
            user: null, // Provide any necessary user data here
          ),
        ),
      ),
    );

    // Verify that the description button is displayed
    expect(find.text('View description'), findsOneWidget);

    // Tap the description button
    await tester.tap(find.text('View description'));
    await tester.pump();

    // Verify that the additional text is displayed

    // Verify that the comment section is displayed
    expect(find.byType(Text), findsWidgets);
    expect(find.text('I am gonna kill you'), findsOneWidget);
    expect(find.text('well done boys'), findsOneWidget);
    expect(find.text('amigos bitch'), findsOneWidget);

    // // // Tap the 'view all comments' text
    // await tester.tap(find.text('view all 16 comments'));
    // await tester.pump();

    // // Verify that the comments screen is pushed
    // expect(find.byType(XtourCommentSection), findsOneWidget);
    // Verify that the photo list is displayed
    expect(find.byType(PageView), findsOneWidget);

    // Verify that the DotsIndicator is displayed
    expect(find.byType(DotsIndicator), findsOneWidget);

    // Tap the first dot in the DotsIndicator
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).color ==
            Color.fromARGB(255, 167, 212, 228)));
    await tester.pump();

    // Verify that the icons are displayed and tappable
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
    expect(find.byIcon(Icons.comment_outlined), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_add_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    await tester.tap(find.byIcon(Icons.comment_outlined));
    await tester.tap(find.byIcon(Icons.share));
    await tester.tap(find.byIcon(Icons.bookmark_add_rounded));
    await tester.pump();

    // Verify that the current page is updated
    expect(find.text('Page: 0'), findsOneWidget);

    // Tap the second dot in the DotsIndicator
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).color == Colors.grey));
    await tester.pump();

    // Verify that the current page is updated
    expect(find.text('Page: 1'), findsOneWidget);

    // Tap the third dot in the DotsIndicator
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).color == Colors.grey));
    await tester.pump();

    // Verify that the current page is updated
    expect(find.text('Page: 2'), findsOneWidget);

    // You can add additional assertions or verifications for the photo list if needed
  });
}
