import '../../domain/entities/grocery_item.dart';

class ShoppingListItemModel {
  const ShoppingListItemModel({
    required this.id,
    this.userId,
    this.createdByUserId,
    required this.name,
    this.unit,
    this.quantity,
    this.category,
    this.note,
    this.status,
    this.isCustomOrder,
    this.addedToKitchen,
    this.createdAt,
    this.updatedAt,
    this.ownerStatus,
  });

  final String id;
  final String? userId;
  final String? createdByUserId;
  final String name;
  final String? unit;
  final String? quantity;
  final String? category;
  final String? note;
  final String? status;
  final bool? isCustomOrder;
  final bool? addedToKitchen;
  final String? createdAt;
  final String? updatedAt;
  final String? ownerStatus;

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) {
    return ShoppingListItemModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String?,
      createdByUserId: json['createdByUserId'] as String?,
      name: json['name'] as String? ?? '',
      unit: json['unit'] as String?,
      quantity: json['quantity']?.toString(),
      category: json['category'] as String?,
      note: json['note'] as String?,
      status: json['status'] as String?,
      isCustomOrder: json['isCustomOrder'] as bool?,
      addedToKitchen: json['addedToKitchen'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      ownerStatus: json['ownerStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'createdByUserId': createdByUserId,
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'category': category,
      'note': note,
      'status': status,
      'isCustomOrder': isCustomOrder,
      'addedToKitchen': addedToKitchen,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'ownerStatus': ownerStatus,
    };
  }

  ShoppingListItem toEntity() {
    final rawQty = quantity ?? '1';
    final parsedQty = int.tryParse(rawQty) ?? (double.tryParse(rawQty)?.toInt() ?? 1);
    return ShoppingListItem(
      id: id,
      name: name,
      quantityValue: parsedQty,
      unit: unit ?? 'LITER',
      note: note,
      status: status,
      category: category,
      isCustomOrder: isCustomOrder ?? false,
      addedToKitchen: addedToKitchen ?? false,
    );
  }
}
