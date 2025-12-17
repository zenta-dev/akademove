// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_category_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCategoryList200ResponseCWProxy {
  MerchantMenuCategoryList200Response message(String message);

  MerchantMenuCategoryList200Response data(List<MerchantMenuCategory> data);

  MerchantMenuCategoryList200Response pagination(PaginationResult? pagination);

  MerchantMenuCategoryList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryList200Response call({
    String message,
    List<MerchantMenuCategory> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuCategoryList200Response.copyWith(...)` or call `instanceOfMerchantMenuCategoryList200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuCategoryList200ResponseCWProxyImpl
    implements _$MerchantMenuCategoryList200ResponseCWProxy {
  const _$MerchantMenuCategoryList200ResponseCWProxyImpl(this._value);

  final MerchantMenuCategoryList200Response _value;

  @override
  MerchantMenuCategoryList200Response message(String message) =>
      call(message: message);

  @override
  MerchantMenuCategoryList200Response data(List<MerchantMenuCategory> data) =>
      call(data: data);

  @override
  MerchantMenuCategoryList200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  MerchantMenuCategoryList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuCategoryList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuCategoryList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuCategoryList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuCategoryList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MerchantMenuCategory>,
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

extension $MerchantMenuCategoryList200ResponseCopyWith
    on MerchantMenuCategoryList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuCategoryList200Response.copyWith(...)` or `instanceOfMerchantMenuCategoryList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCategoryList200ResponseCWProxy get copyWith =>
      _$MerchantMenuCategoryList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuCategoryList200Response
_$MerchantMenuCategoryList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantMenuCategoryList200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = MerchantMenuCategoryList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>)
              .map(
                (e) => MerchantMenuCategory.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
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

Map<String, dynamic> _$MerchantMenuCategoryList200ResponseToJson(
  MerchantMenuCategoryList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
