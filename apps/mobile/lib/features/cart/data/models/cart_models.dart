/// Cart data models for shopping cart functionality
library;

/// Individual cart item model
class CartItem {
  CartItem({
    required this.menuId,
    required this.merchantId,
    required this.merchantName,
    required this.menuName,
    this.menuImage,
    required this.unitPrice,
    required this.quantity,
    this.notes,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuId: json['menuId'] as String,
      merchantId: json['merchantId'] as String,
      merchantName: json['merchantName'] as String,
      menuName: json['menuName'] as String,
      menuImage: json['menuImage'] as String?,
      unitPrice: json['unitPrice'] as num,
      quantity: json['quantity'] as int,
      notes: json['notes'] as String?,
    );
  }

  final String menuId;
  final String merchantId;
  final String merchantName;
  final String menuName;
  final String? menuImage;
  final num unitPrice;
  final int quantity;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'merchantId': merchantId,
      'merchantName': merchantName,
      'menuName': menuName,
      'menuImage': menuImage,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'notes': notes,
    };
  }

  CartItem copyWith({
    String? menuId,
    String? merchantId,
    String? merchantName,
    String? menuName,
    String? menuImage,
    num? unitPrice,
    int? quantity,
    String? notes,
  }) {
    return CartItem(
      menuId: menuId ?? this.menuId,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      menuName: menuName ?? this.menuName,
      menuImage: menuImage ?? this.menuImage,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}

/// Full cart model
class Cart {
  Cart({
    required this.merchantId,
    required this.merchantName,
    required this.items,
    required this.totalItems,
    required this.subtotal,
    required this.lastUpdated,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      merchantId: json['merchantId'] as String,
      merchantName: json['merchantName'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalItems: json['totalItems'] as int,
      subtotal: json['subtotal'] as num,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  final String merchantId;
  final String merchantName;
  final List<CartItem> items;
  final int totalItems;
  final num subtotal;
  final DateTime lastUpdated;

  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'items': items.map((e) => e.toJson()).toList(),
      'totalItems': totalItems,
      'subtotal': subtotal,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
