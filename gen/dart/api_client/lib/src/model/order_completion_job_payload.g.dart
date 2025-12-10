// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_completion_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCompletionJobPayloadCWProxy {
  OrderCompletionJobPayload orderId(String orderId);

  OrderCompletionJobPayload driverId(String driverId);

  OrderCompletionJobPayload driverUserId(String driverUserId);

  OrderCompletionJobPayload totalPrice(num totalPrice);

  OrderCompletionJobPayload orderType(
    OrderCompletionJobPayloadOrderTypeEnum orderType,
  );

  OrderCompletionJobPayload commissionRate(num commissionRate);

  OrderCompletionJobPayload driverCurrentLocation(
    DriverMatchingJobPayloadPickupLocation? driverCurrentLocation,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCompletionJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCompletionJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCompletionJobPayload call({
    String orderId,
    String driverId,
    String driverUserId,
    num totalPrice,
    OrderCompletionJobPayloadOrderTypeEnum orderType,
    num commissionRate,
    DriverMatchingJobPayloadPickupLocation? driverCurrentLocation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCompletionJobPayload.copyWith(...)` or call `instanceOfOrderCompletionJobPayload.copyWith.fieldName(value)` for a single field.
class _$OrderCompletionJobPayloadCWProxyImpl
    implements _$OrderCompletionJobPayloadCWProxy {
  const _$OrderCompletionJobPayloadCWProxyImpl(this._value);

  final OrderCompletionJobPayload _value;

  @override
  OrderCompletionJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  OrderCompletionJobPayload driverId(String driverId) =>
      call(driverId: driverId);

  @override
  OrderCompletionJobPayload driverUserId(String driverUserId) =>
      call(driverUserId: driverUserId);

  @override
  OrderCompletionJobPayload totalPrice(num totalPrice) =>
      call(totalPrice: totalPrice);

  @override
  OrderCompletionJobPayload orderType(
    OrderCompletionJobPayloadOrderTypeEnum orderType,
  ) => call(orderType: orderType);

  @override
  OrderCompletionJobPayload commissionRate(num commissionRate) =>
      call(commissionRate: commissionRate);

  @override
  OrderCompletionJobPayload driverCurrentLocation(
    DriverMatchingJobPayloadPickupLocation? driverCurrentLocation,
  ) => call(driverCurrentLocation: driverCurrentLocation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCompletionJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCompletionJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCompletionJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? driverUserId = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? commissionRate = const $CopyWithPlaceholder(),
    Object? driverCurrentLocation = const $CopyWithPlaceholder(),
  }) {
    return OrderCompletionJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      driverUserId:
          driverUserId == const $CopyWithPlaceholder() || driverUserId == null
          ? _value.driverUserId
          // ignore: cast_nullable_to_non_nullable
          : driverUserId as String,
      totalPrice:
          totalPrice == const $CopyWithPlaceholder() || totalPrice == null
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as num,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderCompletionJobPayloadOrderTypeEnum,
      commissionRate:
          commissionRate == const $CopyWithPlaceholder() ||
              commissionRate == null
          ? _value.commissionRate
          // ignore: cast_nullable_to_non_nullable
          : commissionRate as num,
      driverCurrentLocation:
          driverCurrentLocation == const $CopyWithPlaceholder()
          ? _value.driverCurrentLocation
          // ignore: cast_nullable_to_non_nullable
          : driverCurrentLocation as DriverMatchingJobPayloadPickupLocation?,
    );
  }
}

extension $OrderCompletionJobPayloadCopyWith on OrderCompletionJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCompletionJobPayload.copyWith(...)` or `instanceOfOrderCompletionJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCompletionJobPayloadCWProxy get copyWith =>
      _$OrderCompletionJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCompletionJobPayload _$OrderCompletionJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCompletionJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'orderId',
      'driverId',
      'driverUserId',
      'totalPrice',
      'orderType',
      'commissionRate',
    ],
  );
  final val = OrderCompletionJobPayload(
    orderId: $checkedConvert('orderId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String),
    driverUserId: $checkedConvert('driverUserId', (v) => v as String),
    totalPrice: $checkedConvert('totalPrice', (v) => v as num),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecode(_$OrderCompletionJobPayloadOrderTypeEnumEnumMap, v),
    ),
    commissionRate: $checkedConvert('commissionRate', (v) => v as num),
    driverCurrentLocation: $checkedConvert(
      'driverCurrentLocation',
      (v) => v == null
          ? null
          : DriverMatchingJobPayloadPickupLocation.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderCompletionJobPayloadToJson(
  OrderCompletionJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'driverId': instance.driverId,
  'driverUserId': instance.driverUserId,
  'totalPrice': instance.totalPrice,
  'orderType':
      _$OrderCompletionJobPayloadOrderTypeEnumEnumMap[instance.orderType]!,
  'commissionRate': instance.commissionRate,
  'driverCurrentLocation': ?instance.driverCurrentLocation?.toJson(),
};

const _$OrderCompletionJobPayloadOrderTypeEnumEnumMap = {
  OrderCompletionJobPayloadOrderTypeEnum.RIDE: 'RIDE',
  OrderCompletionJobPayloadOrderTypeEnum.DELIVERY: 'DELIVERY',
  OrderCompletionJobPayloadOrderTypeEnum.FOOD: 'FOOD',
};
