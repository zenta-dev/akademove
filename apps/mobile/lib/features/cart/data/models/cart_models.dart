import 'package:api_client/api_client.dart';

// Re-export generated Cart and CartItem models
export 'package:api_client/api_client.dart' show Cart, CartItem;

/// Extension on [Cart] to add computed properties for UI logic
extension CartExtension on Cart {
  /// Check if this cart is for a printing merchant (requires attachment)
  bool get isPrintingMerchant => merchantCategory == MerchantCategory.printing;
}

/// Extension on [CartItem] to add stock-related computed properties
extension CartItemExtension on CartItem {
  /// Returns the effective stock, defaulting to a high value if null
  int get effectiveStock => stock ?? 999;

  /// Returns true if this item is out of stock (stock <= 0)
  bool get isOutOfStock => effectiveStock <= 0;

  /// Returns true if incrementing quantity would exceed available stock
  bool get isAtMaxStock => quantity >= effectiveStock;

  /// Returns the remaining stock that can be added
  int get remainingStock =>
      (effectiveStock - quantity).clamp(0, effectiveStock);

  /// Returns the subtotal for this item (unitPrice * quantity)
  num get subtotal => unitPrice * quantity;
}
