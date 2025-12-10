// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerList200ResponseCWProxy {
  BannerList200Response message(String message);

  BannerList200Response data(List<BannerList200ResponseDataInner> data);

  BannerList200Response pagination(PaginationResult? pagination);

  BannerList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerList200Response call({
    String message,
    List<BannerList200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerList200Response.copyWith(...)` or call `instanceOfBannerList200Response.copyWith.fieldName(value)` for a single field.
class _$BannerList200ResponseCWProxyImpl
    implements _$BannerList200ResponseCWProxy {
  const _$BannerList200ResponseCWProxyImpl(this._value);

  final BannerList200Response _value;

  @override
  BannerList200Response message(String message) => call(message: message);

  @override
  BannerList200Response data(List<BannerList200ResponseDataInner> data) =>
      call(data: data);

  @override
  BannerList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BannerList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BannerList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<BannerList200ResponseDataInner>,
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

extension $BannerList200ResponseCopyWith on BannerList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerList200Response.copyWith(...)` or `instanceOfBannerList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerList200ResponseCWProxy get copyWith =>
      _$BannerList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerList200Response _$BannerList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BannerList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BannerList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) => BannerList200ResponseDataInner.fromJson(
              e as Map<String, dynamic>,
            ),
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

Map<String, dynamic> _$BannerList200ResponseToJson(
  BannerList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
