// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCWProxy {
  Order id(String id);

  Order userId(String userId);

  Order driverId(String? driverId);

  Order merchantId(String? merchantId);

  Order type(OrderTypeEnum type);

  Order status(OrderStatusEnum status);

  Order pickupLocation(Location pickupLocation);

  Order dropoffLocation(Location dropoffLocation);

  Order distanceKm(num distanceKm);

  Order basePrice(num basePrice);

  Order tip(num? tip);

  Order totalPrice(num totalPrice);

  Order note(OrderCreateRequestNote? note);

  Order requestedAt(DateTime requestedAt);

  Order acceptedAt(DateTime? acceptedAt);

  Order arrivedAt(DateTime? arrivedAt);

  Order createdAt(DateTime createdAt);

  Order updatedAt(DateTime updatedAt);

  Order user(OrderCreateRequestUser? user);

  Order driver(OrderCreateRequestDriver? driver);

  Order merchant(OrderCreateRequestMerchant? merchant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    String id,
    String userId,
    String? driverId,
    String? merchantId,
    OrderTypeEnum type,
    OrderStatusEnum status,
    Location pickupLocation,
    Location dropoffLocation,
    num distanceKm,
    num basePrice,
    num? tip,
    num totalPrice,
    OrderCreateRequestNote? note,
    DateTime requestedAt,
    DateTime? acceptedAt,
    DateTime? arrivedAt,
    DateTime createdAt,
    DateTime updatedAt,
    OrderCreateRequestUser? user,
    OrderCreateRequestDriver? driver,
    OrderCreateRequestMerchant? merchant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrder.copyWith.fieldName(...)`
class _$OrderCWProxyImpl implements _$OrderCWProxy {
  const _$OrderCWProxyImpl(this._value);

  final Order _value;

  @override
  Order id(String id) => this(id: id);

  @override
  Order userId(String userId) => this(userId: userId);

  @override
  Order driverId(String? driverId) => this(driverId: driverId);

  @override
  Order merchantId(String? merchantId) => this(merchantId: merchantId);

  @override
  Order type(OrderTypeEnum type) => this(type: type);

  @override
  Order status(OrderStatusEnum status) => this(status: status);

  @override
  Order pickupLocation(Location pickupLocation) =>
      this(pickupLocation: pickupLocation);

  @override
  Order dropoffLocation(Location dropoffLocation) =>
      this(dropoffLocation: dropoffLocation);

  @override
  Order distanceKm(num distanceKm) => this(distanceKm: distanceKm);

  @override
  Order basePrice(num basePrice) => this(basePrice: basePrice);

  @override
  Order tip(num? tip) => this(tip: tip);

  @override
  Order totalPrice(num totalPrice) => this(totalPrice: totalPrice);

  @override
  Order note(OrderCreateRequestNote? note) => this(note: note);

  @override
  Order requestedAt(DateTime requestedAt) => this(requestedAt: requestedAt);

  @override
  Order acceptedAt(DateTime? acceptedAt) => this(acceptedAt: acceptedAt);

  @override
  Order arrivedAt(DateTime? arrivedAt) => this(arrivedAt: arrivedAt);

  @override
  Order createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Order updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  Order user(OrderCreateRequestUser? user) => this(user: user);

  @override
  Order driver(OrderCreateRequestDriver? driver) => this(driver: driver);

  @override
  Order merchant(OrderCreateRequestMerchant? merchant) =>
      this(merchant: merchant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    Object? id = const $CopyWithPlaceholder(),
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
    Object? requestedAt = const $CopyWithPlaceholder(),
    Object? acceptedAt = const $CopyWithPlaceholder(),
    Object? arrivedAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return Order(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
          : type as OrderTypeEnum,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderStatusEnum,
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
      requestedAt: requestedAt == const $CopyWithPlaceholder()
          ? _value.requestedAt
          // ignore: cast_nullable_to_non_nullable
          : requestedAt as DateTime,
      acceptedAt: acceptedAt == const $CopyWithPlaceholder()
          ? _value.acceptedAt
          // ignore: cast_nullable_to_non_nullable
          : acceptedAt as DateTime?,
      arrivedAt: arrivedAt == const $CopyWithPlaceholder()
          ? _value.arrivedAt
          // ignore: cast_nullable_to_non_nullable
          : arrivedAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
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

extension $OrderCopyWith on Order {
  /// Returns a callable class that can be used as follows: `instanceOfOrder.copyWith(...)` or like so:`instanceOfOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCWProxy get copyWith => _$OrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Order', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'type',
      'status',
      'pickupLocation',
      'dropoffLocation',
      'distanceKm',
      'basePrice',
      'totalPrice',
      'requestedAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Order(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$OrderTypeEnumEnumMap, v),
    ),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$OrderStatusEnumEnumMap, v),
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
    requestedAt: $checkedConvert(
      'requestedAt',
      (v) => DateTime.parse(v as String),
    ),
    acceptedAt: $checkedConvert(
      'acceptedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    arrivedAt: $checkedConvert(
      'arrivedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
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

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'driverId': ?instance.driverId,
  'merchantId': ?instance.merchantId,
  'type': _$OrderTypeEnumEnumMap[instance.type]!,
  'status': _$OrderStatusEnumEnumMap[instance.status]!,
  'pickupLocation': instance.pickupLocation.toJson(),
  'dropoffLocation': instance.dropoffLocation.toJson(),
  'distanceKm': instance.distanceKm,
  'basePrice': instance.basePrice,
  'tip': ?instance.tip,
  'totalPrice': instance.totalPrice,
  'note': ?instance.note?.toJson(),
  'requestedAt': instance.requestedAt.toIso8601String(),
  'acceptedAt': ?instance.acceptedAt?.toIso8601String(),
  'arrivedAt': ?instance.arrivedAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'user': ?instance.user?.toJson(),
  'driver': ?instance.driver?.toJson(),
  'merchant': ?instance.merchant?.toJson(),
};

const _$OrderTypeEnumEnumMap = {
  OrderTypeEnum.ride: 'ride',
  OrderTypeEnum.delivery: 'delivery',
  OrderTypeEnum.food: 'food',
};

const _$OrderStatusEnumEnumMap = {
  OrderStatusEnum.requested: 'requested',
  OrderStatusEnum.matching: 'matching',
  OrderStatusEnum.accepted: 'accepted',
  OrderStatusEnum.arriving: 'arriving',
  OrderStatusEnum.inTrip: 'in_trip',
  OrderStatusEnum.completed: 'completed',
  OrderStatusEnum.cancelledByUser: 'cancelled_by_user',
  OrderStatusEnum.cancelledByDriver: 'cancelled_by_driver',
  OrderStatusEnum.cancelledBySystem: 'cancelled_by_system',
};
