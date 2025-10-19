// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertOrderRequestCWProxy {
  InsertOrderRequest userId(String userId);

  InsertOrderRequest driverId(String? driverId);

  InsertOrderRequest merchantId(String? merchantId);

  InsertOrderRequest type(InsertOrderRequestTypeEnum type);

  InsertOrderRequest status(InsertOrderRequestStatusEnum status);

  InsertOrderRequest pickupLocation(Location pickupLocation);

  InsertOrderRequest dropoffLocation(Location dropoffLocation);

  InsertOrderRequest distanceKm(num distanceKm);

  InsertOrderRequest basePrice(num basePrice);

  InsertOrderRequest tip(num? tip);

  InsertOrderRequest totalPrice(num totalPrice);

  InsertOrderRequest note(OrderNote? note);

  InsertOrderRequest itemCount(num? itemCount);

  InsertOrderRequest items(List<OrderItem>? items);

  InsertOrderRequest user(InsertOrderRequestUser? user);

  InsertOrderRequest driver(InsertOrderRequestDriver? driver);

  InsertOrderRequest merchant(InsertOrderRequestMerchant? merchant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertOrderRequest call({
    String userId,
    String? driverId,
    String? merchantId,
    InsertOrderRequestTypeEnum type,
    InsertOrderRequestStatusEnum status,
    Location pickupLocation,
    Location dropoffLocation,
    num distanceKm,
    num basePrice,
    num? tip,
    num totalPrice,
    OrderNote? note,
    num? itemCount,
    List<OrderItem>? items,
    InsertOrderRequestUser? user,
    InsertOrderRequestDriver? driver,
    InsertOrderRequestMerchant? merchant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertOrderRequest.copyWith.fieldName(...)`
class _$InsertOrderRequestCWProxyImpl implements _$InsertOrderRequestCWProxy {
  const _$InsertOrderRequestCWProxyImpl(this._value);

  final InsertOrderRequest _value;

  @override
  InsertOrderRequest userId(String userId) => this(userId: userId);

  @override
  InsertOrderRequest driverId(String? driverId) => this(driverId: driverId);

  @override
  InsertOrderRequest merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  InsertOrderRequest type(InsertOrderRequestTypeEnum type) => this(type: type);

  @override
  InsertOrderRequest status(InsertOrderRequestStatusEnum status) =>
      this(status: status);

  @override
  InsertOrderRequest pickupLocation(Location pickupLocation) =>
      this(pickupLocation: pickupLocation);

  @override
  InsertOrderRequest dropoffLocation(Location dropoffLocation) =>
      this(dropoffLocation: dropoffLocation);

  @override
  InsertOrderRequest distanceKm(num distanceKm) => this(distanceKm: distanceKm);

  @override
  InsertOrderRequest basePrice(num basePrice) => this(basePrice: basePrice);

  @override
  InsertOrderRequest tip(num? tip) => this(tip: tip);

  @override
  InsertOrderRequest totalPrice(num totalPrice) => this(totalPrice: totalPrice);

  @override
  InsertOrderRequest note(OrderNote? note) => this(note: note);

  @override
  InsertOrderRequest itemCount(num? itemCount) => this(itemCount: itemCount);

  @override
  InsertOrderRequest items(List<OrderItem>? items) => this(items: items);

  @override
  InsertOrderRequest user(InsertOrderRequestUser? user) => this(user: user);

  @override
  InsertOrderRequest driver(InsertOrderRequestDriver? driver) =>
      this(driver: driver);

  @override
  InsertOrderRequest merchant(InsertOrderRequestMerchant? merchant) =>
      this(merchant: merchant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertOrderRequest call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? dropoffLocation = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? basePrice = const $CopyWithPlaceholder(),
    Object? tip = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return InsertOrderRequest(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
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
          : type as InsertOrderRequestTypeEnum,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as InsertOrderRequestStatusEnum,
      pickupLocation: pickupLocation == const $CopyWithPlaceholder()
          ? _value.pickupLocation
          // ignore: cast_nullable_to_non_nullable
          : pickupLocation as Location,
      dropoffLocation: dropoffLocation == const $CopyWithPlaceholder()
          ? _value.dropoffLocation
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocation as Location,
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num,
      basePrice: basePrice == const $CopyWithPlaceholder()
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as num,
      tip: tip == const $CopyWithPlaceholder()
          ? _value.tip
          // ignore: cast_nullable_to_non_nullable
          : tip as num?,
      totalPrice: totalPrice == const $CopyWithPlaceholder()
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as num,
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

extension $InsertOrderRequestCopyWith on InsertOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertOrderRequest.copyWith(...)` or like so:`instanceOfInsertOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertOrderRequestCWProxy get copyWith =>
      _$InsertOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertOrderRequest _$InsertOrderRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertOrderRequest', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'userId',
          'type',
          'status',
          'pickupLocation',
          'dropoffLocation',
          'distanceKm',
          'basePrice',
          'totalPrice',
        ],
      );
      final val = InsertOrderRequest(
        userId: $checkedConvert('userId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$InsertOrderRequestTypeEnumEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$InsertOrderRequestStatusEnumEnumMap, v),
        ),
        pickupLocation: $checkedConvert(
          'pickupLocation',
          (v) => Location.fromJson(v as Map<String, dynamic>),
        ),
        dropoffLocation: $checkedConvert(
          'dropoffLocation',
          (v) => Location.fromJson(v as Map<String, dynamic>),
        ),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num),
        basePrice: $checkedConvert('basePrice', (v) => v as num),
        tip: $checkedConvert('tip', (v) => v as num?),
        totalPrice: $checkedConvert('totalPrice', (v) => v as num),
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

Map<String, dynamic> _$InsertOrderRequestToJson(InsertOrderRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'type': _$InsertOrderRequestTypeEnumEnumMap[instance.type]!,
      'status': _$InsertOrderRequestStatusEnumEnumMap[instance.status]!,
      'pickupLocation': instance.pickupLocation.toJson(),
      'dropoffLocation': instance.dropoffLocation.toJson(),
      'distanceKm': instance.distanceKm,
      'basePrice': instance.basePrice,
      'tip': ?instance.tip,
      'totalPrice': instance.totalPrice,
      'note': ?instance.note?.toJson(),
      'itemCount': ?instance.itemCount,
      'items': ?instance.items?.map((e) => e.toJson()).toList(),
      'user': ?instance.user?.toJson(),
      'driver': ?instance.driver?.toJson(),
      'merchant': ?instance.merchant?.toJson(),
    };

const _$InsertOrderRequestTypeEnumEnumMap = {
  InsertOrderRequestTypeEnum.ride: 'ride',
  InsertOrderRequestTypeEnum.delivery: 'delivery',
  InsertOrderRequestTypeEnum.food: 'food',
};

const _$InsertOrderRequestStatusEnumEnumMap = {
  InsertOrderRequestStatusEnum.requested: 'requested',
  InsertOrderRequestStatusEnum.matching: 'matching',
  InsertOrderRequestStatusEnum.accepted: 'accepted',
  InsertOrderRequestStatusEnum.arriving: 'arriving',
  InsertOrderRequestStatusEnum.inTrip: 'in_trip',
  InsertOrderRequestStatusEnum.completed: 'completed',
  InsertOrderRequestStatusEnum.cancelledByUser: 'cancelled_by_user',
  InsertOrderRequestStatusEnum.cancelledByDriver: 'cancelled_by_driver',
  InsertOrderRequestStatusEnum.cancelledBySystem: 'cancelled_by_system',
};
