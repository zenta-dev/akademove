// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderUpdateRequestCWProxy {
  OrderUpdateRequest driverId(String? driverId);

  OrderUpdateRequest merchantId(String? merchantId);

  OrderUpdateRequest type(OrderUpdateRequestTypeEnum? type);

  OrderUpdateRequest status(OrderUpdateRequestStatusEnum? status);

  OrderUpdateRequest distanceKm(num? distanceKm);

  OrderUpdateRequest tip(num? tip);

  OrderUpdateRequest totalPrice(num? totalPrice);

  OrderUpdateRequest note(OrderCreateRequestNote? note);

  OrderUpdateRequest user(OrderCreateRequestUser? user);

  OrderUpdateRequest driver(OrderCreateRequestDriver? driver);

  OrderUpdateRequest merchant(OrderCreateRequestMerchant? merchant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderUpdateRequest call({
    String? driverId,
    String? merchantId,
    OrderUpdateRequestTypeEnum? type,
    OrderUpdateRequestStatusEnum? status,
    num? distanceKm,
    num? tip,
    num? totalPrice,
    OrderCreateRequestNote? note,
    OrderCreateRequestUser? user,
    OrderCreateRequestDriver? driver,
    OrderCreateRequestMerchant? merchant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderUpdateRequest.copyWith.fieldName(...)`
class _$OrderUpdateRequestCWProxyImpl implements _$OrderUpdateRequestCWProxy {
  const _$OrderUpdateRequestCWProxyImpl(this._value);

  final OrderUpdateRequest _value;

  @override
  OrderUpdateRequest driverId(String? driverId) => this(driverId: driverId);

  @override
  OrderUpdateRequest merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  OrderUpdateRequest type(OrderUpdateRequestTypeEnum? type) => this(type: type);

  @override
  OrderUpdateRequest status(OrderUpdateRequestStatusEnum? status) =>
      this(status: status);

  @override
  OrderUpdateRequest distanceKm(num? distanceKm) =>
      this(distanceKm: distanceKm);

  @override
  OrderUpdateRequest tip(num? tip) => this(tip: tip);

  @override
  OrderUpdateRequest totalPrice(num? totalPrice) =>
      this(totalPrice: totalPrice);

  @override
  OrderUpdateRequest note(OrderCreateRequestNote? note) => this(note: note);

  @override
  OrderUpdateRequest user(OrderCreateRequestUser? user) => this(user: user);

  @override
  OrderUpdateRequest driver(OrderCreateRequestDriver? driver) =>
      this(driver: driver);

  @override
  OrderUpdateRequest merchant(OrderCreateRequestMerchant? merchant) =>
      this(merchant: merchant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderUpdateRequest call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? tip = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return OrderUpdateRequest(
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as OrderUpdateRequestTypeEnum?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderUpdateRequestStatusEnum?,
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num?,
      tip: tip == const $CopyWithPlaceholder()
          ? _value.tip
          // ignore: cast_nullable_to_non_nullable
          : tip as num?,
      totalPrice: totalPrice == const $CopyWithPlaceholder()
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as num?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as OrderCreateRequestNote?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as OrderCreateRequestUser?,
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as OrderCreateRequestDriver?,
      merchant: merchant == const $CopyWithPlaceholder()
          ? _value.merchant
          // ignore: cast_nullable_to_non_nullable
          : merchant as OrderCreateRequestMerchant?,
    );
  }
}

extension $OrderUpdateRequestCopyWith on OrderUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfOrderUpdateRequest.copyWith(...)` or like so:`instanceOfOrderUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderUpdateRequestCWProxy get copyWith =>
      _$OrderUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUpdateRequest _$OrderUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderUpdateRequest', json, ($checkedConvert) {
      final val = OrderUpdateRequest(
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$OrderUpdateRequestTypeEnumEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$OrderUpdateRequestStatusEnumEnumMap, v),
        ),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
        tip: $checkedConvert('tip', (v) => v as num?),
        totalPrice: $checkedConvert('totalPrice', (v) => v as num?),
        note: $checkedConvert(
          'note',
          (v) => v == null
              ? null
              : OrderCreateRequestNote.fromJson(v as Map<String, dynamic>),
        ),
        user: $checkedConvert(
          'user',
          (v) => v == null
              ? null
              : OrderCreateRequestUser.fromJson(v as Map<String, dynamic>),
        ),
        driver: $checkedConvert(
          'driver',
          (v) => v == null
              ? null
              : OrderCreateRequestDriver.fromJson(v as Map<String, dynamic>),
        ),
        merchant: $checkedConvert(
          'merchant',
          (v) => v == null
              ? null
              : OrderCreateRequestMerchant.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderUpdateRequestToJson(OrderUpdateRequest instance) =>
    <String, dynamic>{
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'type': ?_$OrderUpdateRequestTypeEnumEnumMap[instance.type],
      'status': ?_$OrderUpdateRequestStatusEnumEnumMap[instance.status],
      'distanceKm': ?instance.distanceKm,
      'tip': ?instance.tip,
      'totalPrice': ?instance.totalPrice,
      'note': ?instance.note?.toJson(),
      'user': ?instance.user?.toJson(),
      'driver': ?instance.driver?.toJson(),
      'merchant': ?instance.merchant?.toJson(),
    };

const _$OrderUpdateRequestTypeEnumEnumMap = {
  OrderUpdateRequestTypeEnum.ride: 'ride',
  OrderUpdateRequestTypeEnum.delivery: 'delivery',
  OrderUpdateRequestTypeEnum.food: 'food',
};

const _$OrderUpdateRequestStatusEnumEnumMap = {
  OrderUpdateRequestStatusEnum.requested: 'requested',
  OrderUpdateRequestStatusEnum.matching: 'matching',
  OrderUpdateRequestStatusEnum.accepted: 'accepted',
  OrderUpdateRequestStatusEnum.arriving: 'arriving',
  OrderUpdateRequestStatusEnum.inTrip: 'in_trip',
  OrderUpdateRequestStatusEnum.completed: 'completed',
  OrderUpdateRequestStatusEnum.cancelledByUser: 'cancelled_by_user',
  OrderUpdateRequestStatusEnum.cancelledByDriver: 'cancelled_by_driver',
  OrderUpdateRequestStatusEnum.cancelledBySystem: 'cancelled_by_system',
};
