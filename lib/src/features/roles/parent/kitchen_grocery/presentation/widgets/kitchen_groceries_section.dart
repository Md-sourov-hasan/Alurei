import 'dart:math' as math;
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/add_grocery_item_sheet.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/grocery_item_card.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/kitchen_inventory_card.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/shopping_list_item_card.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/shared/helpers/dotted_border_painter.dart';

class KitchenGroceriesSection extends GetView<BaseKitchenController> {
  const KitchenGroceriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isShoppingList = controller.showShoppingListInTab.value;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isShoppingList
              ? _buildShoppingListView(context)
              : _buildInventoryView(context),
        ),
      );
    });
  }

  // ── 1. Initial Kitchen Inventory View ─────────────────────────────────────
  Widget _buildInventoryView(BuildContext context) {
    return Column(
      key: const ValueKey('inventory_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),

        // ── 1. Kitchen Inventory Card (Summary Filters & "View List" Banner) ──
        const KitchenInventoryCard(),

        SizedBox(height: 16.h),

        // ── 2. "+ Add Item" Button ──────────────────────────────────────────
        GestureDetector(
          onTap: () {
            showAppSheet<void>(
              child: const AddGroceryItemSheet(),
            );
          },
          child: CustomPaint(
            painter: DottedBorderPainter(
              color: context.colors.primary,
              radius: 9999.r,
              strokeWidth: 1.w,
              dash: 4.w,
              gap: 4.w,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.icPlus,
                    width: 24.w,
                    height: 24.w,
                    colorFilter: ColorFilter.mode(
                      context.colors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Add Item',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colors.primary,
                      height: 24 / 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 20.h),

        // ── 3. "All Inventory" Collapsible Header & List ─────────────────────
        Obx(() {
          final isExpanded = controller.isGroceriesSectionExpanded.value;
          return Column(
            children: [
              GestureDetector(
                onTap: controller.toggleGroceriesSection,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Inventory',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: context.appColors.primaryText,
                          height: 24 / 16,
                        ),
                      ),
                      Transform.rotate(
                        angle: isExpanded ? 0 : math.pi,
                        child: SvgPicture.asset(
                          AppAssets.icCircleChevronUp,
                          width: 20.w,
                          height: 20.w,
                          colorFilter: ColorFilter.mode(
                            context.appColors.primaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // ── 4. Grocery Item Cards List ───────────────────────────────
              if (controller.filteredGroceryItems.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Center(
                    child: Text(
                      'No inventory items found.',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredGroceryItems.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = controller.filteredGroceryItems[index];
                    return GroceryItemCard(
                      item: item,
                      isParentExpanded: isExpanded,
                    );
                  },
                ),
            ],
          );
        }),

        SizedBox(height: 32.h),
      ],
    );
  }

  // ── 2. My Shopping List View (Switched within Tab) ─────────────────────────
  Widget _buildShoppingListView(BuildContext context) {
    return Column(
      key: const ValueKey('shopping_list_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        // ── Header: Back Arrow (Returns to Inventory) + Title ─────────────────
        Row(
          children: [
            GestureDetector(
              onTap: controller.backToInventoryInTab,
              child: SizedBox(
                width: 32.w,
                height: 32.w,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 24.w,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'My Shopping List',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.primary,
                  height: 30 / 20,
                ),
              ),
            ),
            SizedBox(width: 32.w), // Balance for back button
          ],
        ),

        SizedBox(height: 16.h),

        // ── Quick Stats & Build Voucher Button ──────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Items (recommended)',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.secondaryText,
                    height: 20 / 14,
                  ),
                ),
                SizedBox(height: 4.h),
                Obx(
                  () => Text(
                    '${controller.shoppingListItems.length} Needed',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: context.appColors.primaryText,
                      height: 32 / 24,
                    ),
                  ),
                ),
              ],
            ),

            // Build Voucher Button with Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed<void>(AppRoutes.shoppingVoucher);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.elevatedBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: context.colors.primary,
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Build Voucher',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colors.primary,
                            height: 20 / 14,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        SvgPicture.asset(
                          AppAssets.icArorrow,
                          width: 8.w,
                          height: 12.w,
                          colorFilter: ColorFilter.mode(
                            context.colors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -8.h,
                  right: -8.w,
                  child: Container(
                    width: 22.w,
                    height: 22.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.voucherBadgeBg,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '01',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // ── Recommendation Info Banner ──────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.brandTealBorder.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 22.w,
                color: context.colors.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Recommended quantities are based on your usage from last week. You can adjust them as needed.',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colors.primary,
                    height: 18 / 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // ── Add Custom Item Button ──────────────────────────────────────────
        GestureDetector(
          onTap: () {
            showAppSheet<void>(
              child: const AddGroceryItemSheet(
                isShoppingList: true,
              ),
            );
          },
          child: CustomPaint(
            painter: DottedBorderPainter(
              color: context.colors.primary,
              radius: 16.r,
              strokeWidth: 1.w,
              dash: 4.w,
              gap: 4.w,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 13.w,
                vertical: 12.h,
              ),
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 20.w,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Add Custom Item',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colors.primary,
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 20.h),

        // ── Shopping Items List ────────────────────────────────────────────
        Obx(() {
          final items = controller.shoppingListItems;
          if (items.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: Text(
                  'Your shopping list is empty.',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    color: context.appColors.secondaryText,
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = items[index];
              return ShoppingListItemCard(item: item);
            },
          );
        }),

        SizedBox(height: 32.h),
      ],
    );
  }
}
