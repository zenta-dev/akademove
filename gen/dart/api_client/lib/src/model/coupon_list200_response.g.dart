// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponList200ResponseCWProxy {
  CouponList200Response message(String message);

  CouponList200Response data(List<Coupon> data);

  CouponList200Response pagination(PaginationResult? pagination);

  CouponList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponList200Response call({
    String message,
    List<Coupon> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponList200Response.copyWith.fieldName(...)`
class _$CouponList200ResponseCWProxyImpl
    implements _$CouponList200ResponseCWProxy {
  const _$CouponList200ResponseCWProxyImpl(this._value);

  final CouponList200Response _value;

  @override
  CouponList200Response message(String message) => this(message: message);

  @override
  CouponList200Response data(List<Coupon> data) => this(data: data);

  @override
  CouponList200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  CouponList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CouponList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Coupon>,
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

extension $CouponList200ResponseCopyWith on CouponList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfCouponList200Response.copyWith(...)` or like so:`instanceOfCouponList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponList200ResponseCWProxy get copyWith =>
      _$CouponList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponList200Response _$CouponList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = CouponList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$CouponList200ResponseToJson(
  CouponList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
