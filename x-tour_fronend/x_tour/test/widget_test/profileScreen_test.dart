import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:x_tour/custom/xtour_appBar.dart';
import 'package:x_tour/screens/screens.dart';
import 'package:x_tour/user/screens/profileScreen.dart';



void main() {
  testWidgets('ProfileScreen Widget Test', (WidgetTester tester) async {
     await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
    
    final xTourAppBarh = find.byType(XTourAppBar);
    expect(xTourAppBarh, findsOneWidget);

    final circularAvatar = find.byType(CircleAvatar);
    expect(circularAvatar, findsOneWidget);

    final followerText = find.text('Followers');
    expect(followerText, findsOneWidget);

    final followingText = find.text('Following');
    expect(followingText, findsOneWidget);

    final photoLibraryicon = find.byIcon(Icons.photo_library);
    expect(photoLibraryicon, findsOneWidget);

    final articleOutlinedicon = find.byIcon(Icons.article_outlined);
    expect(articleOutlinedicon, findsOneWidget);

    final bookmarkAddicon = find.byIcon(Icons.bookmark_add);
    expect(bookmarkAddicon, findsOneWidget);
  

    await tester.tap(find.byIcon(Icons.photo_library));
    await tester.pump();

    expect((tester.widget<Icon>(find.byIcon(Icons.photo_library)).color),
        Colors.blue);

    await tester.tap(find.byIcon(Icons.article_outlined));   
    await tester.pump();

    final journalIcon = find.byIcon(Icons.article_outlined);
    expect((tester.widget<Icon>(journalIcon).color),
        Colors.blue);

    final bookmarkIcon = find.byIcon(Icons.bookmark_add);
    await tester.tap(bookmarkIcon);
    await tester.pump();

    
    expect((tester.widget<Icon>(bookmarkIcon).color),
        Colors.blue);

    expect(find.byType(GridView), findsOneWidget);

    final iconFinder = find.byIcon(Icons.menu);
    expect(iconFinder, findsOneWidget);

    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    final menuDialogFinder = find.byType(Dialog);

    expect(menuDialogFinder, findsOneWidget);

    final pendingPostFinder = find.widgetWithText(ListTile, 'Pending Post');
    final pendingJournalFinder = find.widgetWithText(ListTile, 'Pending Journal');
    final logoutFinder = find.widgetWithText(ListTile, 'Logout');

    expect(pendingPostFinder, findsOneWidget);
    expect(pendingJournalFinder, findsOneWidget);
    expect(logoutFinder, findsOneWidget);

    final followerGesture = find.byKey(const Key('followerGesture'));
    expect(followerGesture, findsOneWidget);
    await tester.tap(followerGesture);
    await tester.pumpAndSettle();

    final followerDialogFinder = find.byType(Dialog);
    expect(followerDialogFinder, findsOneWidget);

    final followerDialogTextFinder = find.text('Followers');
    expect(followerDialogTextFinder, findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(followerDialogFinder, findsNothing);

    final followingGesture = find.byKey(const Key('followingGesture'));
    expect(followingGesture, findsOneWidget);
    await tester.tap(followingGesture);
    await tester.pumpAndSettle();

     await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
  });
}
