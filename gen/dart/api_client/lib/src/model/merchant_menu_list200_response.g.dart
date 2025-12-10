// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuList200ResponseCWProxy {
  MerchantMenuList200Response message(String? message);

  MerchantMenuList200Response data(List<MerchantMenu> data);

  MerchantMenuList200Response pagination(PaginationResult? pagination);

  MerchantMenuList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuList200Response call({
    String? message,
    List<MerchantMenu> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantMenuList200Response.copyWith(...)` or call `instanceOfMerchantMenuList200Response.copyWith.fieldName(value)` for a single field.
class _$MerchantMenuList200ResponseCWProxyImpl
    implements _$MerchantMenuList200ResponseCWProxy {
  const _$MerchantMenuList200ResponseCWProxyImpl(this._value);

  final MerchantMenuList200Response _value;

  @override
  MerchantMenuList200Response message(String? message) =>
      call(message: message);

  @override
  MerchantMenuList200Response data(List<MerchantMenu> data) => call(data: data);

  @override
  MerchantMenuList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  MerchantMenuList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantMenuList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantMenuList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantMenuList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenuList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MerchantMenu>,
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

extension $MerchantMenuList200ResponseCopyWith on MerchantMenuList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantMenuList200Response.copyWith(...)` or `instanceOfMerchantMenuList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuList200ResponseCWProxy get copyWith =>
      _$MerchantMenuList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenuList200Response _$MerchantMenuList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenuList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = MerchantMenuList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => MerchantMenu.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$MerchantMenuList200ResponseToJson(
  MerchantMenuList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
