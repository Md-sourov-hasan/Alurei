import 'package:alurei/src/features/roles/parent/kitchen_grocery/domain/entities/grocery_item.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/widgets/choose_store_sheet.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class ShoppingVoucherScreen extends HookWidget {
  const ShoppingVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseKitchenController>();
    final finalNoteController = useTextEditingController(
      text:
          'e.g. Please check expiry dates and prioritize organic brands for all dairy and vegetable items.',
    );
    final isEditingFinalNote = useState<bool>(false);

    // Fallback voucher items when list is empty
    const fallbackItems = [
      ShoppingListItem(
        id: 'v1',
        name: 'Organic Whole Milk',
        quantityValue: 250,
        unit: 'g',
        note: 'Note: Small carton preferred',
      ),
      ShoppingListItem(
        id: 'v2',
        name: 'Fresh Spinach',
        quantityValue: 250,
        unit: 'g',
        note: 'Note: Check for crisp leaves',
      ),
      ShoppingListItem(
        id: 'v3',
        name: 'Sweet Potatoes',
        quantityValue: 1,
        unit: 'kg',
        note: 'Note: Avoid bruised ones',
      ),
      ShoppingListItem(
        id: 'v4',
        name: 'Eco-Friendly Diapers',
        quantityValue: 250,
        unit: 'g',
        note: 'Note: Size 3 (Check bulk pack)',
      ),
      ShoppingListItem(
        id: 'v5',
        name: 'Water-based Wipes',
        quantityValue: 250,
        unit: 'g',
        note: 'Note: 4-pack value bundle',
      ),
    ];

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: 'Shopping Voucher',
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: true,
        onPressed: () => Get.back<void>(),
        actions: [
          IconButton(
            onPressed: () {
              showGlobalToast(
                  message: LangKey.parentKitchen.sharingShoppingVoucher);
            },
            icon: SvgPicture.asset(
              AppAssets.icShare2,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.appleColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable Content Area ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Obx(() {
                  final activeItems = controller.shoppingListItems.isNotEmpty
                      ? controller.shoppingListItems
                      : fallbackItems;
                  final totalCount = activeItems.length;

                  return Container(
                    decoration: BoxDecoration(
                      color: context.appColors.elevatedBackground,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Voucher Card Header ─────────────────────────────
                        _VoucherCardHeader(totalCount: totalCount),
                        16.verticalSpace,

                        // ── Items List ──────────────────────────────────────
                        _VoucherItemsList(items: activeItems),
                        24.verticalSpace,

                        // ── Footer Decorative & Barcode Section ──────────────
                        const _VoucherBarcodeSection(
                          voucherId: 'AL-2026-X892',
                        ),
                        24.verticalSpace,

                        // ── Final Note Section ──────────────────────────────
                        _VoucherFinalNoteSection(
                          controller: finalNoteController,
                          isEditing: isEditingFinalNote,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // ── Fixed Bottom Action Bar ─────────────────────────────────────
            const _VoucherBottomActionBar(),
          ],
        ),
      ),
    );
  }
}

/// Header component of the shopping voucher card
class _VoucherCardHeader extends StatelessWidget {
  const _VoucherCardHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shopping List Voucher',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                    height: 24 / 16,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'June 15, 2026 • $totalCount Items Total',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedTextColor,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.bottomNavSelectedBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.icList,
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        CustomPaint(
          size: Size(double.infinity, 1.h),
          painter: DottedLinePainter(
            color: AppColors.brandTealBorder,
            strokeWidth: 1.w,
            dash: 4.w,
            gap: 4.w,
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}

/// Reusable list component for rendering voucher shopping items
class _VoucherItemsList extends StatelessWidget {
  const _VoucherItemsList({required this.items});

  final List<ShoppingListItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: AppDivider(
          color: AppColors.inputBorder,
          height: 1.h,
        ),
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _VoucherItemTile(item: item);
      },
    );
  }
}

/// Tile representation of a single voucher item
class _VoucherItemTile extends StatelessWidget {
  const _VoucherItemTile({required this.item});

  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    final noteText = item.note != null && item.note!.trim().isNotEmpty
        ? (item.note!.startsWith('Note:') ? item.note! : 'Note: ${item.note}')
        : 'Note: Small carton preferred';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                    height: 24 / 16,
                  ),
                ),
                4.verticalSpace,
                Text(
                  noteText,
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
          Text(
            'Qty: ${item.quantityDisplay}',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Barcode footer section of the shopping voucher
class _VoucherBarcodeSection extends StatelessWidget {
  const _VoucherBarcodeSection({required this.voucherId});

  final String voucherId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        CustomPaint(
          size: Size(double.infinity, 1.h),
          painter: DottedLinePainter(
            color: AppColors.brandTealBorder,
            strokeWidth: 1.w,
            dash: 4.w,
            gap: 4.w,
          ),
        ),
        24.verticalSpace,
        Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.inputBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: CustomPaint(
              size: Size(160.w, 24.h),
              painter: BarcodePainter(
                color: AppColors.headerTextColor.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
        8.verticalSpace,
        Text(
          'VOUCHER-ID: $voucherId',
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            height: 18 / 12,
          ),
        ),
      ],
    );
  }
}

/// Final Note editable component for the voucher
class _VoucherFinalNoteSection extends StatelessWidget {
  const _VoucherFinalNoteSection({
    required this.controller,
    required this.isEditing,
  });

  final TextEditingController controller;
  final ValueNotifier<bool> isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Final Note (Optional)',
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackTextColor,
            height: 24 / 16,
          ),
        ),
        8.verticalSpace,
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.inputBorder,
              width: 1.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: isEditing.value
                    ? TextField(
                        controller: controller,
                        maxLines: null,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mutedTextColor,
                          height: 18 / 12,
                        ),
                        decoration: const InputDecoration(
                          filled: false,
                          fillColor: Colors.transparent,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      )
                    : Text(
                        controller.text,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mutedTextColor,
                          height: 18 / 12,
                        ),
                      ),
              ),
              8.horizontalSpace,
              Row(
                children: [
                  if (isEditing.value)
                    GestureDetector(
                      onTap: () {
                        isEditing.value = false;
                        showGlobalToast(
                            message: LangKey.parentKitchen.finalNoteSaved);
                      },
                      child: SvgPicture.asset(
                        AppAssets.icSave,
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.headerTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        isEditing.value = true;
                      },
                      child: SvgPicture.asset(
                        AppAssets.icEdit,
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.headerTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Fixed action buttons at the bottom of the voucher screen
class _VoucherBottomActionBar extends StatelessWidget {
  const _VoucherBottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: AppColors.inputBorder.withValues(alpha: 0.5),
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            label: 'Order from store',
            variant: ButtonVariant.primary,
            color: AppColors.primaryColor,
            isFullWidth: true,
            onPressed: () {
              showAppSheet<void>(
                child: const ChooseStoreSheet(),
              );
            },
            height: ButtonSize.medium,
          ),
          12.verticalSpace,
          AppButton(
            label: 'Download PDF',
            variant: ButtonVariant.outline,
            textColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            isFullWidth: true,
            onPressed: () {
              showGlobalToast(message: LangKey.parentKitchen.downloadingPdf);
            },
            height: ButtonSize.medium,
            prefixIcon: SvgPicture.asset(
              AppAssets.icPdfDownload,
              width: 18.w,
              height: 18.w,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarcodePainter extends CustomPainter {
  final Color color;

  const BarcodePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pattern = [
      2.0,
      1.5,
      3.0,
      1.0,
      4.0,
      2.0,
      1.0,
      3.0,
      1.5,
      2.5,
      1.0,
      4.0,
      2.0,
      1.5,
      3.0,
      1.0,
      2.0,
      3.5,
      1.0,
      2.0,
      4.0,
      1.5,
      2.0,
      1.0,
      3.0,
      2.0,
      1.0,
      4.0,
      1.5,
      2.0
    ];

    double currentX = 0;
    for (int i = 0; i < pattern.length; i++) {
      final width = pattern[i];
      if (i % 2 == 0) {
        canvas.drawRect(
          Rect.fromLTWH(currentX, 0, width, size.height),
          paint,
        );
      }
      currentX += width + 2.0;
    }
  }

  @override
  bool shouldRepaint(covariant BarcodePainter oldDelegate) =>
      oldDelegate.color != color;
}
