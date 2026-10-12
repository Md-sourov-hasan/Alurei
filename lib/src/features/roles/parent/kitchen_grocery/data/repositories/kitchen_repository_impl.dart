import 'package:alurei/src/imports/core_imports.dart';
import '../../../../../../services/kitchen_service.dart';
import '../../domain/entities/grocery_item.dart';
import '../../domain/repositories/kitchen_repository.dart';
import '../models/kitchen_item_model.dart';
import '../models/shopping_list_item_model.dart';

class KitchenRepositoryImpl implements KitchenRepository {
  final KitchenService _kitchenService = KitchenService.instance;

  @override
  FutureEither<List<GroceryItem>> getKitchenItems({
    String? status,
    String ownerStatus = 'PARENT',
    int limit = 20,
  }) async {
    final result = await _kitchenService.getKitchenItems(
      status: status,
      ownerStatus: ownerStatus,
      limit: limit,
    );
    return result.map(
      (list) => list
          .map((json) => KitchenItemModel.fromJson(json).toEntity())
          .toList(),
    );
  }

  @override
  FutureEither<GroceryItem> createKitchenItem({
    required String name,
    required String unit,
    required String category,
    required int currentStockPercent,
    String? notes,
    String? adminStatus,
    String? userId,
  }) async {
    final result = await _kitchenService.createKitchenItem(
      name: name,
      unit: unit,
      category: category,
      currentStockPercent: currentStockPercent,
      notes: notes,
      adminStatus: adminStatus,
      userId: userId,
    );

    return result.map(
      (json) => KitchenItemModel.fromJson(json).toEntity(),
    );
  }

  @override
  FutureEither<GroceryItem> updateKitchenItem(
    String id, {
    String? name,
    String? unit,
    String? category,
    int? currentStockPercent,
    String? notes,
  }) async {
    final updatePayload = <String, dynamic>{
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (category != null) 'category': category,
      if (currentStockPercent != null)
        'currentStockPercent': currentStockPercent,
      if (notes != null) 'notes': notes,
    };

    final result = await _kitchenService.updateKitchenItem(id, updatePayload);
    return result.map(
      (json) => KitchenItemModel.fromJson(json).toEntity(),
    );
  }

  @override
  FutureEither<void> deleteKitchenItem(String id) async {
    return _kitchenService.deleteKitchenItem(id);
  }

  @override
  FutureEither<List<ShoppingListItem>> getKitchenShoppingItems({
    String ownerStatus = 'PARENT',
  }) async {
    final result = await _kitchenService.getKitchenShoppingItems(
      ownerStatus: ownerStatus,
    );
    return result.map(
      (list) => list
          .map((json) => ShoppingListItemModel.fromJson(json).toEntity())
          .toList(),
    );
  }

  @override
  FutureEither<Map<String, dynamic>> addKitchenShoppingItem({
    required String name,
    required String unit,
    required String category,
    String quantity = '1',
    String? note,
    bool isCustomOrder = true,
    bool addToKitchen = true,
    String ownerStatus = 'PARENT',
  }) async {
    return _kitchenService.addKitchenShoppingItem(
      name: name,
      unit: unit,
      category: category,
      quantity: quantity,
      note: note,
      isCustomOrder: isCustomOrder,
      addToKitchen: addToKitchen,
      ownerStatus: ownerStatus,
    );
  }

  @override
  FutureEither<void> deleteKitchenShoppingItem(String id) async {
    return _kitchenService.deleteKitchenShoppingItem(id);
  }
}
