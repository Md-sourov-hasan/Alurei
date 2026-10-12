import 'package:alurei/src/imports/imports.dart';

enum GroceryFilter {
  all,
  missing,
  low,
  stock;

  String get label => switch (this) {
        GroceryFilter.all => 'All',
        GroceryFilter.missing => 'Missing',
        GroceryFilter.low => 'Low',
        GroceryFilter.stock => 'Stock',
      };
}

class GroceryItem extends Equatable {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.lastStockDate,
    required this.currentStockPercent,
    this.unit,
    this.category,
    this.note,
    this.isEditing = false,
  });

  final String id;
  final String name;
  final String lastStockDate;
  final int currentStockPercent;
  final String? unit;
  final String? category;
  final String? note;
  final bool isEditing;

  GroceryFilter get status {
    if (currentStockPercent <= 10) return GroceryFilter.missing;
    if (currentStockPercent <= 30) return GroceryFilter.low;
    return GroceryFilter.stock;
  }

  GroceryItem copyWith({
    String? id,
    String? name,
    String? lastStockDate,
    int? currentStockPercent,
    String? unit,
    String? category,
    String? note,
    bool? isEditing,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      lastStockDate: lastStockDate ?? this.lastStockDate,
      currentStockPercent: currentStockPercent ?? this.currentStockPercent,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      note: note ?? this.note,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        lastStockDate,
        currentStockPercent,
        unit,
        category,
        note,
        isEditing,
      ];
}

class ShoppingListItem extends Equatable {
  const ShoppingListItem({
    required this.id,
    required this.name,
    required this.quantityValue,
    required this.unit,
    this.note,
    this.isEditing = false,
    this.isMissing = false,
    this.isLow = false,
    this.status,
    this.category,
    this.isCustomOrder,
    this.addedToKitchen,
  });

  final String id;
  final String name;
  final int quantityValue;
  final String unit;
  final String? note;
  final bool isEditing;
  final bool isMissing;
  final bool isLow;
  final String? status;
  final String? category;
  final bool? isCustomOrder;
  final bool? addedToKitchen;

  String get quantityDisplay => '$quantityValue $unit';

  ShoppingListItem copyWith({
    String? id,
    String? name,
    int? quantityValue,
    String? unit,
    String? note,
    bool? isEditing,
    bool? isMissing,
    bool? isLow,
    String? status,
    String? category,
    bool? isCustomOrder,
    bool? addedToKitchen,
  }) {
    return ShoppingListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantityValue: quantityValue ?? this.quantityValue,
      unit: unit ?? this.unit,
      note: note ?? this.note,
      isEditing: isEditing ?? this.isEditing,
      isMissing: isMissing ?? this.isMissing,
      isLow: isLow ?? this.isLow,
      status: status ?? this.status,
      category: category ?? this.category,
      isCustomOrder: isCustomOrder ?? this.isCustomOrder,
      addedToKitchen: addedToKitchen ?? this.addedToKitchen,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        quantityValue,
        unit,
        note,
        isEditing,
        isMissing,
        isLow,
        status,
        category,
        isCustomOrder,
        addedToKitchen,
      ];
}
