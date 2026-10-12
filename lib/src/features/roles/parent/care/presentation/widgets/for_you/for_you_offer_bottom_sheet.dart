import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/dashed_border_painter.dart';

class ForYouOfferBottomSheet extends HookWidget {
  const ForYouOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final activeTab = useState<int>(0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.verticalSpace,
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2F2),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AppAssets.icShop,
                            width: 24.w,
                            height: 24.w,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Carrefour',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              2.verticalSpace,
                              Text(
                                'Screen-free learning kits for curious kids',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    'Carrefour designs hands-on activity kits that grow with your child. Each box includes all the materials and a step-by-step guide written for caregivers — perfect for activities just like this one.',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      _buildTag('Educational Toys'),
                      8.horizontalSpace,
                      _buildTag('STEM'),
                      8.horizontalSpace,
                      _buildTag('Arts & Crafts'),
                    ],
                  ),
                  24.verticalSpace,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFF0A4F53)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFF1F5F9), // Light greyish background for top
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                IconsaxPlusLinear.tag,
                                size: 20.w,
                                color: const Color(0xFF0A4F53),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Exclusive Alurei family discount',
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0A4F53),
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      '15% off your first kit',
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF334155),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => activeTab.value = 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: activeTab.value == 0
                                        ? const Color(0xFF0A4F53)
                                        : AppColors.whiteColor,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icOnline,
                                        width: 16.w,
                                        height: 16.w,
                                        colorFilter: ColorFilter.mode(
                                          activeTab.value == 0
                                              ? AppColors.whiteColor
                                              : const Color(0xFF1E293B),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Text(
                                        'Online',
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: activeTab.value == 0
                                              ? AppColors.whiteColor
                                              : const Color(0xFF1E293B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => activeTab.value = 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: activeTab.value == 1
                                        ? const Color(0xFF0A4F53)
                                        : AppColors.whiteColor,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                      left: BorderSide(
                                        color: Color(0xFFE2E8F0),
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icStore,
                                        width: 16.w,
                                        height: 16.w,
                                        colorFilter: ColorFilter.mode(
                                          activeTab.value == 1
                                              ? AppColors.whiteColor
                                              : const Color(0xFF1E293B),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Text(
                                        'In-Store',
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: activeTab.value == 1
                                              ? AppColors.whiteColor
                                              : const Color(0xFF1E293B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: activeTab.value == 0
                                ? _buildOnlineView(
                                    key: const ValueKey('online'))
                                : _buildInStoreView(
                                    key: const ValueKey('instore')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  AppButton(
                    isFullWidth: true,
                    label: activeTab.value == 0
                        ? 'Visit Carrefour'
                        : 'Visit in-store Carrefour',
                    variant: ButtonVariant.primary,
                    color: const Color(0xFF0A4F53),
                    suffixIcon: SvgPicture.asset(
                      AppAssets.icVisit,
                      width: 18.w,
                      height: 18.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      showGlobalToast(message: 'Opening website');
                    },
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ), // Close Flexible
        ],
      ),
    );
  }

  Widget _buildOnlineView({Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter this code at checkout on the Carrefour website to claim your discount.',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: AppColors.secondaryTeal,
                    strokeWidth: 1,
                    gap: 6,
                    radius: 20.r,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    child: Text(
                      'ALUREI15',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF004D54),
                      ),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              AppButton(
                width: ButtonSize.small,
                label: LangKey.parentMyOffer.copy,
                variant: ButtonVariant.primary,
                color: const Color(0xFF0A4F53),
                prefixIcon: Icon(
                  IconsaxPlusLinear.copy,
                  size: 16.w,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  showGlobalToast(message: LangKey.parentMyOffer.codeCopied);
                },
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            'parent_care.valid_until'.tr(args: ['31 Jul 2026']),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475569),
            ),
          ),
          6.verticalSpace,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Terms and conditions: ',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004D54),
                  ),
                ),
                TextSpan(
                  text: 'parent_care.minimum_purchase_required'.tr(args: ['50 AED']),
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInStoreView({Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Show or scan this QR code at any PlaySpark store to apply your discount at the till.',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
          16.verticalSpace,
          Center(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.qr_code_2,
                size: 140.w,
                color: const Color(0xFF004D54),
              ),
            ),
          ),
          20.verticalSpace,
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    LangKey.parentCare.showToCashier,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF004D54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          12.verticalSpace,
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                LangKey.parentCare.tellVoucherCode,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF004D54),
                ),
              ),
            ),
          ),
          16.verticalSpace,
          CustomPaint(
            painter: DashedBorderPainter(
              color: AppColors.secondaryTeal,
              strokeWidth: 1,
              gap: 6,
              radius: 20.r,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              alignment: Alignment.center,
              child: Text(
                'ALUREI15',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF004D54),
                ),
              ),
            ),
          ),
          24.verticalSpace,
          _buildNumberedListItem(1, LangKey.parentCare.openScreenAtCheckout),
          12.verticalSpace,
          _buildNumberedListItem(
              2, 'Let the cashier scan the QR code or tell them the code'),
          12.verticalSpace,
          _buildNumberedListItem(3, '15% discount is applied instantly'),
          24.verticalSpace,
          Text(
            'parent_care.valid_until'.tr(args: ['31 Jul 2026']),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475569),
            ),
          ),
          6.verticalSpace,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Terms and conditions: ',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004D54),
                  ),
                ),
                TextSpan(
                  text: 'parent_care.minimum_purchase_required'.tr(args: ['50 AED']),
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedListItem(int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: const BoxDecoration(
            color: Color(0xFF0A4F53),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2F2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF004D54),
        ),
      ),
    );
  }
}
