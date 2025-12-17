// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCategoryCWProxy {
  MerchantMenuCategory id(String id);

  MerchantMenuCategory merchantId(String merchantId);

  MerchantMenuCategory name(String name);

  MerchantMenuCategory description(String? description);

  MerchantMenuCategory sortOrder(int? sortOrder);

  MerchantMenuCategory createdAt(DateTime createdAt);

  MerchantMenuCategory updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategory(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategory call({
    String id,
    String merchantId,
    String name,
    String? description,
    int? sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCategory.copyWith(...)` or call `instanceOfMerchantMenuCategory.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCategoryCWProxyImpl
    implements _$MerchantMenuCategoryCWProxy {
  const _$MerchantMenuCategoryCWProxyImpl(this._value);

  final MerchantMenuCategory _value;

  @override
  MerchantMenuCategory id(String id) => call(id: id);

  @override
  MerchantMenuCategory merchantId(String merchantId) =>
      call(merchantId: merchantId);

  @override
  MerchantMenuCategory name(String name) => call(name: name);

  @override
  MerchantMenuCategory description(String? description) =>
      call(description: description);

  @override
  MerchantMenuCategory sortOrder(int? sortOrder) => call(sortOrder: sortOrder);

  @override
  MerchantMenuCategory createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  MerchantMenuCategory updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategory(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategory call({
    Object? id = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCategory(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $MerchantMenuCategoryCopyWith on MerchantMenuCategory {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCategory.copyWith(...)` or `instanceOfMerchantMenuCategory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCategoryCWProxy get copyWith =>
      _$MerchantMenuCategoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCategory _$MerchantMenuCategoryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuCategory', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'merchantId', 'name', 'createdAt', 'updatedAt'],
  );
  final val = MerchantMenuCategory(
    id: $checkedConvert('id', (v) => v as String),
    merchantId: $checkedConvert('merchantId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num?)?.toInt() ?? 0),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuCategoryToJson(
  MerchantMenuCategory instance,
) => <String, dynamic>{
  'id': instance.id,
  'merchantId': instance.merchantId,
  'name': instance.name,
  'description': ?instance.description,
  'sortOrder': ?instance.sortOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
