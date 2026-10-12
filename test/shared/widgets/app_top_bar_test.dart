import 'package:alurei/src/imports/imports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget testApp(PreferredSizeWidget appBar) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      builder: (_, __) => MaterialApp(
        theme: buildLightTheme(),
        home: Scaffold(appBar: appBar),
      ),
    );
  }

  testWidgets('detail app bar renders its title and action', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);
    var shared = false;

    await tester.pumpWidget(
      testApp(
        AppTopBar(
          title: 'Shopping Voucher',
          actions: [
            AppTopBarIconAction(
              icon: IconsaxPlusLinear.share,
              onPressed: () => shared = true,
            ),
          ],
        ),
      ),
    );

    expect(find.text('Shopping Voucher'), findsOneWidget);
    await tester.tap(find.byIcon(IconsaxPlusLinear.share));
    expect(shared, isTrue);
  });

  testWidgets('submit app bar forwards submission', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);
    var submitted = false;

    await tester.pumpWidget(
      testApp(
        AppTopBar.withSubmit(
          title: "Eve's Profile",
          submitLabel: 'Save',
          onSubmit: () => submitted = true,
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    expect(submitted, isTrue);
  });

  testWidgets('dashboard app bar shows identity and badges', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testApp(
        AppDashboardTopBar(
          greeting: 'Good Morning',
          userName: 'Deepa Kumari',
          notificationCount: 1,
          messageCount: 2,
          onNotifications: () {},
          onMessages: () {},
        ),
      ),
    );

    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('Deepa Kumari'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('conversation app bar renders presence and language',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      testApp(
        AppConversationTopBar(
          name: 'Deepa Kumari',
          status: 'Online',
          languageLabel: 'En',
          isOnline: true,
          onLanguagePressed: () {},
          onInfoPressed: () {},
        ),
      ),
    );

    expect(find.text('Deepa Kumari'), findsOneWidget);
    expect(find.text('Online'), findsOneWidget);
    expect(find.text('En'), findsOneWidget);
  });
}
