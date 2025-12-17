// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartResponseCWProxy {
  CartResponse cart(Cart? cart);

  CartResponse stockWarnings(
    List<CartResponseStockWarningsInner>? stockWarnings,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  CartResponse call({
    Cart? cart,
    List<CartResponseStockWarningsInner>? stockWarnings,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCartResponse.copyWith(...)` or call `instanceOfCartResponse.copyWith.fieldName(value)` for a single field.
class _$CartResponseCWProxyImpl implements _$CartResponseCWProxy {
  const _$CartResponseCWProxyImpl(this._value);

  final CartResponse _value;

  @override
  CartResponse cart(Cart? cart) => call(cart: cart);

  @override
  CartResponse stockWarnings(
    List<CartResponseStockWarningsInner>? stockWarnings,
  ) => call(stockWarnings: stockWarnings);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  CartResponse call({
    Object? cart = const $CopyWithPlaceholder(),
    Object? stockWarnings = const $CopyWithPlaceholder(),
  }) {
    return CartResponse(
      cart: cart == const $CopyWithPlaceholder()
          ? _value.cart
          // ignore: cast_nullable_to_non_nullable
          : cart as Cart?,
      stockWarnings: stockWarnings == const $CopyWithPlaceholder()
          ? _value.stockWarnings
          // ignore: cast_nullable_to_non_nullable
          : stockWarnings as List<CartResponseStockWarningsInner>?,
    );
  }
}

extension $CartResponseCopyWith on CartResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCartResponse.copyWith(...)` or `instanceOfCartResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartResponseCWProxy get copyWith => _$CartResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CartResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['cart']);
      final val = CartResponse(
        cart: $checkedConvert(
          'cart',
          (v) => v == null ? null : Cart.fromJson(v as Map<String, dynamic>),
        ),
        stockWarnings: $checkedConvert(
          'stockWarnings',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => CartResponseStockWarningsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'cart': instance.cart?.toJson(),
      'stockWarnings': ?instance.stockWarnings?.map((e) => e.toJson()).toList(),
    };
