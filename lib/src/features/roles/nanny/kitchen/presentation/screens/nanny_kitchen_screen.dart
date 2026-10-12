import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/kitchen_groceries_section.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/domain/entities/kitchen_recipe.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/kitchen_all_recipes_section.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/kitchen_filter_chips.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/kitchen_search_bar.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/kitchen_suggested_section.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/kitchen_tab_switcher.dart';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/shared/widgets/parent_ai_assistant_button.dart';

import '../controllers/nanny_kitchen_controller.dart';

class NannyKitchenScreen extends GetView<NannyKitchenController> {
  const NannyKitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Obx(() {
      final d = controller.data.value;
      final isRecipes = controller.selectedTab.value == KitchenTab.recipes;
      final user = Get.isRegistered<SessionController>()
          ? Get.find<SessionController>().user.value
          : null;
      final name = user?.fullName;
      final userName =
          (name != null && name.trim().isNotEmpty) ? name : 'Nanny Caregiver';
      final avatar = user?.profilePictureUrl;
      final avatarUrl = (avatar != null && avatar.isNotEmpty)
          ? avatar
          : AppAssets.parentTodayParentAvatar;

      return Scaffold(
        backgroundColor: appColors.primaryBackground,
        appBar: AppDashboardTopBar(
          greeting: LangKey.parentToday.goodMorning,
          userName: userName,
          avatarUrl: avatarUrl,
          notificationCount: controller.notificationCount.value,
          messageCount: controller.messageCount.value,
          onNotifications: controller.openNotifications,
          onMessages: controller.openMessages,
          toolbarHeight: 83,
        ),
        body: d == null
            ? const AppLoading()
            : Stack(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOutCubic,
                    switchOutCurve: Curves.easeInOutCubic,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final isRecipesTab =
                          (child.key as ValueKey<String>?)?.value ==
                              'recipes_tab';
                      final offsetAnimation = Tween<Offset>(
                        begin: isRecipesTab
                            ? const Offset(-0.2, 0)
                            : const Offset(0.2, 0),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: isRecipes
                        ? CustomScrollView(
                            key: const ValueKey('recipes_tab'),
                            slivers: [
                              const SliverToBoxAdapter(
                                child: KitchenTabSwitcher(),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      KitchenSearchBar(
                                        onSearchChanged:
                                            controller.updateSearch,
                                        initialValue:
                                            controller.searchQuery.value,
                                        onFilterPressed:
                                            controller.toggleFilters,
                                      ),
                                      if (controller.showFilters.value) ...[
                                        SizedBox(height: 16.h),
                                        const KitchenFilterChips(),
                                      ],
                                      SizedBox(height: 24.h),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: KitchenSuggestedSection(data: d),
                              ),
                              const SliverToBoxAdapter(
                                child: KitchenAllRecipesSection(),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(height: 32.h),
                              ),
                            ],
                          )
                        : const CustomScrollView(
                            key: ValueKey('groceries_tab'),
                            slivers: [
                              SliverToBoxAdapter(
                                child: KitchenTabSwitcher(),
                              ),
                              SliverToBoxAdapter(
                                child: KitchenGroceriesSection(),
                              ),
                            ],
                          ),
                  ),
                  Positioned(
                    right: 16.w,
                    bottom: 90.h,
                    child: ParentAiAssistantButton(
                      menuOpen: controller.isAiMenuOpen.value,
                      onPressed: controller.toggleAiMenu,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
