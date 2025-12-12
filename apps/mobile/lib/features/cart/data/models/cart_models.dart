import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

/// Local cart model for storing shopping cart data
class Cart extends Equatable {
  const Cart({
    required this.merchantId,
    required this.merchantName,
    required this.items,
    required this.totalItems,
    required this.subtotal,
    required this.lastUpdated,
    this.merchantLocation,
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
      merchantLocation: json['merchantLocation'] != null
          ? Coordinate.fromJson(
              json['merchantLocation'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  final String merchantId;
  final String merchantName;
  final List<CartItem> items;
  final int totalItems;
  final num subtotal;
  final DateTime lastUpdated;
  final Coordinate? merchantLocation;

  Map<String, dynamic> toJson() => {
    'merchantId': merchantId,
    'merchantName': merchantName,
    'items': items.map((e) => e.toJson()).toList(),
    'totalItems': totalItems,
    'subtotal': subtotal,
    'lastUpdated': lastUpdated.toIso8601String(),
    if (merchantLocation != null)
      'merchantLocation': merchantLocation!.toJson(),
  };

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

  @override
  List<Object?> get props => [
    merchantId,
    merchantName,
    items,
    totalItems,
    subtotal,
    lastUpdated,
    merchantLocation,
  ];
}

/// Cart item model
class CartItem extends Equatable {
  const CartItem({
    required this.menuId,
    required this.merchantId,
    required this.merchantName,
    required this.menuName,
    required this.unitPrice,
    required this.quantity,
    this.menuImage,
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

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'merchantId': merchantId,
    'merchantName': merchantName,
    'menuName': menuName,
    if (menuImage != null) 'menuImage': menuImage,
    'unitPrice': unitPrice,
    'quantity': quantity,
    if (notes != null) 'notes': notes,
  };

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

  @override
  List<Object?> get props => [
    menuId,
    merchantId,
    merchantName,
    menuName,
    menuImage,
    unitPrice,
    quantity,
    notes,
  ];
}
