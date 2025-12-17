// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_category_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCategoryCreateRequestCWProxy {
  MerchantMenuCategoryCreateRequest name(String name);

  MerchantMenuCategoryCreateRequest description(String? description);

  MerchantMenuCategoryCreateRequest sortOrder(int? sortOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryCreateRequest call({
    String name,
    String? description,
    int? sortOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCategoryCreateRequest.copyWith(...)` or call `instanceOfMerchantMenuCategoryCreateRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCategoryCreateRequestCWProxyImpl
    implements _$MerchantMenuCategoryCreateRequestCWProxy {
  const _$MerchantMenuCategoryCreateRequestCWProxyImpl(this._value);

  final MerchantMenuCategoryCreateRequest _value;

  @override
  MerchantMenuCategoryCreateRequest name(String name) => call(name: name);

  @override
  MerchantMenuCategoryCreateRequest description(String? description) =>
      call(description: description);

  @override
  MerchantMenuCategoryCreateRequest sortOrder(int? sortOrder) =>
      call(sortOrder: sortOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryCreateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryCreateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCategoryCreateRequest(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
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

extension $MerchantMenuCategoryCreateRequestCopyWith
    on MerchantMenuCategoryCreateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCategoryCreateRequest.copyWith(...)` or `instanceOfMerchantMenuCategoryCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCategoryCreateRequestCWProxy get copyWith =>
      _$MerchantMenuCategoryCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCategoryCreateRequest _$MerchantMenuCategoryCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuCategoryCreateRequest', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['name']);
  final val = MerchantMenuCategoryCreateRequest(
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num?)?.toInt() ?? 0),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuCategoryCreateRequestToJson(
  MerchantMenuCategoryCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': ?instance.description,
  'sortOrder': ?instance.sortOrder,
};
