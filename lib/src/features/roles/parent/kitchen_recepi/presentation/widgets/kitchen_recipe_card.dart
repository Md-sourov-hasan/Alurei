import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/kitchen_recipe.dart';

/// Vertical recipe card used in the "Suggested for you" horizontal list.
/// Figma: Breakfast Card (302×451) — node 23650-12327.
class KitchenRecipeCard extends StatelessWidget {
  const KitchenRecipeCard({
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
      width: 302.w,
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
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top: meal-type badge + status ─────────────────────────────
          _buildHeader(),

          SizedBox(height: 12.h),

          // ── Image ─────────────────────────────────────────────────────
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: recipe.imageAsset.startsWith('http')
                  ? Image.network(
                      recipe.imageAsset,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bottomNavSelectedBackground,
                        alignment: Alignment.center,
                        child: Icon(
                          IconsaxPlusLinear.gallery,
                          size: 40.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : Image.asset(
                      recipe.imageAsset,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bottomNavSelectedBackground,
                        alignment: Alignment.center,
                        child: Icon(
                          IconsaxPlusLinear.gallery,
                          size: 40.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
            ),
          ),

          SizedBox(height: 8.h),

          // ── Title + age ────────────────────────────────────────────────
          _buildInfo(),

          SizedBox(height: 8.h),

          // ── Tags ───────────────────────────────────────────────────────
          _buildTags(),

          SizedBox(height: 8.h),

          // ── Buttons ────────────────────────────────────────────────────
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Meal type pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.mealTypeBadgeBg,
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Text(
            switch (recipe.mealType) {
              RecipeMealType.breakfast => LangKey.parentKitchen.mealBreakfast,
              RecipeMealType.lunch => LangKey.parentKitchen.mealLunch,
              RecipeMealType.dinner => LangKey.parentKitchen.mealDinner,
              RecipeMealType.snacks => LangKey.parentKitchen.mealSnacks,
            },
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              height: 18 / 12,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        // Status badge
        RecipeStatusBadge(status: recipe.status),
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
            color: AppColors.headerTextColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
      ],
    );
  }

  Widget _buildTags() {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: recipe.tags
            .map(
              (tag) => Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Container(
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
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
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
    );
  }
}

// ── Status badge ─────────────────────────────────────────────────────────────
class RecipeStatusBadge extends StatelessWidget {
  const RecipeStatusBadge({super.key, required this.status});
  final RecipeStatus status;

  @override
  Widget build(BuildContext context) {
    final isReady = status == RecipeStatus.ready;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isReady ? context.appColors.success : context.colors.error,
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isReady) SvgPicture.asset(
                  AppAssets.icKitchenDone,
                  width: 12.w,
                  height: 12.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ) else Icon(
                  IconsaxPlusLinear.shopping_cart,
                  size: 12.w,
                  color: AppColors.whiteColor,
                ),
          SizedBox(width: 4.w),
          Text(
            switch (status) {
              RecipeStatus.ready => LangKey.parentKitchen.ready,
              RecipeStatus.needsIngredients =>
                LangKey.parentKitchen.needsIngredients,
            },
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
