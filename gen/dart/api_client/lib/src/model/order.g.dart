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

  Order type(OrderType type);

  Order status(OrderStatus status);

  Order pickupLocation(Coordinate pickupLocation);

  Order dropoffLocation(Coordinate dropoffLocation);

  Order distanceKm(num distanceKm);

  Order basePrice(num basePrice);

  Order tip(num? tip);

  Order totalPrice(num totalPrice);

  Order platformCommission(num? platformCommission);

  Order driverEarning(num? driverEarning);

  Order merchantCommission(num? merchantCommission);

  Order couponId(String? couponId);

  Order couponCode(String? couponCode);

  Order discountAmount(num? discountAmount);

  Order note(OrderNote? note);

  Order requestedAt(DateTime requestedAt);

  Order acceptedAt(DateTime? acceptedAt);

  Order preparedAt(DateTime? preparedAt);

  Order readyAt(DateTime? readyAt);

  Order arrivedAt(DateTime? arrivedAt);

  Order cancelReason(String? cancelReason);

  Order createdAt(DateTime createdAt);

  Order updatedAt(DateTime updatedAt);

  Order gender(UserGender? gender);

  Order genderPreference(OrderGenderPreferenceEnum? genderPreference);

  Order proofOfDeliveryUrl(String? proofOfDeliveryUrl);

  Order deliveryOtp(String? deliveryOtp);

  Order otpVerifiedAt(DateTime? otpVerifiedAt);

  Order itemCount(num? itemCount);

  Order items(List<OrderItem>? items);

  Order user(DriverUser? user);

  Order driver(OrderDriver? driver);

  Order merchant(OrderMerchant? merchant);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Order(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ```
  Order call({
    String id,
    String userId,
    String? driverId,
    String? merchantId,
    OrderType type,
    OrderStatus status,
    Coordinate pickupLocation,
    Coordinate dropoffLocation,
    num distanceKm,
    num basePrice,
    num? tip,
    num totalPrice,
    num? platformCommission,
    num? driverEarning,
    num? merchantCommission,
    String? couponId,
    String? couponCode,
    num? discountAmount,
    OrderNote? note,
    DateTime requestedAt,
    DateTime? acceptedAt,
    DateTime? preparedAt,
    DateTime? readyAt,
    DateTime? arrivedAt,
    String? cancelReason,
    DateTime createdAt,
    DateTime updatedAt,
    UserGender? gender,
    OrderGenderPreferenceEnum? genderPreference,
    String? proofOfDeliveryUrl,
    String? deliveryOtp,
    DateTime? otpVerifiedAt,
    num? itemCount,
    List<OrderItem>? items,
    DriverUser? user,
    OrderDriver? driver,
    OrderMerchant? merchant,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrder.copyWith(...)` or call `instanceOfOrder.copyWith.fieldName(value)` for a single field.
class _$OrderCWProxyImpl implements _$OrderCWProxy {
  const _$OrderCWProxyImpl(this._value);

  final Order _value;

  @override
  Order id(String id) => call(id: id);

  @override
  Order userId(String userId) => call(userId: userId);

  @override
  Order driverId(String? driverId) => call(driverId: driverId);

  @override
  Order merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  Order type(OrderType type) => call(type: type);

  @override
  Order status(OrderStatus status) => call(status: status);

  @override
  Order pickupLocation(Coordinate pickupLocation) =>
      call(pickupLocation: pickupLocation);

  @override
  Order dropoffLocation(Coordinate dropoffLocation) =>
      call(dropoffLocation: dropoffLocation);

  @override
  Order distanceKm(num distanceKm) => call(distanceKm: distanceKm);

  @override
  Order basePrice(num basePrice) => call(basePrice: basePrice);

  @override
  Order tip(num? tip) => call(tip: tip);

  @override
  Order totalPrice(num totalPrice) => call(totalPrice: totalPrice);

  @override
  Order platformCommission(num? platformCommission) =>
      call(platformCommission: platformCommission);

  @override
  Order driverEarning(num? driverEarning) => call(driverEarning: driverEarning);

  @override
  Order merchantCommission(num? merchantCommission) =>
      call(merchantCommission: merchantCommission);

  @override
  Order couponId(String? couponId) => call(couponId: couponId);

  @override
  Order couponCode(String? couponCode) => call(couponCode: couponCode);

  @override
  Order discountAmount(num? discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  Order note(OrderNote? note) => call(note: note);

  @override
  Order requestedAt(DateTime requestedAt) => call(requestedAt: requestedAt);

  @override
  Order acceptedAt(DateTime? acceptedAt) => call(acceptedAt: acceptedAt);

  @override
  Order preparedAt(DateTime? preparedAt) => call(preparedAt: preparedAt);

  @override
  Order readyAt(DateTime? readyAt) => call(readyAt: readyAt);

  @override
  Order arrivedAt(DateTime? arrivedAt) => call(arrivedAt: arrivedAt);

  @override
  Order cancelReason(String? cancelReason) => call(cancelReason: cancelReason);

  @override
  Order createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Order updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  Order gender(UserGender? gender) => call(gender: gender);

  @override
  Order genderPreference(OrderGenderPreferenceEnum? genderPreference) =>
      call(genderPreference: genderPreference);

  @override
  Order proofOfDeliveryUrl(String? proofOfDeliveryUrl) =>
      call(proofOfDeliveryUrl: proofOfDeliveryUrl);

  @override
  Order deliveryOtp(String? deliveryOtp) => call(deliveryOtp: deliveryOtp);

  @override
  Order otpVerifiedAt(DateTime? otpVerifiedAt) =>
      call(otpVerifiedAt: otpVerifiedAt);

  @override
  Order itemCount(num? itemCount) => call(itemCount: itemCount);

  @override
  Order items(List<OrderItem>? items) => call(items: items);

  @override
  Order user(DriverUser? user) => call(user: user);

  @override
  Order driver(OrderDriver? driver) => call(driver: driver);

  @override
  Order merchant(OrderMerchant? merchant) => call(merchant: merchant);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Order(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ```
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
    Object? platformCommission = const $CopyWithPlaceholder(),
    Object? driverEarning = const $CopyWithPlaceholder(),
    Object? merchantCommission = const $CopyWithPlaceholder(),
    Object? couponId = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? requestedAt = const $CopyWithPlaceholder(),
    Object? acceptedAt = const $CopyWithPlaceholder(),
    Object? preparedAt = const $CopyWithPlaceholder(),
    Object? readyAt = const $CopyWithPlaceholder(),
    Object? arrivedAt = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? proofOfDeliveryUrl = const $CopyWithPlaceholder(),
    Object? deliveryOtp = const $CopyWithPlaceholder(),
    Object? otpVerifiedAt = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return Order(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as OrderType,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderStatus,
      pickupLocation:
          pickupLocation == const $CopyWithPlaceholder() ||
              pickupLocation == null
          ? _value.pickupLocation
          // ignore: cast_nullable_to_non_nullable
          : pickupLocation as Coordinate,
      dropoffLocation:
          dropoffLocation == const $CopyWithPlaceholder() ||
              dropoffLocation == null
          ? _value.dropoffLocation
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocation as Coordinate,
      distanceKm:
          distanceKm == const $CopyWithPlaceholder() || distanceKm == null
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num,
      basePrice: basePrice == const $CopyWithPlaceholder() || basePrice == null
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as num,
      tip: tip == const $CopyWithPlaceholder()
          ? _value.tip
          // ignore: cast_nullable_to_non_nullable
          : tip as num?,
      totalPrice:
          totalPrice == const $CopyWithPlaceholder() || totalPrice == null
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as num,
      platformCommission: platformCommission == const $CopyWithPlaceholder()
          ? _value.platformCommission
          // ignore: cast_nullable_to_non_nullable
          : platformCommission as num?,
      driverEarning: driverEarning == const $CopyWithPlaceholder()
          ? _value.driverEarning
          // ignore: cast_nullable_to_non_nullable
          : driverEarning as num?,
      merchantCommission: merchantCommission == const $CopyWithPlaceholder()
          ? _value.merchantCommission
          // ignore: cast_nullable_to_non_nullable
          : merchantCommission as num?,
      couponId: couponId == const $CopyWithPlaceholder()
          ? _value.couponId
          // ignore: cast_nullable_to_non_nullable
          : couponId as String?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as OrderNote?,
      requestedAt:
          requestedAt == const $CopyWithPlaceholder() || requestedAt == null
          ? _value.requestedAt
          // ignore: cast_nullable_to_non_nullable
          : requestedAt as DateTime,
      acceptedAt: acceptedAt == const $CopyWithPlaceholder()
          ? _value.acceptedAt
          // ignore: cast_nullable_to_non_nullable
          : acceptedAt as DateTime?,
      preparedAt: preparedAt == const $CopyWithPlaceholder()
          ? _value.preparedAt
          // ignore: cast_nullable_to_non_nullable
          : preparedAt as DateTime?,
      readyAt: readyAt == const $CopyWithPlaceholder()
          ? _value.readyAt
          // ignore: cast_nullable_to_non_nullable
          : readyAt as DateTime?,
      arrivedAt: arrivedAt == const $CopyWithPlaceholder()
          ? _value.arrivedAt
          // ignore: cast_nullable_to_non_nullable
          : arrivedAt as DateTime?,
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      genderPreference: genderPreference == const $CopyWithPlaceholder()
          ? _value.genderPreference
          // ignore: cast_nullable_to_non_nullable
          : genderPreference as OrderGenderPreferenceEnum?,
      proofOfDeliveryUrl: proofOfDeliveryUrl == const $CopyWithPlaceholder()
          ? _value.proofOfDeliveryUrl
          // ignore: cast_nullable_to_non_nullable
          : proofOfDeliveryUrl as String?,
      deliveryOtp: deliveryOtp == const $CopyWithPlaceholder()
          ? _value.deliveryOtp
          // ignore: cast_nullable_to_non_nullable
          : deliveryOtp as String?,
      otpVerifiedAt: otpVerifiedAt == const $CopyWithPlaceholder()
          ? _value.otpVerifiedAt
          // ignore: cast_nullable_to_non_nullable
          : otpVerifiedAt as DateTime?,
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
          : user as DriverUser?,
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as OrderDriver?,
      merchant: merchant == const $CopyWithPlaceholder()
          ? _value.merchant
          // ignore: cast_nullable_to_non_nullable
          : merchant as OrderMerchant?,
    );
  }
}

extension $OrderCopyWith on Order {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrder.copyWith(...)` or `instanceOfOrder.copyWith.fieldName(...)`.
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
    type: $checkedConvert('type', (v) => $enumDecode(_$OrderTypeEnumMap, v)),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$OrderStatusEnumMap, v),
    ),
    pickupLocation: $checkedConvert(
      'pickupLocation',
      (v) => Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    dropoffLocation: $checkedConvert(
      'dropoffLocation',
      (v) => Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    distanceKm: $checkedConvert('distanceKm', (v) => v as num),
    basePrice: $checkedConvert('basePrice', (v) => v as num),
    tip: $checkedConvert('tip', (v) => v as num?),
    totalPrice: $checkedConvert('totalPrice', (v) => v as num),
    platformCommission: $checkedConvert('platformCommission', (v) => v as num?),
    driverEarning: $checkedConvert('driverEarning', (v) => v as num?),
    merchantCommission: $checkedConvert('merchantCommission', (v) => v as num?),
    couponId: $checkedConvert('couponId', (v) => v as String?),
    couponCode: $checkedConvert('couponCode', (v) => v as String?),
    discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
    note: $checkedConvert(
      'note',
      (v) => v == null ? null : OrderNote.fromJson(v as Map<String, dynamic>),
    ),
    requestedAt: $checkedConvert(
      'requestedAt',
      (v) => DateTime.parse(v as String),
    ),
    acceptedAt: $checkedConvert(
      'acceptedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    preparedAt: $checkedConvert(
      'preparedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    readyAt: $checkedConvert(
      'readyAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    arrivedAt: $checkedConvert(
      'arrivedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    gender: $checkedConvert(
      'gender',
      (v) => $enumDecodeNullable(_$UserGenderEnumMap, v),
    ),
    genderPreference: $checkedConvert(
      'genderPreference',
      (v) => $enumDecodeNullable(_$OrderGenderPreferenceEnumEnumMap, v),
    ),
    proofOfDeliveryUrl: $checkedConvert(
      'proofOfDeliveryUrl',
      (v) => v as String?,
    ),
    deliveryOtp: $checkedConvert('deliveryOtp', (v) => v as String?),
    otpVerifiedAt: $checkedConvert(
      'otpVerifiedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
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
      (v) => v == null ? null : DriverUser.fromJson(v as Map<String, dynamic>),
    ),
    driver: $checkedConvert(
      'driver',
      (v) => v == null ? null : OrderDriver.fromJson(v as Map<String, dynamic>),
    ),
    merchant: $checkedConvert(
      'merchant',
      (v) =>
          v == null ? null : OrderMerchant.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'driverId': ?instance.driverId,
  'merchantId': ?instance.merchantId,
  'type': _$OrderTypeEnumMap[instance.type]!,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'pickupLocation': instance.pickupLocation.toJson(),
  'dropoffLocation': instance.dropoffLocation.toJson(),
  'distanceKm': instance.distanceKm,
  'basePrice': instance.basePrice,
  'tip': ?instance.tip,
  'totalPrice': instance.totalPrice,
  'platformCommission': ?instance.platformCommission,
  'driverEarning': ?instance.driverEarning,
  'merchantCommission': ?instance.merchantCommission,
  'couponId': ?instance.couponId,
  'couponCode': ?instance.couponCode,
  'discountAmount': ?instance.discountAmount,
  'note': ?instance.note?.toJson(),
  'requestedAt': instance.requestedAt.toIso8601String(),
  'acceptedAt': ?instance.acceptedAt?.toIso8601String(),
  'preparedAt': ?instance.preparedAt?.toIso8601String(),
  'readyAt': ?instance.readyAt?.toIso8601String(),
  'arrivedAt': ?instance.arrivedAt?.toIso8601String(),
  'cancelReason': ?instance.cancelReason,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'genderPreference':
      ?_$OrderGenderPreferenceEnumEnumMap[instance.genderPreference],
  'proofOfDeliveryUrl': ?instance.proofOfDeliveryUrl,
  'deliveryOtp': ?instance.deliveryOtp,
  'otpVerifiedAt': ?instance.otpVerifiedAt?.toIso8601String(),
  'itemCount': ?instance.itemCount,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
  'user': ?instance.user?.toJson(),
  'driver': ?instance.driver?.toJson(),
  'merchant': ?instance.merchant?.toJson(),
};

const _$OrderTypeEnumMap = {
  OrderType.RIDE: 'RIDE',
  OrderType.DELIVERY: 'DELIVERY',
  OrderType.FOOD: 'FOOD',
};

const _$OrderStatusEnumMap = {
  OrderStatus.REQUESTED: 'REQUESTED',
  OrderStatus.MATCHING: 'MATCHING',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.PREPARING: 'PREPARING',
  OrderStatus.READY_FOR_PICKUP: 'READY_FOR_PICKUP',
  OrderStatus.ARRIVING: 'ARRIVING',
  OrderStatus.IN_TRIP: 'IN_TRIP',
  OrderStatus.COMPLETED: 'COMPLETED',
  OrderStatus.CANCELLED_BY_USER: 'CANCELLED_BY_USER',
  OrderStatus.CANCELLED_BY_DRIVER: 'CANCELLED_BY_DRIVER',
  OrderStatus.CANCELLED_BY_MERCHANT: 'CANCELLED_BY_MERCHANT',
  OrderStatus.CANCELLED_BY_SYSTEM: 'CANCELLED_BY_SYSTEM',
};

const _$UserGenderEnumMap = {
  UserGender.MALE: 'MALE',
  UserGender.FEMALE: 'FEMALE',
};

const _$OrderGenderPreferenceEnumEnumMap = {
  OrderGenderPreferenceEnum.SAME: 'SAME',
  OrderGenderPreferenceEnum.ANY: 'ANY',
};
