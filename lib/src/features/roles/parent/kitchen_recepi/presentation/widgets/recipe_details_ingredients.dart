import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeDetailsIngredients extends StatelessWidget {
  const RecipeDetailsIngredients({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  @override
  Widget build(BuildContext context) {
    final errorColor = context.colors.error;
    final successColor = context.appColors.success;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentKitchen.ingredients,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 24.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipe.ingredients.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, i) {
              final ing = recipe.ingredients[i];
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ing.isAvailable
                      ? context.appColors.secondaryBackground
                      : errorColor.withValues(alpha: 0.1),
                  border: Border.all(
                    color: ing.isAvailable
                        ? context.appColors.bottomNavBorder
                        : errorColor.withValues(alpha: 0.15),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  children: [
                    // Checkbox / Circle indicator
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: ing.isAvailable
                            ? context.colors.primary
                            : AppColors.transparentColor,
                        border: Border.all(
                          color: ing.isAvailable
                              ? context.colors.primary
                              : errorColor.withValues(alpha: 0.3),
                          width: 2.w,
                        ),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: ing.isAvailable
                          ? Icon(
                              Icons.check,
                              size: 14.w,
                              color: AppColors.whiteColor,
                            )
                          : Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                color: errorColor.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: errorColor,
                                  width: 1.5.w,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                    ),
                    SizedBox(width: 16.w),

                    // Ingredient name and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ing.name,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ing.isAvailable
                                  ? context.appColors.strongText
                                  : errorColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            LangKey.parentKitchen.substitute.tr(
                              args: [ing.substitute],
                            ),
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quantity badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: context.appColors.secondaryBackground,
                        border: Border.all(
                          color: context.theme.brightness == Brightness.dark
                              ? context.appColors.bottomNavBorder
                              : AppColors.brandTealBorder,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        ing.quantity,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.mutedText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
