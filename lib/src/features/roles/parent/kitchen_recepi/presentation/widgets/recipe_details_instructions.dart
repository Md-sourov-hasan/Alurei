import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeDetailsInstructions extends StatelessWidget {
  const RecipeDetailsInstructions({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentKitchen.stepByStepInstructions,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 24.h),
          Stack(
            children: [
              // Vertical timeline line
              Positioned(
                left: 16.w,
                top: 20.h,
                bottom: 20.h,
                child: Container(
                  width: 2.w,
                  color: context.theme.brightness == Brightness.dark
                      ? context.appColors.bottomNavBorder
                      : AppColors.brandTealBorder,
                ),
              ),

              // Timeline steps list
              Column(
                children: List.generate(recipe.instructions.length, (index) {
                  final step = recipe.instructions[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step number circle
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 32.w),

                        // Step instruction card
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(25.w),
                            decoration: BoxDecoration(
                              color: context.theme.brightness == Brightness.dark
                                  ? context.appColors.secondaryBackground
                                  : AppColors.brandGrayLight,
                              border: Border.all(
                                  color: context.appColors.bottomNavBorder,
                                  width: 1.w),
                              borderRadius: BorderRadius.circular(18.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              step,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: context.appColors.mutedText,
                                height: 24 / 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
