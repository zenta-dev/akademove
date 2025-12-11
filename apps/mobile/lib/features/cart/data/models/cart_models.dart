/// Cart data models for shopping cart functionality
library;

import 'package:api_client/api_client.dart' show Coordinate;

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
    this.merchantLocation,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    Coordinate? location;
    if (json['merchantLocation'] != null) {
      final locJson = json['merchantLocation'] as Map<String, dynamic>;
      location = Coordinate(
        x: (locJson['x'] as num).toDouble(),
        y: (locJson['y'] as num).toDouble(),
      );
    }

    return Cart(
      merchantId: json['merchantId'] as String,
      merchantName: json['merchantName'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalItems: json['totalItems'] as int,
      subtotal: json['subtotal'] as num,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      merchantLocation: location,
    );
  }

  final String merchantId;
  final String merchantName;
  final List<CartItem> items;
  final int totalItems;
  final num subtotal;
  final DateTime lastUpdated;

  /// Merchant's location for pickup (FOOD orders)
  final Coordinate? merchantLocation;

  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'items': items.map((e) => e.toJson()).toList(),
      'totalItems': totalItems,
      'subtotal': subtotal,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (merchantLocation != null)
        'merchantLocation': {
          'x': merchantLocation!.x,
          'y': merchantLocation!.y,
        },
    };
  }

  Cart copyWith({
    String? merchantId,
    String? merchantName,
    List<CartItem>? items,
    int? totalItems,
    num? subtotal,
    DateTime? lastUpdated,
    Coordinate? merchantLocation,
  }) {
    return Cart(
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      subtotal: subtotal ?? this.subtotal,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      merchantLocation: merchantLocation ?? this.merchantLocation,
    );
  }
}
