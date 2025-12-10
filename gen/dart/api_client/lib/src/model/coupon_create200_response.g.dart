// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreate200ResponseCWProxy {
  CouponCreate200Response message(String? message);

  CouponCreate200Response data(Coupon? data);

  CouponCreate200Response pagination(PaginationResult? pagination);

  CouponCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponCreate200Response call({
    String? message,
    Coupon? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponCreate200Response.copyWith(...)` or call `instanceOfCouponCreate200Response.copyWith.fieldName(value)` for a single field.
class _$CouponCreate200ResponseCWProxyImpl
    implements _$CouponCreate200ResponseCWProxy {
  const _$CouponCreate200ResponseCWProxyImpl(this._value);

  final CouponCreate200Response _value;

  @override
  CouponCreate200Response message(String? message) => call(message: message);

  @override
  CouponCreate200Response data(Coupon? data) => call(data: data);

  @override
  CouponCreate200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  CouponCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CouponCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Coupon?,
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

extension $CouponCreate200ResponseCopyWith on CouponCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponCreate200Response.copyWith(...)` or `instanceOfCouponCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreate200ResponseCWProxy get copyWith =>
      _$CouponCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreate200Response _$CouponCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = CouponCreate200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => v == null ? null : Coupon.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$CouponCreate200ResponseToJson(
  CouponCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
