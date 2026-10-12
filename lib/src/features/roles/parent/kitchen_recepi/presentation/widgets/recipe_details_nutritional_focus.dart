import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeDetailsNutritionalFocus extends StatelessWidget {
  const RecipeDetailsNutritionalFocus({
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
            LangKey.parentKitchen.nutritionalFocus,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: recipe.tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: context.appColors.bottomNavSelectedBackground,
                  border: Border.all(
                    color: context.theme.brightness == Brightness.dark
                        ? context.appColors.bottomNavBorder
                        : AppColors.brandTealBorder,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Text(
                  switch (tag.toUpperCase()) {
                    'ENERGY' => LangKey.parentKitchen.tagEnergy,
                    'GROWTH' => LangKey.parentKitchen.tagGrowth,
                    'IMMUNITY' => LangKey.parentKitchen.tagImmunity,
                    _ => tag,
                  },
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
