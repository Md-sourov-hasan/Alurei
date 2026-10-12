import 'package:alurei/src/features/roles/parent/kitchen_grocery/data/repositories/kitchen_repository_impl.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/domain/entities/grocery_item.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/domain/repositories/kitchen_repository.dart';
import 'package:alurei/src/imports/imports.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/entities/kitchen_recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../widgets/missing_ingredients_sheet.dart';
import '../widgets/select_child_sheet.dart';

abstract class BaseKitchenController extends GetxController {
  final KitchenRepository _kitchenRepository = KitchenRepositoryImpl();
  final RecipeRepository _recipeRepository = RecipeRepositoryImpl();

  String get ownerStatus;

  final data = Rxn<KitchenData>();
  final isLoading = false.obs;
  final isSuggestionsLoading = false.obs;
  final isAllRecipesLoading = false.obs;
  final selectedTab = KitchenTab.recipes.obs;
  final selectedChildIndex = 0.obs;
  final selectedFilterIndex = 0.obs; // 0 = All, 1+ = category chips
  final searchQuery = ''.obs;
  final showFilters = true.obs;
  final isAiMenuOpen = false.obs;
  final notificationCount = 1.obs;
  final messageCount = 1.obs;

  void toggleAiMenu() => isAiMenuOpen.toggle();

  // ── Groceries Tab State ───────────────────────────────────────────────────
  final showShoppingListInTab = false.obs;
  final isShoppingListLoading = false.obs;

  void openShoppingListInTab() {
    showShoppingListInTab.value = true;
    fetchKitchenShoppingItems();
  }

  void backToInventoryInTab() {
    showShoppingListInTab.value = false;
  }

  final selectedGroceryFilter = GroceryFilter.all.obs;
  final isGroceriesSectionExpanded = true.obs;
  final groceryItems = <GroceryItem>[].obs;

  // ── Shopping List State & Actions ──────────────────────────────────────────
  final shoppingListItems = <ShoppingListItem>[].obs;

  void incrementShoppingItemQuantity(String id) {
    final idx = shoppingListItems.indexWhere((item) => item.id == id);
    if (idx != -1) {
      final current = shoppingListItems[idx];
      final step = current.unit == 'g' ? 50 : 1;
      shoppingListItems[idx] = current.copyWith(
        quantityValue: current.quantityValue + step,
      );
      shoppingListItems.refresh();
    }
  }

  void decrementShoppingItemQuantity(String id) {
    final idx = shoppingListItems.indexWhere((item) => item.id == id);
    if (idx != -1) {
      final current = shoppingListItems[idx];
      final step = current.unit == 'g' ? 50 : 1;
      final newValue = (current.quantityValue - step).clamp(1, 9999);
      shoppingListItems[idx] = current.copyWith(
        quantityValue: newValue,
      );
      shoppingListItems.refresh();
    }
  }

  void toggleShoppingItemEditing(String id) {
    final idx = shoppingListItems.indexWhere((item) => item.id == id);
    if (idx != -1) {
      final current = shoppingListItems[idx];
      shoppingListItems[idx] = current.copyWith(isEditing: !current.isEditing);
      shoppingListItems.refresh();
    }
  }

  void saveShoppingItemNote(String id, String? newNote) {
    final idx = shoppingListItems.indexWhere((item) => item.id == id);
    if (idx != -1) {
      final current = shoppingListItems[idx];
      shoppingListItems[idx] = current.copyWith(
        note: newNote?.trim().isEmpty ?? true ? null : newNote?.trim(),
        isEditing: false,
      );
      shoppingListItems.refresh();
      showGlobalToast(message: LangKey.parentKitchen.noteSaved);
    }
  }

  Future<void> deleteShoppingListItem(String id) async {
    final result = await _kitchenRepository.deleteKitchenShoppingItem(id);
    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        shoppingListItems.removeWhere((item) => item.id == id);
        showGlobalToast(message: LangKey.parentKitchen.itemRemovedShoppingList);
      },
    );
  }

  Future<void> addCustomShoppingListItem(
    String name, {
    String unit = 'LITER',
    int quantity = 1,
    String? category,
    String? note,
    bool isCustomOrder = true,
    bool addToKitchen = true,
  }) async {
    if (name.trim().isEmpty) return;

    final formattedUnit = unit.toUpperCase();
    final formattedCategory = (category ?? 'DAIRY').toUpperCase();
    final result = await _kitchenRepository.addKitchenShoppingItem(
      name: name.trim(),
      unit: formattedUnit,
      category: formattedCategory,
      quantity: quantity.toString(),
      note: note?.trim().isEmpty ?? true ? null : note?.trim(),
      isCustomOrder: isCustomOrder,
      addToKitchen: addToKitchen,
      ownerStatus: ownerStatus,
    );

    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        fetchKitchenShoppingItems();
        showGlobalToast(message: LangKey.parentKitchen.itemAddedShoppingList);
      },
    );
  }

  static const filterTokens = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Family',
    'Kids',
    'Weaning',
    'Lunchbox',
  ];

  int get filterCount => filterTokens.length;

  String filterLabel(int index) {
    return switch (index) {
      0 => LangKey.parentKitchen.filterAll,
      1 => LangKey.parentKitchen.filterBreakfast,
      2 => LangKey.parentKitchen.filterLunch,
      3 => LangKey.parentKitchen.filterDinner,
      4 => LangKey.parentKitchen.filterSnacks,
      5 => LangKey.parentKitchen.filterFamily,
      6 => LangKey.parentKitchen.filterKids,
      7 => LangKey.parentKitchen.filterWeaning,
      8 => LangKey.parentKitchen.filterLunchbox,
      _ => filterTokens[index],
    };
  }

  static const List<String> childNamesList = [
    'Monica',
    'Eve',
    'Rose',
  ];

  static const Map<int, String> childAgeGroupMap = {
    0: '6-9 months',
    1: '9-12 months',
    2: '12-24 months',
  };

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void reloadOnTabSelected() {
    final ageGroup = childAgeGroupMap[selectedChildIndex.value] ?? '6-9 months';
    fetchRecipeSuggestions(ageGroup);
    fetchAllRecipes();
  }

  Future<void> load() async {
    isLoading.value = true;
    data.value = const KitchenData(
      suggestedRecipes: [],
      allRecipes: [],
      childNames: childNamesList,
    );
    await Future.wait([
      fetchKitchenItems(),
      fetchKitchenShoppingItems(),
      fetchRecipeSuggestions(childAgeGroupMap[0]!),
      fetchAllRecipes(),
    ]);
    isLoading.value = false;
  }

  Future<void> fetchAllRecipes() async {
    isAllRecipesLoading.value = true;
    final result = await _recipeRepository.getAllRecipes();

    result.fold(
      (failure) {
        AppLogger.error('Failed to load all recipes: ${failure.message}');
      },
      (recipes) {
        final currentData = data.value ?? KitchenData.mockData;
        data.value = KitchenData(
          suggestedRecipes: currentData.suggestedRecipes,
          allRecipes: recipes,
          childNames: currentData.childNames,
        );
      },
    );

    isAllRecipesLoading.value = false;
  }

  Future<void> fetchRecipeSuggestions([String? ageGroup]) async {
    isSuggestionsLoading.value = true;
    final group = ageGroup ??
        childAgeGroupMap[selectedChildIndex.value] ??
        '6-9 months';

    final result =
        await _recipeRepository.getRecipeSuggestions(ageGroup: group);

    result.fold(
      (failure) {
        AppLogger.error(
            'Failed to load recipe suggestions: ${failure.message}');
      },
      (recipes) {
        final currentData = data.value ?? KitchenData.mockData;
        data.value = KitchenData(
          suggestedRecipes: recipes,
          allRecipes: currentData.allRecipes,
          childNames: currentData.childNames,
        );
      },
    );

    isSuggestionsLoading.value = false;
  }

  Future<void> fetchKitchenItems([GroceryFilter? filter]) async {
    final activeFilter = filter ?? selectedGroceryFilter.value;
    String? statusParam;
    switch (activeFilter) {
      case GroceryFilter.missing:
        statusParam = 'MISSING';
        break;
      case GroceryFilter.low:
        statusParam = 'LOW';
        break;
      case GroceryFilter.stock:
        statusParam = 'IN_STOCK';
        break;
      case GroceryFilter.all:
        statusParam = null;
        break;
    }

    final result = await _kitchenRepository.getKitchenItems(
      status: statusParam,
      ownerStatus: ownerStatus,
      limit: 20,
    );
    result.fold(
      (failure) {
        AppLogger.error('Failed to load kitchen items: ${failure.message}');
      },
      (items) {
        groceryItems.assignAll(items);
        _populateMissingAndLowGroceries();
      },
    );
  }

  Future<void> fetchKitchenShoppingItems() async {
    isShoppingListLoading.value = true;
    final result = await _kitchenRepository.getKitchenShoppingItems(
      ownerStatus: ownerStatus,
    );
    result.fold(
      (failure) {
        AppLogger.error('Failed to load shopping list: ${failure.message}');
      },
      (items) {
        shoppingListItems.assignAll(items);
      },
    );
    isShoppingListLoading.value = false;
  }

  void _populateMissingAndLowGroceries() {
    if (shoppingListItems.isNotEmpty) return;
    for (final item in groceryItems) {
      final isMissing = item.status == GroceryFilter.missing;
      final isLow = item.status == GroceryFilter.low;
      if (isMissing || isLow) {
        final exists = shoppingListItems.any((s) => s.id == item.id);
        if (!exists) {
          shoppingListItems.add(
            ShoppingListItem(
              id: item.id,
              name: item.name,
              quantityValue: 1,
              unit: item.unit ?? 'Pack',
              note: item.note,
              isMissing: isMissing,
              isLow: isLow,
            ),
          );
        }
      }
    }
    shoppingListItems.refresh();
  }

  void selectTab(KitchenTab tab) => selectedTab.value = tab;

  void selectChild(int index) {
    selectedChildIndex.value = index;
    final ageGroup = childAgeGroupMap[index] ?? '6-9 months';
    fetchRecipeSuggestions(ageGroup);
  }

  void selectFilter(int index) => selectedFilterIndex.value = index;

  void updateSearch(String query) => searchQuery.value = query;

  void toggleFilters() => showFilters.value = !showFilters.value;

  void openNotifications() => notificationCount.value = 0;

  void openMessages() => messageCount.value = 0;

  // ── Grocery Actions ───────────────────────────────────────────────────────
  void selectGroceryFilter(GroceryFilter filter) {
    selectedGroceryFilter.value = filter;
    fetchKitchenItems(filter);
  }

  void toggleGroceriesSection() {
    isGroceriesSectionExpanded.value = !isGroceriesSectionExpanded.value;
  }

  int get allGroceryCount => groceryItems.length;

  int get missingGroceryCount =>
      groceryItems.where((i) => i.status == GroceryFilter.missing).length;

  int get lowGroceryCount =>
      groceryItems.where((i) => i.status == GroceryFilter.low).length;

  int get stockGroceryCount =>
      groceryItems.where((i) => i.status == GroceryFilter.stock).length;

  List<GroceryItem> get filteredGroceryItems {
    final filter = selectedGroceryFilter.value;
    if (filter == GroceryFilter.all) return groceryItems;
    return groceryItems.where((i) => i.status == filter).toList();
  }

  Future<void> updateItemStock(String id, int percent) async {
    final idx = groceryItems.indexWhere((i) => i.id == id);
    if (idx != -1) {
      final item = groceryItems[idx];
      final result = await _kitchenRepository.updateKitchenItem(
        id,
        name: item.name,
        unit: item.unit ?? 'LITER',
        category: item.category ?? 'DAIRY',
        currentStockPercent: percent,
        notes: item.note,
      );

      result.fold(
        (failure) {
          showGlobalToast(message: failure.message, status: 'error');
        },
        (updatedItem) {
          final newItem = updatedItem.copyWith(currentStockPercent: percent);
          groceryItems[idx] = newItem;
          groceryItems.refresh();

          final isMissing = newItem.status == GroceryFilter.missing;
          final isLow = newItem.status == GroceryFilter.low;
          if (isMissing || isLow) {
            final exists = shoppingListItems.any((s) => s.id == newItem.id);
            if (!exists) {
              shoppingListItems.add(
                ShoppingListItem(
                  id: newItem.id,
                  name: newItem.name,
                  quantityValue: 1,
                  unit: newItem.unit ?? 'Pack',
                  note: newItem.note,
                  isMissing: isMissing,
                  isLow: isLow,
                ),
              );
              shoppingListItems.refresh();
            }
          } else {
            shoppingListItems.removeWhere((s) => s.id == newItem.id);
            shoppingListItems.refresh();
          }
        },
      );
    }
  }

  void toggleItemEditing(String id) {
    final idx = groceryItems.indexWhere((i) => i.id == id);
    if (idx != -1) {
      final current = groceryItems[idx];
      groceryItems[idx] = current.copyWith(isEditing: !current.isEditing);
      groceryItems.refresh();
    }
  }

  Future<void> saveItem(String id, String newName, String? newNote) async {
    final idx = groceryItems.indexWhere((i) => i.id == id);
    if (idx != -1) {
      final item = groceryItems[idx];
      final nameToSave = newName.trim().isEmpty ? item.name : newName.trim();
      final noteToSave =
          newNote?.trim().isEmpty ?? true ? item.note : newNote?.trim();

      final result = await _kitchenRepository.updateKitchenItem(
        id,
        name: nameToSave,
        unit: item.unit ?? 'LITER',
        category: item.category ?? 'DAIRY',
        currentStockPercent: item.currentStockPercent,
        notes: noteToSave,
      );

      result.fold(
        (failure) {
          showGlobalToast(message: failure.message, status: 'error');
        },
        (updatedItem) {
          groceryItems[idx] = updatedItem.copyWith(
            name: nameToSave,
            note: noteToSave,
            isEditing: false,
          );
          groceryItems.refresh();
          showGlobalToast(message: LangKey.parentKitchen.itemUpdated);
        },
      );
    }
  }

  Future<void> deleteGroceryItem(String id) async {
    final result = await _kitchenRepository.deleteKitchenItem(id);
    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        groceryItems.removeWhere((i) => i.id == id);
        shoppingListItems.removeWhere((s) => s.id == id);
        showGlobalToast(message: LangKey.parentKitchen.itemDeleted);
      },
    );
  }

  Future<void> addGroceryItem(
    String name,
    int initialStock, {
    String? unit,
    String? category,
    String? note,
  }) async {
    final itemName = name.trim().isEmpty ? 'Organic Whole Milk' : name.trim();

    final formattedUnit = (unit ?? 'LITER').toUpperCase();
    final formattedCategory = (category ?? 'DAIRY').toUpperCase();

    final result = await _kitchenRepository.createKitchenItem(
      name: itemName,
      unit: formattedUnit,
      category: formattedCategory,
      currentStockPercent: initialStock,
      notes: note?.trim().isEmpty ?? true ? null : note?.trim(),
      adminStatus: 'ACTIVE',
    );

    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (newItem) {
        groceryItems.insert(0, newItem);
        groceryItems.refresh();

        final isMissing = newItem.status == GroceryFilter.missing;
        final isLow = newItem.status == GroceryFilter.low;
        if (isMissing || isLow) {
          final shoppingItem = ShoppingListItem(
            id: newItem.id,
            name: newItem.name,
            quantityValue: 1,
            unit: newItem.unit ?? 'Pack',
            note: newItem.note,
            isMissing: isMissing,
            isLow: isLow,
          );
          shoppingListItems.insert(0, shoppingItem);
          shoppingListItems.refresh();
        }

        showGlobalToast(message: LangKey.parentKitchen.itemAddedInventory);
      },
    );
  }

  Future<void> addGroceryItemToShoppingList(GroceryItem item) async {
    final formattedUnit = (item.unit ?? 'LITER').toUpperCase();
    final formattedCategory = (item.category ?? 'DAIRY').toUpperCase();

    final result = await _kitchenRepository.addKitchenShoppingItem(
      name: item.name,
      unit: formattedUnit,
      category: formattedCategory,
      quantity: '2',
      note: item.note ?? 'Full fat only',
      isCustomOrder: true,
      addToKitchen: true,
      ownerStatus: ownerStatus,
    );

    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        final idx = shoppingListItems
            .indexWhere((s) => s.name.toLowerCase() == item.name.toLowerCase());
        if (idx != -1) {
          final existing = shoppingListItems[idx];
          shoppingListItems[idx] = existing.copyWith(
            quantityValue: existing.quantityValue + 1,
          );
          shoppingListItems.refresh();
        } else {
          final shoppingItem = ShoppingListItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: item.name,
            quantityValue: 1,
            unit: item.unit ?? 'Pack',
            note: item.note,
            isMissing: item.status == GroceryFilter.missing,
            isLow: item.status == GroceryFilter.low,
          );
          shoppingListItems.insert(0, shoppingItem);
          shoppingListItems.refresh();
        }
        showGlobalToast(message: '${item.name} added to Shopping List');
      },
    );
  }

  void onViewRecipe(KitchenRecipe recipe) {
    Get.toNamed<void>(AppRoutes.parentRecipeDetails, arguments: recipe);
  }

  void onAddToSchedule(KitchenRecipe recipe) {
    void showSelectChild() {
      showAppSheet<void>(
        child: SelectChildSheet(
          onGoToSchedule: (selectedChild) async {
            final now = DateTime.now();
            final dateStr =
                '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

            final result = await _recipeRepository.addScheduleFromLibrary(
              childId: selectedChild.id,
              date: dateStr,
              libraryItemId: recipe.id,
              libraryItemType: 'recipe',
              startTime: '09:15',
              endTime: '10:00',
              description: 'Recipe schedule: ${recipe.title}',
            );

            result.fold(
              (failure) {
                showGlobalToast(message: failure.message, status: 'error');
              },
              (_) {
                showGlobalToast(message: LangKey.parentKitchen.addedToSchedule);
              },
            );

            Get.toNamed<void>(
              AppRoutes.buildDayFromLibrary,
              arguments: {
                'child_id': selectedChild.id,
                'child_name': selectedChild.name,
              },
            );
          },
        ),
      );
    }

    if (recipe.status == RecipeStatus.needsIngredients) {
      showAppSheet<void>(
        child: MissingIngredientsSheet(
          onScheduleAnyway: showSelectChild,
        ),
      );
    } else {
      showSelectChild();
    }
  }

  bool _matchesFilter(KitchenRecipe recipe, int filterIndex) {
    if (filterIndex == 0) return true;
    final token = filterTokens[filterIndex].toLowerCase();

    final mealLabel = recipe.mealType.label.toLowerCase();
    if (mealLabel == token || mealLabel.contains(token) || token.contains(mealLabel)) {
      return true;
    }

    for (final tag in recipe.tags) {
      final t = tag.toLowerCase();
      if (t == token || t.contains(token) || token.contains(t)) {
        return true;
      }
    }

    final age = recipe.ageSuitability.toLowerCase();
    if (token == 'weaning' && (age.contains('month') || age.contains('m'))) {
      return true;
    }
    if (token == 'kids' && (age.contains('year') || age.contains('y') || age.contains('kids'))) {
      return true;
    }
    if (token == 'family' && (age.contains('family') || age.contains('all') || age.contains('year'))) {
      return true;
    }
    if (token == 'lunchbox' &&
        (recipe.tags.any((t) => t.toLowerCase().contains('finger')) || mealLabel == 'snacks')) {
      return true;
    }

    return false;
  }

  bool _matchesSearch(KitchenRecipe recipe, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;

    if (recipe.title.toLowerCase().contains(q)) return true;
    if (recipe.mealType.label.toLowerCase().contains(q)) return true;
    if (recipe.ageSuitability.toLowerCase().contains(q)) return true;
    if (recipe.tags.any((t) => t.toLowerCase().contains(q))) return true;
    if (recipe.ingredients.any((ing) => ing.name.toLowerCase().contains(q))) return true;

    return false;
  }

  List<KitchenRecipe> get filteredSuggestedRecipes {
    final d = data.value;
    if (d == null) return [];

    return d.suggestedRecipes
        .where((r) =>
            _matchesFilter(r, selectedFilterIndex.value) &&
            _matchesSearch(r, searchQuery.value))
        .toList();
  }

  List<KitchenRecipe> get filteredAllRecipes {
    final d = data.value;
    if (d == null) return [];

    return d.allRecipes
        .where((r) =>
            _matchesFilter(r, selectedFilterIndex.value) &&
            _matchesSearch(r, searchQuery.value))
        .toList();
  }
}
