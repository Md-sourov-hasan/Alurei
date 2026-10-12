import 'package:alurei/src/imports/imports.dart';

class StoreOptionData {
  const StoreOptionData({
    required this.id,
    required this.name,
    required this.subtitle,
    this.isNearby = false,
  });

  final String id;
  final String name;
  final String subtitle;
  final bool isNearby;
}

class ChooseStoreSheet extends HookWidget {
  const ChooseStoreSheet({super.key});

  static const List<StoreOptionData> _stores = [
    StoreOptionData(
      id: 'carrefour',
      name: 'Carrefour',
      subtitle: 'Save 5% when you spend over 100 AUD',
    ),
    StoreOptionData(
      id: 'talabat',
      name: 'Talabat',
      subtitle: 'Free delivery on orders above 80 AUD',
    ),
    StoreOptionData(
      id: 'nearby',
      name: 'Find nearby grocery store',
      subtitle: 'See stores on the map',
      isNearby: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedStoreId = useState<String>('carrefour');

    return Container(
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Drag Handle Pill ──────────────────────────────────────────────
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.inputBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,

          // ── Header Title & Close Button ────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Store',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.headerTextColor,
                  height: 28 / 20,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back<void>(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    IconsaxPlusLinear.close_square,
                    size: 22.w,
                    color: AppColors.headerTextColor,
                  ),
                ),
              ),
            ],
          ),
          20.verticalSpace,

          // ── Store Options List ─────────────────────────────────────────────
          ..._stores.map((store) {
            final isSelected = selectedStoreId.value == store.id;

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: store.isNearby
                  ? _buildNearbyStoreCard(
                      context,
                      store: store,
                      isSelected: isSelected,
                      onTap: () => selectedStoreId.value = store.id,
                    )
                  : _buildStoreCard(
                      context,
                      store: store,
                      isSelected: isSelected,
                      onTap: () => selectedStoreId.value = store.id,
                    ),
            );
          }),

          12.verticalSpace,

          // ── Action Button ──────────────────────────────────────────────────
          AppButton(
            label: 'Send order',
            variant: ButtonVariant.primary,
            color: AppColors.primaryColor,
            isFullWidth: true,
            onPressed: () {
              final selected = _stores.firstWhere(
                (s) => s.id == selectedStoreId.value,
                orElse: () => _stores.first,
              );
              Get.back<void>();
              Get.toNamed(
                AppRoutes.voucherSent,
                arguments: selected.name,
              );
            },
            height: ButtonSize.large,
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(
    BuildContext context, {
    required StoreOptionData store,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.inputBorder,
            width: isSelected ? 1.5.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            // Store Logo / Badge
            _buildStoreLogo(store.id),
            12.horizontalSpace,

            // Store Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.headerTextColor,
                      height: 24 / 16,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    store.subtitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mutedTextColor,
                      height: 18 / 12,
                    ),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,

            // Radio Button Indicator
            _buildRadioButton(context, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyStoreCard(
    BuildContext context, {
    required StoreOptionData store,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: isSelected ? AppColors.primaryColor : AppColors.inputBorder,
          strokeWidth: 1.w,
          dash: 4.w,
          gap: 4.w,
          radius: 16.r,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.bottomNavSelectedBackground.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              // Nearby location icon inside round badge
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    IconsaxPlusLinear.location,
                    size: 22.w,
                    color: AppColors.headerTextColor,
                  ),
                ),
              ),
              12.horizontalSpace,

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headerTextColor,
                        height: 24 / 16,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      store.subtitle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                        height: 18 / 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreLogo(String storeId) {
    if (storeId == 'carrefour') {
      return Container(
        width: 44.w,
        height: 44.w,
        decoration: const BoxDecoration(
          color: AppColors.secondaryBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.icCarrefourLogo,
            width: 24.w,
            height: 16.h,
          ),
        ),
      );
    }

    if (storeId == 'talabat') {
      return Container(
        width: 44.w,
        height: 44.w,
        decoration: const BoxDecoration(
          color: AppColors.secondaryBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: const BoxDecoration(
              color: Color(0xFFFF6000), // Talabat Orange
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 44.w,
      height: 44.w,
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        IconsaxPlusLinear.shop,
        size: 22.w,
        color: AppColors.headerTextColor,
      ),
    );
  }

  Widget _buildRadioButton(BuildContext context, bool isSelected) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.brandTealBorder : AppColors.inputBorder,
          width: 1.5.w,
        ),
        color: AppColors.transparentColor,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          : null,
    );
  }
}
