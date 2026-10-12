import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeDetailsInfoCard extends StatelessWidget {
  const RecipeDetailsInfoCard({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe.title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 20.h),

          // Grid of info cards
          _buildInfoRow(
            context,
            _buildInfoCard(
              context,
              switch (recipe.mealType) {
                RecipeMealType.breakfast => LangKey.parentKitchen.mealBreakfast,
                RecipeMealType.lunch => LangKey.parentKitchen.mealLunch,
                RecipeMealType.dinner => LangKey.parentKitchen.mealDinner,
                RecipeMealType.snacks => LangKey.parentKitchen.mealSnacks,
              },
              svgAsset: AppAssets.icBreakfast,
            ),
            _buildInfoCard(
              context,
              recipe.ageSuitability,
              svgAsset: AppAssets.icMonths,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            _buildInfoCard(
              context,
              recipe.cookTime,
              svgAsset: AppAssets.icCookTime,
            ),
            _buildInfoCard(
              context,
              LangKey.parentKitchen.difficulty.tr(
                args: [
                  switch (recipe.difficulty.toLowerCase()) {
                    'easy' => LangKey.parentKitchen.difficultyEasy,
                    _ => recipe.difficulty,
                  },
                ],
              ),
              svgAsset: AppAssets.icDifficulty,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            _buildInfoCard(
              context,
              recipe.prepTime,
              svgAsset: AppAssets.icPrepTime,
            ),
            _buildInfoCard(
              context,
              LangKey.parentKitchen.servings.tr(
                args: [recipe.servings.toString()],
              ),
              svgAsset: AppAssets.icServing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: 12.w),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String text, {
    IconData? icon,
    String? svgAsset,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          if (svgAsset != null)
            SvgPicture.asset(
              svgAsset,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                context.colors.primary,
                BlendMode.srcIn,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              size: 20.w,
              color: context.colors.primary,
            ),
          SizedBox(height: 4.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
