import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeModel {
  const RecipeModel({
    required this.id,
    required this.title,
    required this.category,
    required this.ageSuitability,
    required this.prepTimeMin,
    required this.cookTimeMin,
    required this.difficulty,
    required this.servings,
    required this.nutritionalFocus,
    required this.status,
    required this.missingIngredients,
    this.imageUrl,
    this.shortDescription,
  });

  final String id;
  final String title;
  final String category;
  final String ageSuitability;
  final int prepTimeMin;
  final int cookTimeMin;
  final String difficulty;
  final String servings;
  final List<String> nutritionalFocus;
  final String status;
  final List<String> missingIngredients;
  final String? imageUrl;
  final String? shortDescription;

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? 'SNACK',
      ageSuitability: json['ageSuitability'] as String? ?? '',
      prepTimeMin: (json['prepTimeMin'] as num?)?.toInt() ?? 5,
      cookTimeMin: (json['cookTimeMin'] as num?)?.toInt() ?? 10,
      difficulty: json['difficulty'] as String? ?? 'EASY',
      servings: json['servings'] as String? ?? '2',
      nutritionalFocus: (json['nutritionalFocus'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      status: json['status'] as String? ?? '',
      missingIngredients: (json['missingIngredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      imageUrl: json['imageUrl'] as String?,
      shortDescription: json['shortDescription'] as String?,
    );
  }

  KitchenRecipe toEntity() {
    final catUpper = category.toUpperCase();
    final mealType = switch (catUpper) {
      'BREAKFAST' => RecipeMealType.breakfast,
      'LUNCH' => RecipeMealType.lunch,
      'DINNER' => RecipeMealType.dinner,
      _ => RecipeMealType.snacks,
    };

    final isNeeds = status.toLowerCase().contains('need');
    final recipeStatus =
        isNeeds ? RecipeStatus.needsIngredients : RecipeStatus.ready;

    final ingredientList = missingIngredients
        .map(
          (ing) => RecipeIngredient(
            name: ing,
            substitute: '',
            quantity: '1 unit',
            isAvailable: false,
          ),
        )
        .toList();

    final formattedDifficulty = difficulty.isNotEmpty
        ? difficulty[0].toUpperCase() + difficulty.substring(1).toLowerCase()
        : 'Easy';

    final localFallback = id.hashCode.isEven
        ? AppAssets.kitchenItem1
        : AppAssets.kitchenItem2;

    return KitchenRecipe(
      id: id,
      title: title,
      mealType: mealType,
      status: recipeStatus,
      ageSuitability: ageSuitability.isNotEmpty ? ageSuitability : '1 year+',
      imageAsset: (imageUrl != null && imageUrl!.isNotEmpty)
          ? imageUrl!
          : localFallback,
      tags: nutritionalFocus.isNotEmpty
          ? nutritionalFocus.map((e) => e.toUpperCase()).toList()
          : const ['ENERGY', 'GROWTH', 'IMMUNITY'],
      prepTime: '$prepTimeMin min Prep',
      cookTime: '$cookTimeMin min Cook',
      difficulty: formattedDifficulty,
      servings: servings,
      ingredients: ingredientList,
    );
  }
}
