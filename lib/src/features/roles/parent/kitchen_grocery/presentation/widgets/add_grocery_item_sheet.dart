import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class CategoryItemData {
  const CategoryItemData({
    required this.name,
    this.icon,
    this.svgPath,
  });

  final String name;
  final IconData? icon;
  final String? svgPath;
}

class AddGroceryItemSheet extends HookWidget {
  const AddGroceryItemSheet({
    super.key,
    this.isShoppingList = false,
  });

  final bool isShoppingList;

  static const List<CategoryItemData> _categories = [
    CategoryItemData(name: 'Produce', svgPath: AppAssets.icProduce),
    CategoryItemData(name: 'Dairy', icon: Icons.water_drop_outlined),
    CategoryItemData(name: 'Bakery', icon: Icons.bakery_dining_outlined),
    CategoryItemData(name: 'Pantry', svgPath: AppAssets.icPantry),
    CategoryItemData(name: 'Baby', svgPath: AppAssets.icBaby),
    CategoryItemData(name: 'Fruit', svgPath: AppAssets.icFruits),
    CategoryItemData(name: 'Meat', icon: Icons.set_meal_outlined),
    CategoryItemData(name: 'Other', icon: Icons.more_horiz_outlined),
  ];

  static const List<String> _units = [
    'Liter',
    'Gram',
    'Pcs',
    'Pack',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseKitchenController>();
    final nameController = useTextEditingController();
    final noteController = useTextEditingController();
    final selectedUnit = useState<String>('Liter');
    final isUnitDropdownOpen = useState<bool>(false);
    final selectedCategory = useState<String>('Dairy');
    final selectedStock = useState<int>(10);
    final quantityValue = useState<int>(1);

    useValueChanged<String, String>(selectedUnit.value, (oldValue, oldResult) {
      if (selectedUnit.value.toLowerCase() == 'gram') {
        quantityValue.value = 250;
      } else {
        quantityValue.value = 1;
      }
      return selectedUnit.value;
    });

    final layerLink = useMemoized(() => LayerLink());
    final overlayController = useMemoized(() => OverlayPortalController());

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Header: Close Button ────────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: AppColors.brandGrayLight,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (isUnitDropdownOpen.value) {
                      overlayController.hide();
                    }
                    Get.back<void>();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.w,
                    color: AppColors.disabledTextColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // ── 1. Item name* ───────────────────────────────────────────────
            AppTextField(
              label: LangKey.parentKitchen.itemName,
              hint: LangKey.parentKitchen.itemNameHint,
              isRequired: true,
              controller: nameController,
            ),
            SizedBox(height: 16.h),

            // ── 2. Unit* Dropdown ───────────────────────────────────────────
            OverlayPortal(
              controller: overlayController,
              overlayChildBuilder: (context) {
                return CompositedTransformFollower(
                  link: layerLink,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  offset: Offset(0, 4.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.brandGrayBorder,
                            width: 1.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _units.map((unit) {
                            final isSelected = selectedUnit.value == unit;
                            return GestureDetector(
                              onTap: () {
                                selectedUnit.value = unit;
                                isUnitDropdownOpen.value = false;
                                overlayController.hide();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: unit == _units.last ? 0 : 8.h,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryBackgroundColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: isSelected
                                      ? null
                                      : Border.all(
                                          color: AppColors.bottomNavBorder,
                                          width: 1.w,
                                        ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      unit,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.whiteColor
                                            : AppColors.secondaryTextColor,
                                      ),
                                    ),
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked_rounded
                                          : Icons
                                              .radio_button_unchecked_rounded,
                                      size: 20.w,
                                      color: isSelected
                                          ? AppColors.whiteColor
                                          : AppColors.neutral300,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: CompositedTransformTarget(
                link: layerLink,
                child: AppTextField(
                  label: 'Unit',
                  hint: 'Select unit',
                  isRequired: true,
                  readOnly: true,
                  controller: TextEditingController(text: selectedUnit.value),
                  suffixIcon: Icon(
                    isUnitDropdownOpen.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 24.w,
                    color: AppColors.blackTextColor,
                  ),
                  onTap: () {
                    isUnitDropdownOpen.value = !isUnitDropdownOpen.value;
                    if (isUnitDropdownOpen.value) {
                      overlayController.show();
                    } else {
                      overlayController.hide();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),

            if (isShoppingList) ...[
              _buildQuantitySelector(
                  context, quantityValue, selectedUnit.value),
              SizedBox(height: 16.h),
            ],

            // ── 3. Category* Section ─────────────────────────────────────────
            Row(
              children: [
                Text(
                  'Category',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackTextColor,
                  ),
                ),
                Text(
                  ' *',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.brandRedAsterisk,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.neutral50,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = selectedCategory.value == cat.name;

                  return GestureDetector(
                    onTap: () => selectedCategory.value = cat.name,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: AppColors.neutral200,
                                width: 1.w,
                              ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cat.svgPath != null)
                            SvgPicture.asset(
                              cat.svgPath!,
                              width: 22.w,
                              height: 22.w,
                              colorFilter: ColorFilter.mode(
                                isSelected
                                    ? AppColors.whiteColor
                                    : AppColors.secondaryTextColor,
                                BlendMode.srcIn,
                              ),
                            )
                          else if (cat.icon != null)
                            Icon(
                              cat.icon!,
                              size: 22.w,
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.secondaryTextColor,
                            ),
                          SizedBox(height: 6.h),
                          Text(
                            cat.name,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),

            // ── 4. Mark Amount or Note Section ──────────────────────────────
            if (isShoppingList) ...[
              AppTextField(
                label: 'Note: (Optional)',
                hint: 'e:g: please send fresh brand’s milk',
                controller: noteController,
              ),
            ] else ...[
              Text(
                'Mark Amount',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackTextColor,
                ),
              ),
              SizedBox(height: 10.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [0, 10, 25, 50, 75, 100].map((val) {
                    final isSelected = selectedStock.value == val;
                    final label = val == 100 ? 'Full' : '$val%';

                    Color bgColor = AppColors.whiteColor;
                    Color borderColor = AppColors.neutral200;
                    Color textColor = AppColors.mutedTextColor;

                    if (isSelected) {
                      if (val <= 10) {
                        bgColor = AppColors.supportingRedShade;
                        borderColor = AppColors.stockSegmentMissingActive;
                        textColor = AppColors.groceryRed;
                      } else if (val <= 30) {
                        bgColor = AppColors.supportingOrangeShade;
                        borderColor = AppColors.supportingOrange;
                        textColor = AppColors.groceryWarningOrange;
                      } else {
                        bgColor = AppColors.primaryColor;
                        borderColor = AppColors.primaryColor;
                        textColor = AppColors.whiteColor;
                      }
                    }

                    return GestureDetector(
                      onTap: () => selectedStock.value = val,
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(9999.r),
                          border: Border.all(color: borderColor, width: 1.w),
                        ),
                        child: Text(
                          label,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            SizedBox(height: 28.h),

            // ── 5. Action Buttons (Cancel & Add) ───────────────────────────
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: LangKey.parentKitchen.cancel,
                    variant: ButtonVariant.outline,
                    borderColor: AppColors.brandGrayBorder,
                    textColor: AppColors.secondaryTextColor,
                    onPressed: () {
                      if (isUnitDropdownOpen.value) {
                        overlayController.hide();
                      }
                      Get.back<void>();
                    },
                    height: ButtonSize.medium,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppButton(
                    label: LangKey.parentKitchen.addItem,
                    variant: ButtonVariant.primary,
                    color: AppColors.primaryColor,
                    onPressed: () async {
                      if (isUnitDropdownOpen.value) {
                        overlayController.hide();
                      }
                      final itemName = nameController.text.trim().isEmpty
                          ? 'Organic Whole Milk'
                          : nameController.text.trim();

                      if (isShoppingList) {
                        await controller.addCustomShoppingListItem(
                          itemName,
                          unit: selectedUnit.value,
                          quantity: quantityValue.value,
                          category: selectedCategory.value,
                          note: noteController.text,
                          isCustomOrder: true,
                          addToKitchen: true,
                        );
                      } else {
                        await controller.addGroceryItem(
                          itemName,
                          selectedStock.value,
                          unit: selectedUnit.value,
                          category: selectedCategory.value,
                          note: noteController.text,
                        );
                      }
                      Get.back<void>();
                    },
                    height: ButtonSize.medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(
    BuildContext context,
    ValueNotifier<int> quantityValue,
    String unit,
  ) {
    final step = unit.toLowerCase() == 'gram' ? 50 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Quantity',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackTextColor,
              ),
            ),
            Text(
              '*',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.brandRedAsterisk,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.brandGrayBorder,
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.brandLogoLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${quantityValue.value}',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            quantityValue.value += step;
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.arrow_drop_up_rounded,
                            size: 18.w,
                            color: AppColors.disabledTextColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (quantityValue.value > step) {
                              quantityValue.value -= step;
                            } else if (quantityValue.value > 1) {
                              quantityValue.value =
                                  (quantityValue.value - 1).clamp(1, 9999);
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 18.w,
                            color: AppColors.disabledTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                _getUnitAbbreviation(unit),
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getUnitAbbreviation(String unit) {
    return switch (unit.toLowerCase()) {
      'liter' => 'ltr',
      'gram' => 'gm',
      'pcs' => 'pcs',
      'pack' => 'pack',
      _ => unit,
    };
  }
}
