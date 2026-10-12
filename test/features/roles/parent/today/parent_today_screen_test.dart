import 'package:alurei/src/features/roles/parent/today/presentation/bindings/parent_today_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/controllers/parent_today_controller.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/parent_today_screen.dart';
import 'package:alurei/src/imports/imports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  tearDown(Get.reset);

  testWidgets('renders the Figma-backed timeline and adds a child',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('fil'),
          Locale('si'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: ScreenUtilInit(
          designSize: const Size(440, 956),
          builder: (context, __) => GetMaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialBinding: ParentTodayBinding(),
            home: const ParentTodayScreen(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Monica Steve'), findsOneWidget);
    expect(find.text('Eve', skipOffstage: false), findsOneWidget);
    expect(find.text('Rose', skipOffstage: false), findsOneWidget);
    final addChild = find.text('Add child', skipOffstage: false);
    expect(addChild, findsOneWidget);
    expect(find.byType(AppBottomNavBar), findsOneWidget);

    await Get.find<ParentTodayController>().addChild();
    await tester.pumpAndSettle();

    expect(find.text('Child 1', skipOffstage: false), findsOneWidget);
  });
}
