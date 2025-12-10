// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_list_public200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerListPublic200ResponseCWProxy {
  BannerListPublic200Response message(String message);

  BannerListPublic200Response data(
    List<BannerListPublic200ResponseDataInner> data,
  );

  BannerListPublic200Response pagination(PaginationResult? pagination);

  BannerListPublic200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerListPublic200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerListPublic200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerListPublic200Response call({
    String message,
    List<BannerListPublic200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerListPublic200Response.copyWith(...)` or call `instanceOfBannerListPublic200Response.copyWith.fieldName(value)` for a single field.
class _$BannerListPublic200ResponseCWProxyImpl
    implements _$BannerListPublic200ResponseCWProxy {
  const _$BannerListPublic200ResponseCWProxyImpl(this._value);

  final BannerListPublic200Response _value;

  @override
  BannerListPublic200Response message(String message) => call(message: message);

  @override
  BannerListPublic200Response data(
    List<BannerListPublic200ResponseDataInner> data,
  ) => call(data: data);

  @override
  BannerListPublic200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BannerListPublic200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerListPublic200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerListPublic200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerListPublic200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BannerListPublic200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<BannerListPublic200ResponseDataInner>,
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

extension $BannerListPublic200ResponseCopyWith on BannerListPublic200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerListPublic200Response.copyWith(...)` or `instanceOfBannerListPublic200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerListPublic200ResponseCWProxy get copyWith =>
      _$BannerListPublic200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerListPublic200Response _$BannerListPublic200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BannerListPublic200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BannerListPublic200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) => BannerListPublic200ResponseDataInner.fromJson(
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

Map<String, dynamic> _$BannerListPublic200ResponseToJson(
  BannerListPublic200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
