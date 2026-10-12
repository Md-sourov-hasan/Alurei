import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/add_grocery_item_sheet.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/shopping_list_item_card.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class MyShoppingListScreen extends HookWidget {
  const MyShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseKitchenController>();

    useEffect(() {
      controller.fetchKitchenShoppingItems();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Header: Back Button + Title ──────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: context.appColors.elevatedBackground,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.brandTealBorder,
                    width: 1.w,
                  ),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back<void>(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.brandGrayLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.w,
                        color: context.colors.primary,
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
                  SizedBox(width: 40.w), // Balance for back button
                ],
              ),
            ),

            // ── Scrollable Body Content ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Quick Stats & My Voucher Button ──────────────────────
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
                            Obx(() => Text(
                                  '${controller.shoppingListItems.length} Needed',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: context.appColors.primaryText,
                                    height: 32 / 24,
                                  ),
                                )),
                          ],
                        ),

                        // My Voucher Button with Notification Badge
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
                                  vertical: 12.h,
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

                    // ── Recommendation Info Banner ────────────────────────────
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
                            size: 24.w,
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

                    // ── Add Custom Item Button ─────────────────────────────
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
                            vertical: 10.h,
                          ),
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                size: 24.w,
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

                    // ── Shopping Items List ──────────────────────────────────
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
