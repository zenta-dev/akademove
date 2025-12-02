// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_validate200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponValidate200ResponseCWProxy {
  CouponValidate200Response message(String message);

  CouponValidate200Response data(CouponValidate200ResponseData data);

  CouponValidate200Response pagination(PaginationResult? pagination);

  CouponValidate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidate200Response call({
    String message,
    CouponValidate200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponValidate200Response.copyWith(...)` or call `instanceOfCouponValidate200Response.copyWith.fieldName(value)` for a single field.
class _$CouponValidate200ResponseCWProxyImpl implements _$CouponValidate200ResponseCWProxy {
  const _$CouponValidate200ResponseCWProxyImpl(this._value);

  final CouponValidate200Response _value;

  @override
  CouponValidate200Response message(String message) => call(message: message);

  @override
  CouponValidate200Response data(CouponValidate200ResponseData data) => call(data: data);

  @override
  CouponValidate200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  CouponValidate200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CouponValidate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as CouponValidate200ResponseData,
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

extension $CouponValidate200ResponseCopyWith on CouponValidate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponValidate200Response.copyWith(...)` or `instanceOfCouponValidate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponValidate200ResponseCWProxy get copyWith => _$CouponValidate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponValidate200Response _$CouponValidate200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponValidate200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = CouponValidate200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => CouponValidate200ResponseData.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$CouponValidate200ResponseToJson(CouponValidate200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
