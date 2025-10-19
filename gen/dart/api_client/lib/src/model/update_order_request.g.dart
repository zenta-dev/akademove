// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateOrderRequestCWProxy {
  UpdateOrderRequest driverId(String? driverId);

  UpdateOrderRequest merchantId(String? merchantId);

  UpdateOrderRequest type(UpdateOrderRequestTypeEnum? type);

  UpdateOrderRequest status(UpdateOrderRequestStatusEnum? status);

  UpdateOrderRequest distanceKm(num? distanceKm);

  UpdateOrderRequest tip(num? tip);

  UpdateOrderRequest totalPrice(num? totalPrice);

  UpdateOrderRequest note(OrderNote? note);

  UpdateOrderRequest itemCount(num? itemCount);

  UpdateOrderRequest items(List<OrderItem>? items);

  UpdateOrderRequest user(InsertOrderRequestUser? user);

  UpdateOrderRequest driver(InsertOrderRequestDriver? driver);

  UpdateOrderRequest merchant(InsertOrderRequestMerchant? merchant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOrderRequest call({
    String? driverId,
    String? merchantId,
    UpdateOrderRequestTypeEnum? type,
    UpdateOrderRequestStatusEnum? status,
    num? distanceKm,
    num? tip,
    num? totalPrice,
    OrderNote? note,
    num? itemCount,
    List<OrderItem>? items,
    InsertOrderRequestUser? user,
    InsertOrderRequestDriver? driver,
    InsertOrderRequestMerchant? merchant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateOrderRequest.copyWith.fieldName(...)`
class _$UpdateOrderRequestCWProxyImpl implements _$UpdateOrderRequestCWProxy {
  const _$UpdateOrderRequestCWProxyImpl(this._value);

  final UpdateOrderRequest _value;

  @override
  UpdateOrderRequest driverId(String? driverId) => this(driverId: driverId);

  @override
  UpdateOrderRequest merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  UpdateOrderRequest type(UpdateOrderRequestTypeEnum? type) => this(type: type);

  @override
  UpdateOrderRequest status(UpdateOrderRequestStatusEnum? status) =>
      this(status: status);

  @override
  UpdateOrderRequest distanceKm(num? distanceKm) =>
      this(distanceKm: distanceKm);

  @override
  UpdateOrderRequest tip(num? tip) => this(tip: tip);

  @override
  UpdateOrderRequest totalPrice(num? totalPrice) =>
      this(totalPrice: totalPrice);

  @override
  UpdateOrderRequest note(OrderNote? note) => this(note: note);

  @override
  UpdateOrderRequest itemCount(num? itemCount) => this(itemCount: itemCount);

  @override
  UpdateOrderRequest items(List<OrderItem>? items) => this(items: items);

  @override
  UpdateOrderRequest user(InsertOrderRequestUser? user) => this(user: user);

  @override
  UpdateOrderRequest driver(InsertOrderRequestDriver? driver) =>
      this(driver: driver);

  @override
  UpdateOrderRequest merchant(InsertOrderRequestMerchant? merchant) =>
      this(merchant: merchant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOrderRequest call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? tip = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return UpdateOrderRequest(
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
          : type as UpdateOrderRequestTypeEnum?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as UpdateOrderRequestStatusEnum?,
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
          : note as OrderNote?,
      itemCount: itemCount == const $CopyWithPlaceholder()
          ? _value.itemCount
          // ignore: cast_nullable_to_non_nullable
          : itemCount as num?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderItem>?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as InsertOrderRequestUser?,
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as InsertOrderRequestDriver?,
      merchant: merchant == const $CopyWithPlaceholder()
          ? _value.merchant
          // ignore: cast_nullable_to_non_nullable
          : merchant as InsertOrderRequestMerchant?,
    );
  }
}

extension $UpdateOrderRequestCopyWith on UpdateOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateOrderRequest.copyWith(...)` or like so:`instanceOfUpdateOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateOrderRequestCWProxy get copyWith =>
      _$UpdateOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderRequest _$UpdateOrderRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateOrderRequest', json, ($checkedConvert) {
      final val = UpdateOrderRequest(
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$UpdateOrderRequestTypeEnumEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$UpdateOrderRequestStatusEnumEnumMap, v),
        ),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
        tip: $checkedConvert('tip', (v) => v as num?),
        totalPrice: $checkedConvert('totalPrice', (v) => v as num?),
        note: $checkedConvert(
          'note',
          (v) =>
              v == null ? null : OrderNote.fromJson(v as Map<String, dynamic>),
        ),
        itemCount: $checkedConvert('itemCount', (v) => v as num?),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        user: $checkedConvert(
          'user',
          (v) => v == null
              ? null
              : InsertOrderRequestUser.fromJson(v as Map<String, dynamic>),
        ),
        driver: $checkedConvert(
          'driver',
          (v) => v == null
              ? null
              : InsertOrderRequestDriver.fromJson(v as Map<String, dynamic>),
        ),
        merchant: $checkedConvert(
          'merchant',
          (v) => v == null
              ? null
              : InsertOrderRequestMerchant.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateOrderRequestToJson(UpdateOrderRequest instance) =>
    <String, dynamic>{
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'type': ?_$UpdateOrderRequestTypeEnumEnumMap[instance.type],
      'status': ?_$UpdateOrderRequestStatusEnumEnumMap[instance.status],
      'distanceKm': ?instance.distanceKm,
      'tip': ?instance.tip,
      'totalPrice': ?instance.totalPrice,
      'note': ?instance.note?.toJson(),
      'itemCount': ?instance.itemCount,
      'items': ?instance.items?.map((e) => e.toJson()).toList(),
      'user': ?instance.user?.toJson(),
      'driver': ?instance.driver?.toJson(),
      'merchant': ?instance.merchant?.toJson(),
    };

const _$UpdateOrderRequestTypeEnumEnumMap = {
  UpdateOrderRequestTypeEnum.ride: 'ride',
  UpdateOrderRequestTypeEnum.delivery: 'delivery',
  UpdateOrderRequestTypeEnum.food: 'food',
};

const _$UpdateOrderRequestStatusEnumEnumMap = {
  UpdateOrderRequestStatusEnum.requested: 'requested',
  UpdateOrderRequestStatusEnum.matching: 'matching',
  UpdateOrderRequestStatusEnum.accepted: 'accepted',
  UpdateOrderRequestStatusEnum.arriving: 'arriving',
  UpdateOrderRequestStatusEnum.inTrip: 'in_trip',
  UpdateOrderRequestStatusEnum.completed: 'completed',
  UpdateOrderRequestStatusEnum.cancelledByUser: 'cancelled_by_user',
  UpdateOrderRequestStatusEnum.cancelledByDriver: 'cancelled_by_driver',
  UpdateOrderRequestStatusEnum.cancelledBySystem: 'cancelled_by_system',
};
