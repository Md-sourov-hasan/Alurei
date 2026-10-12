import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_recipe_details_controller.dart';
import '../widgets/recipe_details_info_card.dart';
import '../widgets/recipe_details_nutritional_focus.dart';
import '../widgets/recipe_details_ingredients.dart';
import '../widgets/recipe_details_optional.dart';
import '../widgets/recipe_details_instructions.dart';
import '../widgets/recipe_details_safety_notes.dart';
import '../widgets/recipe_details_bottom_actions.dart';
import '../widgets/kitchen_recipe_card.dart'; // Import for RecipeStatusBadge

class ParentRecipeDetailsScreen extends GetView<ParentRecipeDetailsController> {
  const ParentRecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: const AppTopBar(
        title: '',
        isTransparent: true,
        showBackButton: true,
      ),
      body: Obx(() {
        final recipe = controller.recipe.value;

        if (controller.isLoading.value && recipe == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (recipe == null) {
          return Center(
            child: Text(LangKey.parentKitchen.noRecipeDataFound),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Image + Status Badge Overlay
                    Stack(
                      children: [
                        CommonImage(
                          imageUrl: recipe.imageAsset,
                          height: 236.h,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: RecipeStatusBadge(status: recipe.status),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // 2. Title & Basic Info
                    RecipeDetailsInfoCard(recipe: recipe),
                    SizedBox(height: 16.h),

                    // 3. Nutritional Focus
                    RecipeDetailsNutritionalFocus(recipe: recipe),
                    SizedBox(height: 16.h),

                    // 4. Ingredients
                    RecipeDetailsIngredients(recipe: recipe),
                    SizedBox(height: 16.h),

                    // 5. Optional Ingredients (if any)
                    if (recipe.optionalIngredients.isNotEmpty) ...[
                      RecipeDetailsOptional(recipe: recipe),
                      SizedBox(height: 16.h),
                    ],

                    // 6. Step-by-Step Instructions
                    if (recipe.instructions.isNotEmpty) ...[
                      RecipeDetailsInstructions(recipe: recipe),
                      SizedBox(height: 16.h),
                    ],

                    // 7. Safety Notes
                    if (recipe.safetyNote != null && recipe.safetyNote!.isNotEmpty)
                      RecipeDetailsSafetyNotes(recipe: recipe),
                  ],
                ),
              ),
              if (recipe.safetyNote != null && recipe.safetyNote!.isNotEmpty)
                SizedBox(height: 24.h)
              else
                SizedBox(height: 16.h),

              // 8. Bottom Actions (Add to Schedule / Cancel)
              RecipeDetailsBottomActions(recipe: recipe),
            ],
          ),
        );
      }),
    );
  }
}
