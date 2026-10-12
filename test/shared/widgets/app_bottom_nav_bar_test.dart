import 'package:alurei/src/imports/imports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const destinations = [
    AppBottomNavDestination(label: 'First', assetPath: AppAssets.navToday),
    AppBottomNavDestination(label: 'Second', assetPath: AppAssets.navHome),
  ];

  testWidgets('renders destinations and forwards the selected index',
      (tester) async {
    var tappedIndex = -1;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(440, 956),
        builder: (_, __) => MaterialApp(
          theme: buildLightTheme(),
          home: Scaffold(
            bottomNavigationBar: AppBottomNavBar(
              selectedIndex: 0,
              destinations: destinations,
              onDestinationSelected: (index) => tappedIndex = index,
            ),
          ),
        ),
      ),
    );

    expect(find.text('First'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);

    await tester.tap(find.text('Second'));
    expect(tappedIndex, 1);
  });
}
