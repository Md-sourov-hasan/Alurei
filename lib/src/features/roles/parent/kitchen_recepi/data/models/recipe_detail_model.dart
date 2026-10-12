import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeIngredientItemModel {
  const RecipeIngredientItemModel({
    required this.id,
    required this.name,
    required this.amount,
    this.unit,
    this.isOptional = false,
  });

  final String id;
  final String name;
  final String amount;
  final String? unit;
  final bool isOptional;

  factory RecipeIngredientItemModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientItemModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      amount: json['amount'] as String? ?? '1',
      unit: json['unit'] as String?,
      isOptional: json['isOptional'] as bool? ?? false,
    );
  }

  RecipeIngredient toEntity() {
    final qty = unit != null && unit!.isNotEmpty
        ? '$amount $unit'
        : (amount.isNotEmpty ? amount : '1 unit');
    return RecipeIngredient(
      name: name,
      substitute: '',
      quantity: qty,
      isAvailable: false,
    );
  }

  String toOptionalString() {
    final qty = unit != null && unit!.isNotEmpty ? '$amount $unit' : amount;
    return '$name | $qty';
  }
}

class RecipeStepInstructionModel {
  const RecipeStepInstructionModel({
    required this.id,
    required this.stepNumber,
    required this.description,
  });

  final String id;
  final int stepNumber;
  final String description;

  factory RecipeStepInstructionModel.fromJson(Map<String, dynamic> json) {
    return RecipeStepInstructionModel(
      id: json['id'] as String? ?? '',
      stepNumber: (json['stepNumber'] as num?)?.toInt() ?? 1,
      description: json['description'] as String? ?? '',
    );
  }
}

class RecipeDetailModel {
  const RecipeDetailModel({
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
    required this.requiredIngredients,
    required this.optionalIngredients,
    required this.instructions,
    this.imageUrl,
    this.shortDescription,
    this.videoUrl,
    this.cookingTips,
    this.safetyNotes,
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
  final List<RecipeIngredientItemModel> requiredIngredients;
  final List<RecipeIngredientItemModel> optionalIngredients;
  final List<RecipeStepInstructionModel> instructions;
  final String? imageUrl;
  final String? shortDescription;
  final String? videoUrl;
  final String? cookingTips;
  final String? safetyNotes;

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    List<RecipeIngredientItemModel> reqIng = [];
    List<RecipeIngredientItemModel> optIng = [];

    final rawIngredients = json['ingredients'];
    if (rawIngredients is Map<String, dynamic>) {
      if (rawIngredients['required'] is List) {
        reqIng = (rawIngredients['required'] as List)
            .whereType<Map<dynamic, dynamic>>()
            .map((e) =>
                RecipeIngredientItemModel.fromJson(e.cast<String, dynamic>()))
            .toList();
      }
      if (rawIngredients['optional'] is List) {
        optIng = (rawIngredients['optional'] as List)
            .whereType<Map<dynamic, dynamic>>()
            .map((e) =>
                RecipeIngredientItemModel.fromJson(e.cast<String, dynamic>()))
            .toList();
      }
    }

    List<RecipeStepInstructionModel> steps = [];
    if (json['stepByStepInstructions'] is List) {
      steps = (json['stepByStepInstructions'] as List)
          .whereType<Map<dynamic, dynamic>>()
          .map((e) =>
              RecipeStepInstructionModel.fromJson(e.cast<String, dynamic>()))
          .toList();
      steps.sort((a, b) => a.stepNumber.compareTo(b.stepNumber));
    }

    return RecipeDetailModel(
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
      requiredIngredients: reqIng,
      optionalIngredients: optIng,
      instructions: steps,
      imageUrl: json['imageUrl'] as String?,
      shortDescription: json['shortDescription'] as String?,
      videoUrl: json['videoUrl'] as String?,
      cookingTips: json['cookingTips'] as String?,
      safetyNotes: json['safetyNotes'] as String?,
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
      ageSuitability: ageSuitability.isNotEmpty ? ageSuitability : '8-48m',
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
      ingredients: requiredIngredients.map((e) => e.toEntity()).toList(),
      optionalIngredients:
          optionalIngredients.map((e) => e.toOptionalString()).toList(),
      instructions: instructions.map((e) => e.description).toList(),
      safetyNote: safetyNotes,
    );
  }
}
