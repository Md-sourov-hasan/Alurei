import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';
import '../controllers/base_kitchen_controller.dart';

class KitchenTabSwitcher extends GetView<BaseKitchenController> {
  const KitchenTabSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isRecipes = controller.selectedTab.value == KitchenTab.recipes;
      return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: context.appColors.bottomNavSelectedBackground,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Row(
            children: [
              _TabButton(
                label: LangKey.parentKitchen.recipes,
                isSelected: isRecipes,
                onTap: () => controller.selectTab(KitchenTab.recipes),
              ),
              _TabButton(
                label: LangKey.parentKitchen.groceries,
                isSelected: !isRecipes,
                onTap: () => controller.selectTab(KitchenTab.groceries),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.transparentColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              height: 28 / 18,
              color:
                  isSelected ? AppColors.whiteColor : AppColors.blackTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
