import 'package:alurei/src/features/roles/parent/kitchen_grocery/domain/entities/grocery_item.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class ShoppingListItemCard extends HookWidget {
  const ShoppingListItemCard({super.key, required this.item});

  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseKitchenController>();
    final noteController = useTextEditingController(text: item.note ?? '');
    final isExpanded = useState<bool>(true);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.groceryCardBorder,
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Header: Name + Alert + Cart + Chevron ──────────────────────
          GestureDetector(
            onTap: () => isExpanded.value = !isExpanded.value,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      item.name,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.primaryText,
                        height: 24 / 16,
                      ),
                    ),
                    if (item.isMissing) ...[
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        AppAssets.foodAlert,
                        width: 18.w,
                        height: 18.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.groceryRed,
                          BlendMode.srcIn,
                        ),
                      ),
                    ] else if (item.isLow) ...[
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        AppAssets.foodSubAlert,
                        width: 18.w,
                        height: 18.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.groceryWarningOrange,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.all(4.w),
                      onPressed: () {
                        showGlobalToast(
                          message: '${item.name} added to cart',
                        );
                      },
                      icon: SvgPicture.asset(
                        AppAssets.icShoppingCart,
                        width: 20.w,
                        height: 20.w,
                        colorFilter: ColorFilter.mode(
                          context.colors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    RotatedBox(
                      quarterTurns: isExpanded.value ? 0 : 2,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24.w,
                        color: context.appColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Collapsible Body Content ─────────────────────────────────────────
          if (isExpanded.value) ...[
            SizedBox(height: 16.h),

            // ── 2. Quantity Label & Delete Icon ──────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quantity • ',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mutedTextColor,
                          height: 20 / 14,
                        ),
                      ),
                      TextSpan(
                        text: item.quantityDisplay,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.appColors.primaryText,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.all(4.w),
                  onPressed: () async {
                    final confirmed = await showAppConfirmationDialog(
                      title: 'Delete Item?',
                      message:
                          'Are you sure you want to remove "${item.name}" from your shopping list?',
                      confirmLabel: 'Delete',
                      cancelLabel: 'Cancel',
                      headerIcon: Container(
                        width: 48.w,
                        height: 48.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SvgPicture.asset(
                          AppAssets.icDelete,
                          width: 24.w,
                          height: 24.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.deleteRed,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                    if (confirmed ?? false) {
                      await controller.deleteShoppingListItem(item.id);
                    }
                  },
                  icon: SvgPicture.asset(
                    AppAssets.icDelete,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.deleteRed,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // ── 3. Decrement / Count / Increment Controls ─────────────────────
            Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      controller.decrementShoppingItemQuantity(item.id),
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.neutral200,
                        width: 1.w,
                      ),
                    ),
                    child: Icon(
                      Icons.remove_rounded,
                      size: 14.w,
                      color: context.appColors.primaryText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    item.unit == 'g'
                        ? '${item.quantityValue}g'
                        : '${item.quantityValue}',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: context.appColors.primaryText,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      controller.incrementShoppingItemQuantity(item.id),
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      size: 14.w,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // ── 4. Note Section (Editable / Display) ───────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Note: (Optional)',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                    height: 24 / 14,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.neutral50,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: item.isEditing
                            ? TextField(
                                controller: noteController,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  color: context.appColors.primaryText,
                                ),
                                decoration: const InputDecoration(
                                  filled: false,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: true,
                                  hintText: 'Enter note...',
                                ),
                              )
                            : Text(
                                item.note ??
                                    'e:g: please send fresh brand’s milk',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: item.note != null
                                      ? context.appColors.primaryText
                                      : AppColors.brandGrayHint,
                                  height: 18 / 12,
                                ),
                              ),
                      ),
                      if (item.isEditing)
                        GestureDetector(
                          onTap: () {
                            controller.saveShoppingItemNote(
                              item.id,
                              noteController.text,
                            );
                          },
                          child: SvgPicture.asset(
                            AppAssets.icSave,
                            width: 18.w,
                            height: 18.w,
                            colorFilter: ColorFilter.mode(
                              context.appColors.primaryText,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: () {
                            controller.toggleShoppingItemEditing(item.id);
                          },
                          child: SvgPicture.asset(
                            AppAssets.icEdit,
                            width: 18.w,
                            height: 18.w,
                            colorFilter: ColorFilter.mode(
                              context.appColors.primaryText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
