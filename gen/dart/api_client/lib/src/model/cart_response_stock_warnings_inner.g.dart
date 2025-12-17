// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_stock_warnings_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartResponseStockWarningsInnerCWProxy {
  CartResponseStockWarningsInner menuId(String menuId);

  CartResponseStockWarningsInner menuName(String menuName);

  CartResponseStockWarningsInner requestedQuantity(num requestedQuantity);

  CartResponseStockWarningsInner availableStock(num availableStock);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartResponseStockWarningsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartResponseStockWarningsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  CartResponseStockWarningsInner call({
    String menuId,
    String menuName,
    num requestedQuantity,
    num availableStock,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCartResponseStockWarningsInner.copyWith(...)` or call `instanceOfCartResponseStockWarningsInner.copyWith.fieldName(value)` for a single field.
class _$CartResponseStockWarningsInnerCWProxyImpl
    implements _$CartResponseStockWarningsInnerCWProxy {
  const _$CartResponseStockWarningsInnerCWProxyImpl(this._value);

  final CartResponseStockWarningsInner _value;

  @override
  CartResponseStockWarningsInner menuId(String menuId) => call(menuId: menuId);

  @override
  CartResponseStockWarningsInner menuName(String menuName) =>
      call(menuName: menuName);

  @override
  CartResponseStockWarningsInner requestedQuantity(num requestedQuantity) =>
      call(requestedQuantity: requestedQuantity);

  @override
  CartResponseStockWarningsInner availableStock(num availableStock) =>
      call(availableStock: availableStock);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartResponseStockWarningsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartResponseStockWarningsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  CartResponseStockWarningsInner call({
    Object? menuId = const $CopyWithPlaceholder(),
    Object? menuName = const $CopyWithPlaceholder(),
    Object? requestedQuantity = const $CopyWithPlaceholder(),
    Object? availableStock = const $CopyWithPlaceholder(),
  }) {
    return CartResponseStockWarningsInner(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
      menuName: menuName == const $CopyWithPlaceholder() || menuName == null
          ? _value.menuName
          // ignore: cast_nullable_to_non_nullable
          : menuName as String,
      requestedQuantity:
          requestedQuantity == const $CopyWithPlaceholder() ||
              requestedQuantity == null
          ? _value.requestedQuantity
          // ignore: cast_nullable_to_non_nullable
          : requestedQuantity as num,
      availableStock:
          availableStock == const $CopyWithPlaceholder() ||
              availableStock == null
          ? _value.availableStock
          // ignore: cast_nullable_to_non_nullable
          : availableStock as num,
    );
  }
}

extension $CartResponseStockWarningsInnerCopyWith
    on CartResponseStockWarningsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCartResponseStockWarningsInner.copyWith(...)` or `instanceOfCartResponseStockWarningsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartResponseStockWarningsInnerCWProxy get copyWith =>
      _$CartResponseStockWarningsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseStockWarningsInner _$CartResponseStockWarningsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CartResponseStockWarningsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'menuId',
      'menuName',
      'requestedQuantity',
      'availableStock',
    ],
  );
  final val = CartResponseStockWarningsInner(
    menuId: $checkedConvert('menuId', (v) => v as String),
    menuName: $checkedConvert('menuName', (v) => v as String),
    requestedQuantity: $checkedConvert('requestedQuantity', (v) => v as num),
    availableStock: $checkedConvert('availableStock', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$CartResponseStockWarningsInnerToJson(
  CartResponseStockWarningsInner instance,
) => <String, dynamic>{
  'menuId': instance.menuId,
  'menuName': instance.menuName,
  'requestedQuantity': instance.requestedQuantity,
  'availableStock': instance.availableStock,
};
