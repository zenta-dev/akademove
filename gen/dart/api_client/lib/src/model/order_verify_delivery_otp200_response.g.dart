// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_verify_delivery_otp200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderVerifyDeliveryOTP200ResponseCWProxy {
  OrderVerifyDeliveryOTP200Response message(String message);

  OrderVerifyDeliveryOTP200Response data(
    OrderVerifyDeliveryOTP200ResponseData data,
  );

  OrderVerifyDeliveryOTP200Response pagination(PaginationResult? pagination);

  OrderVerifyDeliveryOTP200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTP200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTP200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTP200Response call({
    String message,
    OrderVerifyDeliveryOTP200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderVerifyDeliveryOTP200Response.copyWith(...)` or call `instanceOfOrderVerifyDeliveryOTP200Response.copyWith.fieldName(value)` for a single field.
class _$OrderVerifyDeliveryOTP200ResponseCWProxyImpl
    implements _$OrderVerifyDeliveryOTP200ResponseCWProxy {
  const _$OrderVerifyDeliveryOTP200ResponseCWProxyImpl(this._value);

  final OrderVerifyDeliveryOTP200Response _value;

  @override
  OrderVerifyDeliveryOTP200Response message(String message) =>
      call(message: message);

  @override
  OrderVerifyDeliveryOTP200Response data(
    OrderVerifyDeliveryOTP200ResponseData data,
  ) => call(data: data);

  @override
  OrderVerifyDeliveryOTP200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  OrderVerifyDeliveryOTP200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTP200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTP200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTP200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderVerifyDeliveryOTP200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderVerifyDeliveryOTP200ResponseData,
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

extension $OrderVerifyDeliveryOTP200ResponseCopyWith
    on OrderVerifyDeliveryOTP200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderVerifyDeliveryOTP200Response.copyWith(...)` or `instanceOfOrderVerifyDeliveryOTP200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderVerifyDeliveryOTP200ResponseCWProxy get copyWith =>
      _$OrderVerifyDeliveryOTP200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVerifyDeliveryOTP200Response _$OrderVerifyDeliveryOTP200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderVerifyDeliveryOTP200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = OrderVerifyDeliveryOTP200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => OrderVerifyDeliveryOTP200ResponseData.fromJson(
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

Map<String, dynamic> _$OrderVerifyDeliveryOTP200ResponseToJson(
  OrderVerifyDeliveryOTP200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
