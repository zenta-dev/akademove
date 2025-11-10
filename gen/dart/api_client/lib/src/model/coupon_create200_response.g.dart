// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreate200ResponseCWProxy {
  CouponCreate200Response message(String message);

  CouponCreate200Response data(Coupon data);

  CouponCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreate200Response call({String message, Coupon data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreate200Response.copyWith.fieldName(...)`
class _$CouponCreate200ResponseCWProxyImpl
    implements _$CouponCreate200ResponseCWProxy {
  const _$CouponCreate200ResponseCWProxyImpl(this._value);

  final CouponCreate200Response _value;

  @override
  CouponCreate200Response message(String message) => this(message: message);

  @override
  CouponCreate200Response data(Coupon data) => this(data: data);

  @override
  CouponCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CouponCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Coupon,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $CouponCreate200ResponseCopyWith on CouponCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreate200Response.copyWith(...)` or like so:`instanceOfCouponCreate200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Coupon.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$CouponCreate200ResponseToJson(
  CouponCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
