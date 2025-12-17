// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCartItemRequestCWProxy {
  UpdateCartItemRequest menuId(String menuId);

  UpdateCartItemRequest delta(int delta);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCartItemRequest call({String menuId, int delta});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateCartItemRequest.copyWith(...)` or call `instanceOfUpdateCartItemRequest.copyWith.fieldName(value)` for a single field.
class _$UpdateCartItemRequestCWProxyImpl
    implements _$UpdateCartItemRequestCWProxy {
  const _$UpdateCartItemRequestCWProxyImpl(this._value);

  final UpdateCartItemRequest _value;

  @override
  UpdateCartItemRequest menuId(String menuId) => call(menuId: menuId);

  @override
  UpdateCartItemRequest delta(int delta) => call(delta: delta);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCartItemRequest call({
    Object? menuId = const $CopyWithPlaceholder(),
    Object? delta = const $CopyWithPlaceholder(),
  }) {
    return UpdateCartItemRequest(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
      delta: delta == const $CopyWithPlaceholder() || delta == null
          ? _value.delta
          // ignore: cast_nullable_to_non_nullable
          : delta as int,
    );
  }
}

extension $UpdateCartItemRequestCopyWith on UpdateCartItemRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateCartItemRequest.copyWith(...)` or `instanceOfUpdateCartItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCartItemRequestCWProxy get copyWith =>
      _$UpdateCartItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCartItemRequest _$UpdateCartItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateCartItemRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['menuId', 'delta']);
  final val = UpdateCartItemRequest(
    menuId: $checkedConvert('menuId', (v) => v as String),
    delta: $checkedConvert('delta', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$UpdateCartItemRequestToJson(
  UpdateCartItemRequest instance,
) => <String, dynamic>{'menuId': instance.menuId, 'delta': instance.delta};
