// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestCWProxy {
  OrderCreateRequest userId(String userId);

  OrderCreateRequest driverId(String? driverId);

  OrderCreateRequest merchantId(String? merchantId);

  OrderCreateRequest type(OrderCreateRequestTypeEnum type);

  OrderCreateRequest status(OrderCreateRequestStatusEnum status);

  OrderCreateRequest pickupLocation(Location pickupLocation);

  OrderCreateRequest dropoffLocation(Location dropoffLocation);

  OrderCreateRequest distanceKm(num distanceKm);

  OrderCreateRequest basePrice(num basePrice);

  OrderCreateRequest tip(num? tip);

  OrderCreateRequest totalPrice(num totalPrice);

  OrderCreateRequest note(OrderCreateRequestNote? note);

  OrderCreateRequest itemCount(num? itemCount);

  OrderCreateRequest items(List<OrderCreateRequestItemsInner>? items);

  OrderCreateRequest user(OrderCreateRequestUser? user);

  OrderCreateRequest driver(OrderCreateRequestDriver? driver);

  OrderCreateRequest merchant(OrderCreateRequestMerchant? merchant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequest call({
    String userId,
    String? driverId,
    String? merchantId,
    OrderCreateRequestTypeEnum type,
    OrderCreateRequestStatusEnum status,
    Location pickupLocation,
    Location dropoffLocation,
    num distanceKm,
    num basePrice,
    num? tip,
    num totalPrice,
    OrderCreateRequestNote? note,
    num? itemCount,
    List<OrderCreateRequestItemsInner>? items,
    OrderCreateRequestUser? user,
    OrderCreateRequestDriver? driver,
    OrderCreateRequestMerchant? merchant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequest.copyWith.fieldName(...)`
class _$OrderCreateRequestCWProxyImpl implements _$OrderCreateRequestCWProxy {
  const _$OrderCreateRequestCWProxyImpl(this._value);

  final OrderCreateRequest _value;

  @override
  OrderCreateRequest userId(String userId) => this(userId: userId);

  @override
  OrderCreateRequest driverId(String? driverId) => this(driverId: driverId);

  @override
  OrderCreateRequest merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  OrderCreateRequest type(OrderCreateRequestTypeEnum type) => this(type: type);

  @override
  OrderCreateRequest status(OrderCreateRequestStatusEnum status) =>
      this(status: status);

  @override
  OrderCreateRequest pickupLocation(Location pickupLocation) =>
      this(pickupLocation: pickupLocation);

  @override
  OrderCreateRequest dropoffLocation(Location dropoffLocation) =>
      this(dropoffLocation: dropoffLocation);

  @override
  OrderCreateRequest distanceKm(num distanceKm) => this(distanceKm: distanceKm);

  @override
  OrderCreateRequest basePrice(num basePrice) => this(basePrice: basePrice);

  @override
  OrderCreateRequest tip(num? tip) => this(tip: tip);

  @override
  OrderCreateRequest totalPrice(num totalPrice) => this(totalPrice: totalPrice);

  @override
  OrderCreateRequest note(OrderCreateRequestNote? note) => this(note: note);

  @override
  OrderCreateRequest itemCount(num? itemCount) => this(itemCount: itemCount);

  @override
  OrderCreateRequest items(List<OrderCreateRequestItemsInner>? items) =>
      this(items: items);

  @override
  OrderCreateRequest user(OrderCreateRequestUser? user) => this(user: user);

  @override
  OrderCreateRequest driver(OrderCreateRequestDriver? driver) =>
      this(driver: driver);

  @override
  OrderCreateRequest merchant(OrderCreateRequestMerchant? merchant) =>
      this(merchant: merchant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequest call({
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
    return OrderCreateRequest(
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
          : type as OrderCreateRequestTypeEnum,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderCreateRequestStatusEnum,
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
          : note as OrderCreateRequestNote?,
      itemCount: itemCount == const $CopyWithPlaceholder()
          ? _value.itemCount
          // ignore: cast_nullable_to_non_nullable
          : itemCount as num?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderCreateRequestItemsInner>?,
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

extension $OrderCreateRequestCopyWith on OrderCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequest.copyWith(...)` or like so:`instanceOfOrderCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestCWProxy get copyWith =>
      _$OrderCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderCreateRequest', json, ($checkedConvert) {
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
      final val = OrderCreateRequest(
        userId: $checkedConvert('userId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$OrderCreateRequestTypeEnumEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$OrderCreateRequestStatusEnumEnumMap, v),
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
          (v) => v == null
              ? null
              : OrderCreateRequestNote.fromJson(v as Map<String, dynamic>),
        ),
        itemCount: $checkedConvert('itemCount', (v) => v as num?),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>?)
              ?.map(
                (e) => OrderCreateRequestItemsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
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

Map<String, dynamic> _$OrderCreateRequestToJson(OrderCreateRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'type': _$OrderCreateRequestTypeEnumEnumMap[instance.type]!,
      'status': _$OrderCreateRequestStatusEnumEnumMap[instance.status]!,
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

const _$OrderCreateRequestTypeEnumEnumMap = {
  OrderCreateRequestTypeEnum.ride: 'ride',
  OrderCreateRequestTypeEnum.delivery: 'delivery',
  OrderCreateRequestTypeEnum.food: 'food',
};

const _$OrderCreateRequestStatusEnumEnumMap = {
  OrderCreateRequestStatusEnum.requested: 'requested',
  OrderCreateRequestStatusEnum.matching: 'matching',
  OrderCreateRequestStatusEnum.accepted: 'accepted',
  OrderCreateRequestStatusEnum.arriving: 'arriving',
  OrderCreateRequestStatusEnum.inTrip: 'in_trip',
  OrderCreateRequestStatusEnum.completed: 'completed',
  OrderCreateRequestStatusEnum.cancelledByUser: 'cancelled_by_user',
  OrderCreateRequestStatusEnum.cancelledByDriver: 'cancelled_by_driver',
  OrderCreateRequestStatusEnum.cancelledBySystem: 'cancelled_by_system',
};
