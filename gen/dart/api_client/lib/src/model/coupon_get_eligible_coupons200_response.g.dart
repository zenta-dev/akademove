// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_get_eligible_coupons200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponGetEligibleCoupons200ResponseCWProxy {
  CouponGetEligibleCoupons200Response message(String? message);

  CouponGetEligibleCoupons200Response data(
    CouponGetEligibleCoupons200ResponseData data,
  );

  CouponGetEligibleCoupons200Response pagination(PaginationResult? pagination);

  CouponGetEligibleCoupons200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCoupons200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCoupons200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCoupons200Response call({
    String? message,
    CouponGetEligibleCoupons200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponGetEligibleCoupons200Response.copyWith(...)` or call `instanceOfCouponGetEligibleCoupons200Response.copyWith.fieldName(value)` for a single field.
class _$CouponGetEligibleCoupons200ResponseCWProxyImpl
    implements _$CouponGetEligibleCoupons200ResponseCWProxy {
  const _$CouponGetEligibleCoupons200ResponseCWProxyImpl(this._value);

  final CouponGetEligibleCoupons200Response _value;

  @override
  CouponGetEligibleCoupons200Response message(String? message) =>
      call(message: message);

  @override
  CouponGetEligibleCoupons200Response data(
    CouponGetEligibleCoupons200ResponseData data,
  ) => call(data: data);

  @override
  CouponGetEligibleCoupons200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  CouponGetEligibleCoupons200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCoupons200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCoupons200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCoupons200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CouponGetEligibleCoupons200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as CouponGetEligibleCoupons200ResponseData,
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

extension $CouponGetEligibleCoupons200ResponseCopyWith
    on CouponGetEligibleCoupons200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponGetEligibleCoupons200Response.copyWith(...)` or `instanceOfCouponGetEligibleCoupons200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponGetEligibleCoupons200ResponseCWProxy get copyWith =>
      _$CouponGetEligibleCoupons200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponGetEligibleCoupons200Response
_$CouponGetEligibleCoupons200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponGetEligibleCoupons200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = CouponGetEligibleCoupons200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => CouponGetEligibleCoupons200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
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

Map<String, dynamic> _$CouponGetEligibleCoupons200ResponseToJson(
  CouponGetEligibleCoupons200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
