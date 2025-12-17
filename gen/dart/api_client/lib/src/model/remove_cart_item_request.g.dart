// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_cart_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RemoveCartItemRequestCWProxy {
  RemoveCartItemRequest menuId(String menuId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RemoveCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RemoveCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  RemoveCartItemRequest call({String menuId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRemoveCartItemRequest.copyWith(...)` or call `instanceOfRemoveCartItemRequest.copyWith.fieldName(value)` for a single field.
class _$RemoveCartItemRequestCWProxyImpl
    implements _$RemoveCartItemRequestCWProxy {
  const _$RemoveCartItemRequestCWProxyImpl(this._value);

  final RemoveCartItemRequest _value;

  @override
  RemoveCartItemRequest menuId(String menuId) => call(menuId: menuId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RemoveCartItemRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RemoveCartItemRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  RemoveCartItemRequest call({Object? menuId = const $CopyWithPlaceholder()}) {
    return RemoveCartItemRequest(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
    );
  }
}

extension $RemoveCartItemRequestCopyWith on RemoveCartItemRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRemoveCartItemRequest.copyWith(...)` or `instanceOfRemoveCartItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RemoveCartItemRequestCWProxy get copyWith =>
      _$RemoveCartItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveCartItemRequest _$RemoveCartItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RemoveCartItemRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['menuId']);
  final val = RemoveCartItemRequest(
    menuId: $checkedConvert('menuId', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$RemoveCartItemRequestToJson(
  RemoveCartItemRequest instance,
) => <String, dynamic>{'menuId': instance.menuId};
