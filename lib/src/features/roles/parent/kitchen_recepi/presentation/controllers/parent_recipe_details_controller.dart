import 'package:alurei/src/imports/imports.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/entities/kitchen_recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class ParentRecipeDetailsController extends GetxController {
  final RecipeRepository _recipeRepository = RecipeRepositoryImpl();

  final recipe = Rxn<KitchenRecipe>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final initialArg = Get.arguments;
    if (initialArg is KitchenRecipe) {
      recipe.value = initialArg;
      fetchRecipeDetails(initialArg.id);
    } else if (initialArg is String) {
      fetchRecipeDetails(initialArg);
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchRecipeDetails(String id) async {
    isLoading.value = true;
    final result = await _recipeRepository.getRecipeById(id);

    result.fold(
      (failure) {
        AppLogger.error(
            'Failed to load recipe details for ID $id: ${failure.message}');
      },
      (detailedRecipe) {
        recipe.value = detailedRecipe;
      },
    );

    isLoading.value = false;
  }
}
