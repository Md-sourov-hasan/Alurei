import 'package:alurei/src/imports/imports.dart';

class CareInsightsCelebrateCard extends StatelessWidget {
  const CareInsightsCelebrateCard({
    super.key,
    required this.selectedBonusIndex,
  });

  final ValueNotifier<int> selectedBonusIndex;

  @override
  Widget build(BuildContext context) {
    final bonusAmounts = ['20 AED', '25 AED', '30 AED', 'Custom'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentCare.celebrateGreatWeek,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Deepa maintained a Care Score above 90% this week and successfully completed two care modules. Would you like to send a small token of appreciation for her dedication?',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              height: 1.45,
              color: const Color(0xFF475569),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Want to send a thank you?',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 10.h),
          ValueListenableBuilder<int>(
            valueListenable: selectedBonusIndex,
            builder: (context, selectedIdx, _) {
              return Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(bonusAmounts.length, (index) {
                  final isSelected = selectedIdx == index;
                  return GestureDetector(
                    onTap: () {
                      selectedBonusIndex.value = index;
                      if (index == 3) {
                        _showCustomAmountDialog(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 9.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF009688)
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF009688)
                              : const Color(0xFF80CBC4),
                          width: 1.w,
                        ),
                      ),
                      child: Text(
                        bonusAmounts[index],
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.whiteColor
                              : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              if (selectedBonusIndex.value == 3) {
                _showCustomAmountDialog(context);
              } else {
                showGlobalToast(message: LangKey.shared.appreciationSent);
              }
            },
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  LangKey.parentCare.sendAppreciation,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                LangKey.parentCare.maybeLater,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomAmountDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        final amountController = TextEditingController();

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(22.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFA),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Icon(
                      Icons.close,
                      size: 20.w,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Input amount',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: amountController,
                  hint: 'e:g: 50 AED',
                  keyboardType: TextInputType.number,
                  borderColor: const Color(0xFF80CBC4),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F6),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(ctx).pop();
                          showGlobalToast(message: LangKey.shared.appreciationSent);
                        },
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF009688),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(
                            child: Text(
                              LangKey.parentCare.sendAppreciation,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
