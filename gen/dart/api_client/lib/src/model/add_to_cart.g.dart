// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddToCartCWProxy {
  AddToCart menu(MerchantMenu menu);

  AddToCart quantity(int? quantity);

  AddToCart notes(String? notes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCart(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCart(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCart call({MerchantMenu menu, int? quantity, String? notes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAddToCart.copyWith(...)` or call `instanceOfAddToCart.copyWith.fieldName(value)` for a single field.
class _$AddToCartCWProxyImpl implements _$AddToCartCWProxy {
  const _$AddToCartCWProxyImpl(this._value);

  final AddToCart _value;

  @override
  AddToCart menu(MerchantMenu menu) => call(menu: menu);

  @override
  AddToCart quantity(int? quantity) => call(quantity: quantity);

  @override
  AddToCart notes(String? notes) => call(notes: notes);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCart(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCart(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCart call({
    Object? menu = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
  }) {
    return AddToCart(
      menu: menu == const $CopyWithPlaceholder() || menu == null
          ? _value.menu
          // ignore: cast_nullable_to_non_nullable
          : menu as MerchantMenu,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
    );
  }
}

extension $AddToCartCopyWith on AddToCart {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAddToCart.copyWith(...)` or `instanceOfAddToCart.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddToCartCWProxy get copyWith => _$AddToCartCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCart _$AddToCartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AddToCart', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['menu']);
      final val = AddToCart(
        menu: $checkedConvert(
          'menu',
          (v) => MerchantMenu.fromJson(v as Map<String, dynamic>),
        ),
        quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt() ?? 1),
        notes: $checkedConvert('notes', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AddToCartToJson(AddToCart instance) => <String, dynamic>{
  'menu': instance.menu.toJson(),
  'quantity': ?instance.quantity,
  'notes': ?instance.notes,
};
