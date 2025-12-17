// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_category_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCategoryCreate200ResponseCWProxy {
  MerchantMenuCategoryCreate200Response message(String message);

  MerchantMenuCategoryCreate200Response data(MerchantMenuCategory data);

  MerchantMenuCategoryCreate200Response pagination(
    PaginationResult? pagination,
  );

  MerchantMenuCategoryCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryCreate200Response call({
    String message,
    MerchantMenuCategory data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCategoryCreate200Response.copyWith(...)` or call `instanceOfMerchantMenuCategoryCreate200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCategoryCreate200ResponseCWProxyImpl
    implements _$MerchantMenuCategoryCreate200ResponseCWProxy {
  const _$MerchantMenuCategoryCreate200ResponseCWProxyImpl(this._value);

  final MerchantMenuCategoryCreate200Response _value;

  @override
  MerchantMenuCategoryCreate200Response message(String message) =>
      call(message: message);

  @override
  MerchantMenuCategoryCreate200Response data(MerchantMenuCategory data) =>
      call(data: data);

  @override
  MerchantMenuCategoryCreate200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  MerchantMenuCategoryCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCategoryCreate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MerchantMenuCategory,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $MerchantMenuCategoryCreate200ResponseCopyWith
    on MerchantMenuCategoryCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCategoryCreate200Response.copyWith(...)` or `instanceOfMerchantMenuCategoryCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCategoryCreate200ResponseCWProxy get copyWith =>
      _$MerchantMenuCategoryCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCategoryCreate200Response
_$MerchantMenuCategoryCreate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantMenuCategoryCreate200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantMenuCategoryCreate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => MerchantMenuCategory.fromJson(v as Map<String, dynamic>),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null
              ? null
              : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$MerchantMenuCategoryCreate200ResponseToJson(
  MerchantMenuCategoryCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
