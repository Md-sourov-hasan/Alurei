import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';
import 'dashed_border_painter.dart';

class RecipeDetailsOptional extends StatelessWidget {
  const RecipeDetailsOptional({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: context.theme.brightness == Brightness.dark
            ? context.appColors.bottomNavBorder
            : AppColors.brandTealBorder,
        strokeWidth: 2.w,
        gap: 6.w,
        radius: 24.r,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangKey.parentKitchen.optional,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.primary,
                height: 32 / 24,
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              children: recipe.optionalIngredients.map((opt) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(21.w),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.04),
                    border: Border.all(
                        color: context.appColors.bottomNavBorder, width: 1.w),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.colors.primary, width: 2.w),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          opt,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: context.appColors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
