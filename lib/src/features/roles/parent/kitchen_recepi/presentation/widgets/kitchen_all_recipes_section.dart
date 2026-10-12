import 'package:alurei/src/imports/imports.dart';
import '../controllers/base_kitchen_controller.dart';
import 'kitchen_recipe_card_horizontal.dart';

class KitchenAllRecipesSection extends GetView<BaseKitchenController> {
  const KitchenAllRecipesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recipes = controller.filteredAllRecipes;
      final isLoading = controller.isAllRecipesLoading.value;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangKey.parentKitchen.allRecipes,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                height: 32 / 24,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (recipes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'No recipes found',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondaryTeal,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recipes.length,
                separatorBuilder: (_, __) => SizedBox(height: 20.h),
                itemBuilder: (context, i) {
                  final recipe = recipes[i];
                  return KitchenRecipeCardHorizontal(
                    recipe: recipe,
                    onViewRecipe: () => controller.onViewRecipe(recipe),
                    onAddToSchedule: () => controller.onAddToSchedule(recipe),
                  );
                },
              ),
          ],
        ),
      );
    });
  }
}
