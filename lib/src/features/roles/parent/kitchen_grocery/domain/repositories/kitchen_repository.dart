import 'package:alurei/src/imports/core_imports.dart';
import '../entities/grocery_item.dart';

abstract class KitchenRepository {
  FutureEither<List<GroceryItem>> getKitchenItems({
    String? status,
    String ownerStatus = 'PARENT',
    int limit = 20,
  });

  FutureEither<GroceryItem> createKitchenItem({
    required String name,
    required String unit,
    required String category,
    required int currentStockPercent,
    String? notes,
    String? adminStatus,
    String? userId,
  });

  FutureEither<GroceryItem> updateKitchenItem(
    String id, {
    String? name,
    String? unit,
    String? category,
    int? currentStockPercent,
    String? notes,
  });

  FutureEither<void> deleteKitchenItem(String id);

  FutureEither<List<ShoppingListItem>> getKitchenShoppingItems({
    String ownerStatus = 'PARENT',
  });

  FutureEither<Map<String, dynamic>> addKitchenShoppingItem({
    required String name,
    required String unit,
    required String category,
    String quantity = '1',
    String? note,
    bool isCustomOrder = true,
    bool addToKitchen = true,
    String ownerStatus = 'PARENT',
  });

  FutureEither<void> deleteKitchenShoppingItem(String id);
}
