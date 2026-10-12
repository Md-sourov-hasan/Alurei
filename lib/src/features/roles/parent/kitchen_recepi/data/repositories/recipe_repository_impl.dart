import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/services/kitchen_service.dart';
import '../../domain/entities/kitchen_recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../models/recipe_detail_model.dart';
import '../models/recipe_model.dart';
import '../models/recipe_suggestion_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl({KitchenService? kitchenService})
      : _kitchenService = kitchenService ?? KitchenService.instance;

  final KitchenService _kitchenService;

  @override
  FutureEither<List<KitchenRecipe>> getRecipeSuggestions({
    required String ageGroup,
  }) async {
    final result = await _kitchenService.getRecipeSuggestions(
      ageGroup: ageGroup,
    );

    return result.map(
      (jsonList) => jsonList
          .map((json) => RecipeSuggestionModel.fromJson(json).toEntity())
          .toList(),
    );
  }

  @override
  FutureEither<List<KitchenRecipe>> getAllRecipes() async {
    final result = await _kitchenService.getAllRecipes();
    return result.map(
      (jsonList) => jsonList
          .map((json) => RecipeModel.fromJson(json).toEntity())
          .toList(),
    );
  }

  @override
  FutureEither<KitchenRecipe> getRecipeById(String id) async {
    final result = await _kitchenService.getRecipeById(id);
    return result.map(
      (json) => RecipeDetailModel.fromJson(json).toEntity(),
    );
  }

  @override
  FutureEither<Map<String, dynamic>> addScheduleFromLibrary({
    required String childId,
    required String date,
    required String libraryItemId,
    String libraryItemType = 'recipe',
    String startTime = '09:15',
    String endTime = '10:00',
    String? description,
  }) {
    return _kitchenService.addScheduleFromLibrary(
      childId: childId,
      date: date,
      libraryItemId: libraryItemId,
      libraryItemType: libraryItemType,
      startTime: startTime,
      endTime: endTime,
      description: description,
    );
  }
}
