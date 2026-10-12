import 'package:alurei/src/features/roles/nanny/kitchen/presentation/bindings/nanny_kitchen_binding.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/bindings/parent_kitchen_binding.dart';
import 'package:alurei/src/features/home/presentation/bindings/home_binding.dart';
import 'package:get/get.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/providers/session_controller.dart';
import '../../../roles/parent/activities/presentation/bindings/parent_activities_binding.dart';
import '../../../roles/parent/care/presentation/bindings/parent_care_binding.dart';
import '../../../roles/parent/today/presentation/bindings/parent_today_binding.dart';
import '../controllers/role_main_controller.dart';

/// Registers dependencies needed by the authenticated role's main shell.
class RoleMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleMainController>(RoleMainController.new);
    HomeBinding().dependencies();

    final role = Get.find<SessionController>().user.value?.role;
    if (role == null || role == AppUserRole.parent) {
      ParentTodayBinding().dependencies();
      ParentKitchenBinding().dependencies();
      ParentActivitiesBinding().dependencies();
      ParentCareBinding().dependencies();
    } else {
      NannyKitchenBinding().dependencies();
    }
  }
}
