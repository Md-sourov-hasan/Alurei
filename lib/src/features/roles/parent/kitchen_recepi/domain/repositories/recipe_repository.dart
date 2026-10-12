import 'package:alurei/src/imports/core_imports.dart';
import '../entities/kitchen_recipe.dart';

abstract class RecipeRepository {
  FutureEither<List<KitchenRecipe>> getRecipeSuggestions({
    required String ageGroup,
  });

  FutureEither<List<KitchenRecipe>> getAllRecipes();

  FutureEither<KitchenRecipe> getRecipeById(String id);

  FutureEither<Map<String, dynamic>> addScheduleFromLibrary({
    required String childId,
    required String date,
    required String libraryItemId,
    String libraryItemType = 'recipe',
    String startTime = '09:15',
    String endTime = '10:00',
    String? description,
  });
}
