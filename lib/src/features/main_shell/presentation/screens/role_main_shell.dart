import 'package:alurei/src/features/roles/nanny/kitchen/presentation/screens/nanny_kitchen_screen.dart';
import 'package:alurei/src/features/roles/parent/care/presentation/screens/parent_care_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/screens/parent_kitchen_screen.dart';
import 'package:alurei/src/imports/imports.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/providers/session_controller.dart';
import '../../../roles/parent/activities/presentation/screens/parent_activities_screen.dart';
import '../../../roles/parent/today/presentation/screens/parent_today_screen.dart';
import '../controllers/role_main_controller.dart';
import '../widgets/role_placeholder_screen.dart';

/// Authenticated five-tab shell whose content follows the persisted API role.
class RoleMainShell extends GetView<RoleMainController> {
  const RoleMainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = Get.find<SessionController>().user.value;
        if (user == null) {
          return const Scaffold(body: AppLoading());
        }

        final pages =
            user.role == AppUserRole.parent ? _parentPages() : _nannyPages();
        final selectedIndex = controller.selectedIndex.value;
        return Scaffold(
          body: SizedBox.expand(
            child: IndexedStack(
              index: selectedIndex,
              children: pages,
            ),
          ),
          bottomNavigationBar: AppBottomNavBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: controller.selectDestination,
          ),
        );
      },
    );
  }

  List<Widget> _parentPages() => [
        const ParentTodayScreen(showBottomNavigationBar: false),
        const ParentKitchenScreen(),
        const ParentActivitiesScreen(),
        const ParentCareScreen(),
        const HomePage(),
      ];

  List<Widget> _nannyPages() => [
        RolePlaceholderScreen(
          title: LangKey.mainShell.nannyToday,
          icon: IconsaxPlusLinear.calendar_1,
        ),
        const NannyKitchenScreen(),
        RolePlaceholderScreen(
          title: LangKey.mainShell.nannyActivities,
          icon: IconsaxPlusLinear.activity,
        ),
        RolePlaceholderScreen(
          title: LangKey.mainShell.nannyCare,
          icon: IconsaxPlusLinear.heart,
        ),
        const HomePage(),
      ];
}
