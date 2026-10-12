import '../../domain/entities/grocery_item.dart';

class KitchenItemModel {
  const KitchenItemModel({
    required this.id,
    required this.name,
    this.unit,
    this.quantity,
    this.category,
    this.status,
    required this.currentStockPercent,
    this.expiryDate,
    this.lastStockedAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.adminStatus,
  });

  final String id;
  final String name;
  final String? unit;
  final num? quantity;
  final String? category;
  final String? status;
  final int currentStockPercent;
  final String? expiryDate;
  final String? lastStockedAt;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final String? adminStatus;

  factory KitchenItemModel.fromJson(Map<String, dynamic> json) {
    return KitchenItemModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      unit: json['unit'] as String?,
      quantity: json['quantity'] as num?,
      category: json['category'] as String?,
      status: json['status'] as String?,
      currentStockPercent: (json['currentStockPercent'] as num?)?.toInt() ?? 0,
      expiryDate: json['expiryDate'] as String?,
      lastStockedAt: json['lastStockedAt'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      adminStatus: json['adminStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'category': category,
      'status': status,
      'currentStockPercent': currentStockPercent,
      'expiryDate': expiryDate,
      'lastStockedAt': lastStockedAt,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'adminStatus': adminStatus,
    };
  }

  GroceryItem toEntity() {
    final rawDate = lastStockedAt ?? createdAt;
    String formattedDate = 'Recent';
    if (rawDate != null && rawDate.isNotEmpty) {
      try {
        final dt = DateTime.parse(rawDate).toLocal();
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        final day = dt.day.toString().padLeft(2, '0');
        final month = months[dt.month - 1];
        formattedDate = '$day $month ${dt.year}';
      } catch (_) {
        formattedDate = rawDate;
      }
    }

    int effectivePercent = currentStockPercent;
    if (effectivePercent == 0 && status != null && status!.isNotEmpty) {
      final s = status!.toUpperCase();
      if (s == 'MISSING') {
        effectivePercent = 10;
      } else if (s == 'LOW') {
        effectivePercent = 25;
      } else if (s == 'IN_STOCK') {
        effectivePercent = 80;
      }
    }

    return GroceryItem(
      id: id,
      name: name,
      lastStockDate: formattedDate,
      currentStockPercent: effectivePercent,
      unit: unit,
      category: category,
      note: notes,
    );
  }
}
