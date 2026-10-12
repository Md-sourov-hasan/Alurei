import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/grocery_item.dart';

class GroceryItemCard extends HookWidget {
  const GroceryItemCard({
    super.key,
    required this.item,
    required this.isParentExpanded,
  });

  final GroceryItem item;
  final bool isParentExpanded;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseKitchenController>();
    final isExpanded = useState(isParentExpanded);

    useValueChanged(isParentExpanded, (_, __) {
      isExpanded.value = isParentExpanded;
      return isParentExpanded;
    });

    final nameTextController = useTextEditingController(text: item.name);
    final noteTextController = useTextEditingController(text: item.note ?? '');

    final isMissing = item.status == GroceryFilter.missing;
    final isLow = item.status == GroceryFilter.low;

    final statusColor = isMissing
        ? AppColors.groceryRed
        : isLow
            ? AppColors.groceryWarningOrange
            : AppColors.groceryGreen;

    final statusTrackColor = isMissing
        ? AppColors.missingBackgroundAlpha
        : isLow
            ? AppColors.lowBackgroundAlpha
            : AppColors.stockBackgroundAlpha;

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
      padding: EdgeInsets.all(17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: Name + Expand Chevron ──────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    item.name,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.primaryText,
                      height: 24 / 16,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (isMissing) SvgPicture.asset(
                          AppAssets.foodAlert,
                          width: 18.w,
                          height: 18.w,
                          colorFilter: ColorFilter.mode(
                            statusColor,
                            BlendMode.srcIn,
                          ),
                        ) else isLow
                          ? SvgPicture.asset(
                              AppAssets.foodSubAlert,
                              width: 18.w,
                              height: 18.w,
                              colorFilter: ColorFilter.mode(
                                statusColor,
                                BlendMode.srcIn,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(9999.r),
                              ),
                              child: Text(
                                'Stock',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  height: 1.2,
                                ),
                              ),
                            ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.all(4.w),
                    onPressed: () {
                      controller.addGroceryItemToShoppingList(item);
                    },
                    icon: SvgPicture.asset(
                      AppAssets.icShoppingCart,
                      width: 18.w,
                      height: 18.w,
                      colorFilter: ColorFilter.mode(
                        context.colors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: RotatedBox(
                      quarterTurns: isExpanded.value ? 0 : 2,
                      child: SvgPicture.asset(
                        AppAssets.icFoodArrow,
                        width: 12.w,
                        height: 8.w,
                        colorFilter: ColorFilter.mode(
                          context.appColors.secondaryText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Expanded Content ───────────────────────────────────────────────
          if (isExpanded.value) ...[
            SizedBox(height: 16.h),

            // Last Stock Date & Action Buttons (Edit / Save / Delete)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last stock: ${item.lastStockDate}',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.primaryText,
                    height: 20 / 14,
                  ),
                ),
                Row(
                  children: [
                    if (item.isEditing)
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.all(4.w),
                        onPressed: () {
                          showAppDialog(
                            child: Dialog(
                              backgroundColor: AppColors.whiteBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 28.h,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Save changed?',
                                      textAlign: TextAlign.center,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                        color: context.appColors.primaryText,
                                      ),
                                    ),
                                    12.verticalSpace,
                                    Text(
                                      'Do you wish to save this item before\nleaving?',
                                      textAlign: TextAlign.center,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: context.appColors.secondaryText,
                                        height: 1.4,
                                      ),
                                    ),
                                    28.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppButton(
                                            label: 'Discard',
                                            variant: ButtonVariant.outline,
                                            textColor: const Color(0xFF334155),
                                            borderColor:
                                                AppColors.brandGrayBorder,
                                            onPressed: () {
                                              Get.back();
                                              controller
                                                  .toggleItemEditing(item.id);
                                            },
                                          ),
                                        ),
                                        16.horizontalSpace,
                                        Expanded(
                                          child: AppButton(
                                            label: 'Save',
                                            variant: ButtonVariant.primary,
                                            onPressed: () {
                                              Get.back();
                                              controller.saveItem(
                                                item.id,
                                                nameTextController.text,
                                                noteTextController.text,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          AppAssets.icSave,
                          width: 24.w,
                          height: 24.w,
                          colorFilter: ColorFilter.mode(
                            context.appColors.primaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    else
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.all(4.w),
                        onPressed: () => controller.toggleItemEditing(item.id),
                        icon: SvgPicture.asset(
                          AppAssets.icEdit,
                          width: 24.w,
                          height: 24.w,
                          colorFilter: ColorFilter.mode(
                            context.appColors.primaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    SizedBox(width: 8.w),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.all(4.w),
                      onPressed: () {
                        showAppDialog(
                          child: Dialog(
                            backgroundColor: AppColors.whiteBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 28.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
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
                                  16.verticalSpace,
                                  Text(
                                    'Delete the item?',
                                    textAlign: TextAlign.center,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                      color: context.appColors.primaryText,
                                    ),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                    'Are you sure you want to delete the ${item.name} item from the kitchen inventory?',
                                    textAlign: TextAlign.center,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: context.appColors.secondaryText,
                                      height: 1.4,
                                    ),
                                  ),
                                  28.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppButton(
                                          label: 'Cancel',
                                          variant: ButtonVariant.outline,
                                          textColor: const Color(0xFF334155),
                                          borderColor:
                                              AppColors.brandGrayBorder,
                                          onPressed: () => Get.back(),
                                        ),
                                      ),
                                      16.horizontalSpace,
                                      Expanded(
                                        child: AppButton(
                                          label: 'Delete',
                                          variant: ButtonVariant.primary,
                                          color: AppColors.deleteRed,
                                          onPressed: () {
                                            Get.back();
                                            controller
                                                .deleteGroceryItem(item.id);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        AppAssets.icDelete,
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.deleteRed,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Current Stock level row & Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Stock',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.appColors.primaryText,
                        height: 20 / 14,
                      ),
                    ),
                    Text(
                      '${item.currentStockPercent}% remaining',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: isLow ? 18.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                        height: 24 / 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 8.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: statusTrackColor,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor:
                        (item.currentStockPercent / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(9999.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Name Field Row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.groceryTrackColor,
                  width: 1.w,
                ),
              ),
              child: item.isEditing
                  ? TextField(
                      controller: nameTextController,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.primaryText,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        labelText: 'Name',
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          'Name: ',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: context.appColors.primaryText,
                            height: 24 / 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.name,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: context.appColors.secondaryText,
                              height: 20 / 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),

            SizedBox(height: 12.h),

            // Note Section
            if (item.note != null || item.isEditing) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(13.w),
                decoration: BoxDecoration(
                  color: AppColors.groceryNoteBg,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: AppColors.groceryNoteBorder,
                    width: 1.w,
                  ),
                ),
                child: item.isEditing
                    ? TextField(
                        controller: noteTextController,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.primaryText,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          labelText: 'Note',
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note: ',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.groceryNoteText,
                              height: 24 / 16,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item.note ?? '',
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.groceryNoteSecondary,
                                height: 20 / 14,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 16.h),
            ],

            // Mark Used Amount Section
            Text(
              'Mark Used Amount',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: context.appColors.primaryText,
                height: 24 / 16,
              ),
            ),
            SizedBox(height: 8.h),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [0, 10, 25, 50, 75, 100].map((percent) {
                  final isSelected = item.currentStockPercent == percent;
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () => controller.updateItemStock(item.id, percent),
                      child: Container(
                        width: 68.w,
                        height: 38.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (percent <= 10
                                  ? AppColors.stockSegmentMissing
                                  : percent <= 30
                                      ? AppColors.groceryWarningOrange
                                      : context.colors.primary)
                              : AppColors.transparentColor,
                          borderRadius: BorderRadius.circular(9999.r),
                          border: Border.all(
                            color: isSelected
                                ? (percent <= 10
                                    ? AppColors.stockSegmentMissingActive
                                    : percent <= 30
                                        ? AppColors.groceryWarningOrange
                                        : context.colors.primary)
                                : AppColors.groceryTrackColor,
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          percent == 100 ? 'Full' : '$percent%',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? (percent <= 10
                                    ? AppColors.groceryRed
                                    : AppColors.whiteColor)
                                : AppColors.stockSegmentText,
                            height: 24 / 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
