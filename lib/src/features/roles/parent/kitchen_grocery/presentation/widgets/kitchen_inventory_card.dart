import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/grocery_item.dart';

class KitchenInventoryCard extends GetView<BaseKitchenController> {
  const KitchenInventoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colors.outline.withAlpha(50),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Filter Chips Bar ──────────────────────────────────────────────
          Obx(() {
            final current = controller.selectedGroceryFilter.value;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    context,
                    filter: GroceryFilter.all,
                    label: 'All',
                    count: controller.allGroceryCount,
                    isSelected: current == GroceryFilter.all,
                    activeBg: context.colors.primary,
                    activeText: AppColors.whiteColor,
                    activeBadgeBg: AppColors.brandTealBorder,
                    activeBadgeText: context.colors.primary,
                    inactiveText: context.appColors.primaryText,
                    inactiveBadgeBg: context.colors.primary,
                    inactiveBadgeText: AppColors.whiteColor,
                  ),
                  SizedBox(width: 8.w),
                   _buildFilterChip(
                    context,
                    filter: GroceryFilter.missing,
                    label: 'Missing',
                    count: controller.missingGroceryCount,
                    isSelected: current == GroceryFilter.missing,
                    activeBg: AppColors.groceryMissingRed,
                    activeText: AppColors.whiteColor,
                    activeBadgeBg: AppColors.whiteColor,
                    activeBadgeText: AppColors.groceryMissingRed,
                    inactiveText: AppColors.groceryMissingRed,
                    inactiveBadgeBg: AppColors.groceryMissingRed,
                    inactiveBadgeText: AppColors.whiteColor,
                  ),
                  SizedBox(width: 8.w),
                  _buildFilterChip(
                    context,
                    filter: GroceryFilter.low,
                    label: 'Low',
                    count: controller.lowGroceryCount,
                    isSelected: current == GroceryFilter.low,
                    activeBg: AppColors.groceryWarningOrange,
                    activeText: AppColors.whiteColor,
                    activeBadgeBg: AppColors.whiteColor,
                    activeBadgeText: AppColors.groceryWarningOrange,
                    inactiveText: AppColors.warning500,
                    inactiveBadgeBg: AppColors.warning500,
                    inactiveBadgeText: AppColors.whiteColor,
                  ),
                  SizedBox(width: 8.w),
                  _buildFilterChip(
                    context,
                    filter: GroceryFilter.stock,
                    label: 'Stock',
                    count: controller.stockGroceryCount,
                    isSelected: current == GroceryFilter.stock,
                    activeBg: AppColors.groceryStockGreen,
                    activeText: AppColors.whiteColor,
                    activeBadgeBg: AppColors.whiteColor,
                    activeBadgeText: AppColors.groceryStockGreen,
                    inactiveText: AppColors.groceryStockGreen,
                    inactiveBadgeBg: AppColors.groceryStockGreen,
                    inactiveBadgeText: AppColors.whiteColor,
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 16.h),

          // ── Shopping Summary Banner ───────────────────────────────────────
          Obx(() {
            final itemCount = controller.shoppingListItems.length;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: context.appColors.primaryBackground,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: AppColors.supportingOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.icItem,
                        width: 22.w,
                        height: 22.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$itemCount items to buy',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: context.appColors.primaryText,
                            height: 24 / 16,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'View your list and restock your kitchen.',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: context.appColors.secondaryText,
                            height: 18 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      controller.openShoppingListInTab();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Text(
                        'View List',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required GroceryFilter filter,
    required String label,
    required int count,
    required bool isSelected,
    required Color activeBg,
    required Color activeText,
    required Color activeBadgeBg,
    required Color activeBadgeText,
    required Color inactiveText,
    required Color inactiveBadgeBg,
    required Color inactiveBadgeText,
  }) {
    return GestureDetector(
      onTap: () => controller.selectGroceryFilter(filter),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : context.appColors.primaryBackground,
          borderRadius: BorderRadius.circular(9999.r),
          border: Border.all(
            color: isSelected && filter == GroceryFilter.all
                ? AppColors.inventorySelectedBorder
                : Colors.transparent,
            width: 0.5.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeText : inactiveText,
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              width: 22.w,
              height: 22.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? activeBadgeBg
                    : (filter == GroceryFilter.all
                        ? context.appColors.kitchenInventoryUnselectedBg
                        : inactiveBadgeBg),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? activeBadgeText
                      : (filter == GroceryFilter.all
                          ? inactiveText
                          : inactiveBadgeText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
