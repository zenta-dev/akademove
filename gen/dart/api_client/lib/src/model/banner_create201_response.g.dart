// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_create201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerCreate201ResponseCWProxy {
  BannerCreate201Response message(String message);

  BannerCreate201Response data(BannerCreate201ResponseData data);

  BannerCreate201Response pagination(PaginationResult? pagination);

  BannerCreate201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerCreate201Response call({
    String message,
    BannerCreate201ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerCreate201Response.copyWith(...)` or call `instanceOfBannerCreate201Response.copyWith.fieldName(value)` for a single field.
class _$BannerCreate201ResponseCWProxyImpl
    implements _$BannerCreate201ResponseCWProxy {
  const _$BannerCreate201ResponseCWProxyImpl(this._value);

  final BannerCreate201Response _value;

  @override
  BannerCreate201Response message(String message) => call(message: message);

  @override
  BannerCreate201Response data(BannerCreate201ResponseData data) =>
      call(data: data);

  @override
  BannerCreate201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BannerCreate201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerCreate201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BannerCreate201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BannerCreate201ResponseData,
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

extension $BannerCreate201ResponseCopyWith on BannerCreate201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerCreate201Response.copyWith(...)` or `instanceOfBannerCreate201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerCreate201ResponseCWProxy get copyWith =>
      _$BannerCreate201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerCreate201Response _$BannerCreate201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BannerCreate201Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BannerCreate201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BannerCreate201ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BannerCreate201ResponseToJson(
  BannerCreate201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
