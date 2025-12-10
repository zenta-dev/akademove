// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_delete200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerDelete200ResponseCWProxy {
  BannerDelete200Response message(String message);

  BannerDelete200Response data(BannerDelete200ResponseData data);

  BannerDelete200Response pagination(PaginationResult? pagination);

  BannerDelete200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerDelete200Response call({
    String message,
    BannerDelete200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerDelete200Response.copyWith(...)` or call `instanceOfBannerDelete200Response.copyWith.fieldName(value)` for a single field.
class _$BannerDelete200ResponseCWProxyImpl
    implements _$BannerDelete200ResponseCWProxy {
  const _$BannerDelete200ResponseCWProxyImpl(this._value);

  final BannerDelete200Response _value;

  @override
  BannerDelete200Response message(String message) => call(message: message);

  @override
  BannerDelete200Response data(BannerDelete200ResponseData data) =>
      call(data: data);

  @override
  BannerDelete200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BannerDelete200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerDelete200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BannerDelete200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BannerDelete200ResponseData,
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

extension $BannerDelete200ResponseCopyWith on BannerDelete200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerDelete200Response.copyWith(...)` or `instanceOfBannerDelete200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerDelete200ResponseCWProxy get copyWith =>
      _$BannerDelete200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerDelete200Response _$BannerDelete200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BannerDelete200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BannerDelete200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BannerDelete200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BannerDelete200ResponseToJson(
  BannerDelete200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
