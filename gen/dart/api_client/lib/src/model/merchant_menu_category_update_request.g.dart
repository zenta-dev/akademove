// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_category_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCategoryUpdateRequestCWProxy {
  MerchantMenuCategoryUpdateRequest name(String? name);

  MerchantMenuCategoryUpdateRequest description(String? description);

  MerchantMenuCategoryUpdateRequest sortOrder(int? sortOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryUpdateRequest call({
    String? name,
    String? description,
    int? sortOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCategoryUpdateRequest.copyWith(...)` or call `instanceOfMerchantMenuCategoryUpdateRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCategoryUpdateRequestCWProxyImpl
    implements _$MerchantMenuCategoryUpdateRequestCWProxy {
  const _$MerchantMenuCategoryUpdateRequestCWProxyImpl(this._value);

  final MerchantMenuCategoryUpdateRequest _value;

  @override
  MerchantMenuCategoryUpdateRequest name(String? name) => call(name: name);

  @override
  MerchantMenuCategoryUpdateRequest description(String? description) =>
      call(description: description);

  @override
  MerchantMenuCategoryUpdateRequest sortOrder(int? sortOrder) =>
      call(sortOrder: sortOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryUpdateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryUpdateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCategoryUpdateRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int?,
    );
  }
}

extension $MerchantMenuCategoryUpdateRequestCopyWith
    on MerchantMenuCategoryUpdateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCategoryUpdateRequest.copyWith(...)` or `instanceOfMerchantMenuCategoryUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCategoryUpdateRequestCWProxy get copyWith =>
      _$MerchantMenuCategoryUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCategoryUpdateRequest _$MerchantMenuCategoryUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuCategoryUpdateRequest', json, (
  $checkedConvert,
) {
  final val = MerchantMenuCategoryUpdateRequest(
    name: $checkedConvert('name', (v) => v as String?),
    description: $checkedConvert('description', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num?)?.toInt() ?? 0),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuCategoryUpdateRequestToJson(
  MerchantMenuCategoryUpdateRequest instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'description': ?instance.description,
  'sortOrder': ?instance.sortOrder,
};
