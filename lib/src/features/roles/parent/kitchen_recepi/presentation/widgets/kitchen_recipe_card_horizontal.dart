import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/kitchen_recipe.dart';
import 'kitchen_recipe_card.dart';

/// Full-width recipe card used in the "All recipes" vertical list.
/// Figma: Breakfast Card (full-width) — node 23650-12389.
class KitchenRecipeCardHorizontal extends StatelessWidget {
  const KitchenRecipeCardHorizontal({
    super.key,
    required this.recipe,
    required this.onViewRecipe,
    required this.onAddToSchedule,
  });

  final KitchenRecipe recipe;
  final VoidCallback onViewRecipe;
  final VoidCallback onAddToSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.recipeCardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top: meal-type badge + status ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.mealTypeBadgeBg,
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Text(
                  switch (recipe.mealType) {
                    RecipeMealType.breakfast =>
                      LangKey.parentKitchen.mealBreakfast,
                    RecipeMealType.lunch => LangKey.parentKitchen.mealLunch,
                    RecipeMealType.dinner => LangKey.parentKitchen.mealDinner,
                    RecipeMealType.snacks => LangKey.parentKitchen.mealSnacks,
                  },
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              RecipeStatusBadge(status: recipe.status),
            ],
          ),

          SizedBox(height: 12.h),

          // ── Image ──────────────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              width: double.infinity,
              height: 219.h,
              child: recipe.imageAsset.startsWith('http')
                  ? Image.network(
                      recipe.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bottomNavSelectedBackground,
                        alignment: Alignment.center,
                        child: Icon(
                          IconsaxPlusLinear.gallery,
                          size: 48.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : Image.asset(
                      recipe.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bottomNavSelectedBackground,
                        alignment: Alignment.center,
                        child: Icon(
                          IconsaxPlusLinear.gallery,
                          size: 48.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
            ),
          ),

          SizedBox(height: 8.h),

          // ── Title + age ─────────────────────────────────────────────────
          Text(
            recipe.title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              height: 28 / 18,
              color: AppColors.headerTextColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            LangKey.parentKitchen.ageSuitability
                .replaceAll('{}', recipe.ageSuitability),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              color: AppColors.mutedTextColor,
            ),
          ),

          SizedBox(height: 8.h),

          // ── Tags ────────────────────────────────────────────────────────
          Wrap(
            spacing: 8.w,
            children: recipe.tags
                .map(
                  (tag) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bottomNavSelectedBackground,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      switch (tag.toUpperCase()) {
                        'ENERGY' => LangKey.parentKitchen.tagEnergy,
                        'GROWTH' => LangKey.parentKitchen.tagGrowth,
                        'IMMUNITY' => LangKey.parentKitchen.tagImmunity,
                        _ => tag,
                      },
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mutedTextColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 8.h),

          // ── Buttons ─────────────────────────────────────────────────────
          // View Recipe — outlined
          AppButton(
            label: LangKey.parentKitchen.viewRecipe,
            onPressed: onViewRecipe,
            variant: ButtonVariant.outline,
            isFullWidth: true,
            height: ButtonSize.medium,
          ),

          SizedBox(height: 8.h),

          // Add to Schedule — filled
          AppButton(
            label: LangKey.parentKitchen.addToSchedule,
            onPressed: onAddToSchedule,
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: ButtonSize.medium,
            prefixIcon: SvgPicture.asset(
              AppAssets.icKitchenAdd,
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                AppColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
