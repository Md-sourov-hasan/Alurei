import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeSuggestionModel {
  const RecipeSuggestionModel({
    required this.id,
    required this.name,
    required this.recipeMealType,
    required this.status,
    required this.missingIngredients,
    required this.ageSuitability,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String recipeMealType;
  final String status;
  final List<String> missingIngredients;
  final String ageSuitability;
  final String? imageUrl;

  factory RecipeSuggestionModel.fromJson(Map<String, dynamic> json) {
    return RecipeSuggestionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      recipeMealType: json['recipeMealType'] as String? ?? 'SNACK',
      status: json['status'] as String? ?? '',
      missingIngredients: (json['missingIngredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      ageSuitability: json['ageSuitability'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
    );
  }

  KitchenRecipe toEntity() {
    final mealTypeUpper = recipeMealType.toUpperCase();
    final mealType = switch (mealTypeUpper) {
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

    final localFallback = id.hashCode.isEven
        ? AppAssets.recipeBlueberryOatPorridge
        : AppAssets.recipeMashedSweetPotato;

    return KitchenRecipe(
      id: id,
      title: name,
      mealType: mealType,
      status: recipeStatus,
      ageSuitability: ageSuitability.isNotEmpty ? ageSuitability : '6-9 months',
      imageAsset: (imageUrl != null && imageUrl!.isNotEmpty)
          ? imageUrl!
          : localFallback,
      tags: const ['ENERGY', 'GROWTH', 'IMMUNITY'],
      ingredients: ingredientList,
    );
  }
}
