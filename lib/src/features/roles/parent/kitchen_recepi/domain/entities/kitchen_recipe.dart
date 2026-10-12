import 'package:alurei/src/imports/imports.dart';

enum KitchenTab { recipes, groceries }

enum RecipeMealType {
  breakfast('BREAKFAST'),
  lunch('LUNCH'),
  dinner('DINNER'),
  snacks('SNACKS');

  const RecipeMealType(this.label);
  final String label;
}

enum RecipeStatus { ready, needsIngredients }

class RecipeIngredient extends Equatable {
  const RecipeIngredient({
    required this.name,
    required this.substitute,
    required this.quantity,
    required this.isAvailable,
  });

  final String name;
  final String substitute;
  final String quantity;
  final bool isAvailable;

  @override
  List<Object?> get props => [name, substitute, quantity, isAvailable];
}

class KitchenRecipe extends Equatable {
  const KitchenRecipe({
    required this.id,
    required this.title,
    required this.mealType,
    required this.status,
    required this.ageSuitability,
    required this.imageAsset,
    required this.tags,
    this.prepTime = '5 min',
    this.cookTime = '10 min',
    this.difficulty = 'Easy',
    this.servings = '2-3',
    this.ingredients = const [],
    this.optionalIngredients = const [],
    this.instructions = const [],
    this.safetyNote,
  });

  final String id;
  final String title;
  final RecipeMealType mealType;
  final RecipeStatus status;
  final String ageSuitability;
  final String imageAsset;
  final List<String> tags;
  final String prepTime;
  final String cookTime;
  final String difficulty;
  final String servings;
  final List<RecipeIngredient> ingredients;
  final List<String> optionalIngredients;
  final List<String> instructions;
  final String? safetyNote;

  @override
  List<Object?> get props => [
        id,
        title,
        mealType,
        status,
        ageSuitability,
        imageAsset,
        tags,
        prepTime,
        cookTime,
        difficulty,
        servings,
        ingredients,
        optionalIngredients,
        instructions,
        safetyNote,
      ];
}

class KitchenData extends Equatable {
  const KitchenData({
    required this.suggestedRecipes,
    required this.allRecipes,
    required this.childNames,
  });

  final List<KitchenRecipe> suggestedRecipes;
  final List<KitchenRecipe> allRecipes;

  /// Child name tabs shown above "Suggested for you" section.
  final List<String> childNames;

  static KitchenData get mockData => const KitchenData(
        suggestedRecipes: [
          KitchenRecipe(
            id: 'r1',
            title: 'Blueberry Oat Porridge',
            mealType: RecipeMealType.breakfast,
            status: RecipeStatus.needsIngredients,
            ageSuitability: '6-24 months',
            imageAsset: AppAssets.kitchenItem2,
            tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
            prepTime: '5 min Prep',
            cookTime: '10 min Cook',
            difficulty: 'Easy',
            servings: '2-3',
            ingredients: [
              RecipeIngredient(
                name: 'Organic Banana',
                substitute: 'apple puree',
                quantity: '1 unit',
                isAvailable: false,
              ),
              RecipeIngredient(
                name: 'Egg',
                substitute: 'flax egg',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Oats',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Olive oil',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
            ],
            optionalIngredients: [
              'Olive oil | 1 | tsp | pantry',
            ],
            instructions: [
              'Mash banana in a bowl until completely smooth with no lumps.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add a small amount of oil and spread evenly.',
              'Spoon batter into small rounds.',
              'Cook for 2–3 minutes until bubbles appear and edges set.',
              'Flip and cook for 2 more minutes until golden and firm.',
            ],
            safetyNote: 'Cut into small pieces for toddlers.',
          ),
          KitchenRecipe(
            id: 'r2',
            title: 'Mashed Sweet Potato & Salmon',
            mealType: RecipeMealType.breakfast,
            status: RecipeStatus.ready,
            ageSuitability: '6-12m',
            imageAsset: AppAssets.kitchenItem1,
            tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
            prepTime: '5 min Prep',
            cookTime: '15 min Cook',
            difficulty: 'Easy',
            servings: '2-3',
            ingredients: [
              RecipeIngredient(
                name: 'Salmon Fillet',
                substitute: 'cod fillet',
                quantity: '100g',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Sweet Potato',
                substitute: 'pumpkin',
                quantity: '1 medium',
                isAvailable: true,
              ),
            ],
            optionalIngredients: [
              'Olive oil | 1 | tsp | pantry',
            ],
            instructions: [
              'Steam or bake the sweet potato until completely soft.',
              'Steam the salmon fillet until cooked through and flakes easily.',
              'Mash both together in a bowl until smooth, checking carefully for bones.',
            ],
          ),
        ],
        allRecipes: [
          KitchenRecipe(
            id: 'r3',
            title: 'Blueberry Oat Porridge',
            mealType: RecipeMealType.breakfast,
            status: RecipeStatus.ready,
            ageSuitability: '6-24 months',
            imageAsset: AppAssets.kitchenItem2,
            tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
            prepTime: '5 min Prep',
            cookTime: '10 min Cook',
            difficulty: 'Easy',
            servings: '2-3',
            ingredients: [
              RecipeIngredient(
                name: 'Organic Banana',
                substitute: 'apple puree',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Egg',
                substitute: 'flax egg',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Oats',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Olive oil',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
            ],
            optionalIngredients: [
              'Olive oil | 1 | tsp | pantry',
            ],
            instructions: [
              'Mash banana in a bowl until completely smooth with no lumps.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add a small amount of oil and spread evenly.',
              'Spoon batter into small rounds.',
              'Cook for 2–3 minutes until bubbles appear and edges set.',
              'Flip and cook for 2 more minutes until golden and firm.',
            ],
            safetyNote: 'Cut into small pieces for toddlers.',
          ),
          KitchenRecipe(
            id: 'r4',
            title: 'Blueberry Oat Porridge',
            mealType: RecipeMealType.lunch,
            status: RecipeStatus.needsIngredients,
            ageSuitability: '6-24 months',
            imageAsset: AppAssets.kitchenItem2,
            tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
            prepTime: '5 min Prep',
            cookTime: '10 min Cook',
            difficulty: 'Easy',
            servings: '2-3',
            ingredients: [
              RecipeIngredient(
                name: 'Organic Banana',
                substitute: 'apple puree',
                quantity: '1 unit',
                isAvailable: false,
              ),
              RecipeIngredient(
                name: 'Egg',
                substitute: 'flax egg',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Oats',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Olive oil',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
            ],
            optionalIngredients: [
              'Olive oil | 1 | tsp | pantry',
            ],
            instructions: [
              'Mash banana in a bowl until completely smooth with no lumps.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add a small amount of oil and spread evenly.',
              'Spoon batter into small rounds.',
              'Cook for 2–3 minutes until bubbles appear and edges set.',
              'Flip and cook for 2 more minutes until golden and firm.',
            ],
            safetyNote: 'Cut into small pieces for toddlers.',
          ),
          KitchenRecipe(
            id: 'r5',
            title: 'Blueberry Oat Porridge',
            mealType: RecipeMealType.breakfast,
            status: RecipeStatus.ready,
            ageSuitability: '6-24 months',
            imageAsset: AppAssets.kitchenItem2,
            tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
            prepTime: '5 min Prep',
            cookTime: '10 min Cook',
            difficulty: 'Easy',
            servings: '2-3',
            ingredients: [
              RecipeIngredient(
                name: 'Organic Banana',
                substitute: 'apple puree',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Egg',
                substitute: 'flax egg',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Oats',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
              RecipeIngredient(
                name: 'Olive oil',
                substitute: 'oat flour',
                quantity: '1 unit',
                isAvailable: true,
              ),
            ],
            optionalIngredients: [
              'Olive oil | 1 | tsp | pantry',
            ],
            instructions: [
              'Mash banana in a bowl until completely smooth with no lumps.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add egg and oats and mix until a thick batter forms.',
              'Add a small amount of oil and spread evenly.',
              'Spoon batter into small rounds.',
              'Cook for 2–3 minutes until bubbles appear and edges set.',
              'Flip and cook for 2 more minutes until golden and firm.',
            ],
            safetyNote: 'Cut into small pieces for toddlers.',
          ),
        ],
        childNames: const ['Eve', 'Rose'],
      );

  @override
  List<Object?> get props => [suggestedRecipes, allRecipes, childNames];
}
