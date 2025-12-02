// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateOrderCWProxy {
  UpdateOrder driverId(String? driverId);

  UpdateOrder merchantId(String? merchantId);

  UpdateOrder type(OrderType? type);

  UpdateOrder status(OrderStatus? status);

  UpdateOrder distanceKm(num? distanceKm);

  UpdateOrder tip(num? tip);

  UpdateOrder totalPrice(num? totalPrice);

  UpdateOrder platformCommission(num? platformCommission);

  UpdateOrder driverEarning(num? driverEarning);

  UpdateOrder merchantCommission(num? merchantCommission);

  UpdateOrder couponId(String? couponId);

  UpdateOrder couponCode(String? couponCode);

  UpdateOrder discountAmount(num? discountAmount);

  UpdateOrder note(OrderNote? note);

  UpdateOrder cancelReason(String? cancelReason);

  UpdateOrder gender(UserGender? gender);

  UpdateOrder genderPreference(UpdateOrderGenderPreferenceEnum? genderPreference);

  UpdateOrder itemCount(num? itemCount);

  UpdateOrder items(List<OrderItem>? items);

  UpdateOrder user(DriverUser? user);

  UpdateOrder driver(OrderDriver? driver);

  UpdateOrder merchant(OrderMerchant? merchant);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateOrder call({
    String? driverId,
    String? merchantId,
    OrderType? type,
    OrderStatus? status,
    num? distanceKm,
    num? tip,
    num? totalPrice,
    num? platformCommission,
    num? driverEarning,
    num? merchantCommission,
    String? couponId,
    String? couponCode,
    num? discountAmount,
    OrderNote? note,
    String? cancelReason,
    UserGender? gender,
    UpdateOrderGenderPreferenceEnum? genderPreference,
    num? itemCount,
    List<OrderItem>? items,
    DriverUser? user,
    OrderDriver? driver,
    OrderMerchant? merchant,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateOrder.copyWith(...)` or call `instanceOfUpdateOrder.copyWith.fieldName(value)` for a single field.
class _$UpdateOrderCWProxyImpl implements _$UpdateOrderCWProxy {
  const _$UpdateOrderCWProxyImpl(this._value);

  final UpdateOrder _value;

  @override
  UpdateOrder driverId(String? driverId) => call(driverId: driverId);

  @override
  UpdateOrder merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  UpdateOrder type(OrderType? type) => call(type: type);

  @override
  UpdateOrder status(OrderStatus? status) => call(status: status);

  @override
  UpdateOrder distanceKm(num? distanceKm) => call(distanceKm: distanceKm);

  @override
  UpdateOrder tip(num? tip) => call(tip: tip);

  @override
  UpdateOrder totalPrice(num? totalPrice) => call(totalPrice: totalPrice);

  @override
  UpdateOrder platformCommission(num? platformCommission) => call(platformCommission: platformCommission);

  @override
  UpdateOrder driverEarning(num? driverEarning) => call(driverEarning: driverEarning);

  @override
  UpdateOrder merchantCommission(num? merchantCommission) => call(merchantCommission: merchantCommission);

  @override
  UpdateOrder couponId(String? couponId) => call(couponId: couponId);

  @override
  UpdateOrder couponCode(String? couponCode) => call(couponCode: couponCode);

  @override
  UpdateOrder discountAmount(num? discountAmount) => call(discountAmount: discountAmount);

  @override
  UpdateOrder note(OrderNote? note) => call(note: note);

  @override
  UpdateOrder cancelReason(String? cancelReason) => call(cancelReason: cancelReason);

  @override
  UpdateOrder gender(UserGender? gender) => call(gender: gender);

  @override
  UpdateOrder genderPreference(UpdateOrderGenderPreferenceEnum? genderPreference) =>
      call(genderPreference: genderPreference);

  @override
  UpdateOrder itemCount(num? itemCount) => call(itemCount: itemCount);

  @override
  UpdateOrder items(List<OrderItem>? items) => call(items: items);

  @override
  UpdateOrder user(DriverUser? user) => call(user: user);

  @override
  UpdateOrder driver(OrderDriver? driver) => call(driver: driver);

  @override
  UpdateOrder merchant(OrderMerchant? merchant) => call(merchant: merchant);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateOrder call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? tip = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? platformCommission = const $CopyWithPlaceholder(),
    Object? driverEarning = const $CopyWithPlaceholder(),
    Object? merchantCommission = const $CopyWithPlaceholder(),
    Object? couponId = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
  }) {
    return UpdateOrder(
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
          : type as OrderType?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderStatus?,
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
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      genderPreference: genderPreference == const $CopyWithPlaceholder()
          ? _value.genderPreference
          // ignore: cast_nullable_to_non_nullable
          : genderPreference as UpdateOrderGenderPreferenceEnum?,
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

extension $UpdateOrderCopyWith on UpdateOrder {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateOrder.copyWith(...)` or `instanceOfUpdateOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateOrderCWProxy get copyWith => _$UpdateOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrder _$UpdateOrderFromJson(Map<String, dynamic> json) => $checkedCreate('UpdateOrder', json, ($checkedConvert) {
  final val = UpdateOrder(
    driverId: $checkedConvert('driverId', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    type: $checkedConvert('type', (v) => $enumDecodeNullable(_$OrderTypeEnumMap, v)),
    status: $checkedConvert('status', (v) => $enumDecodeNullable(_$OrderStatusEnumMap, v)),
    distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
    tip: $checkedConvert('tip', (v) => v as num?),
    totalPrice: $checkedConvert('totalPrice', (v) => v as num?),
    platformCommission: $checkedConvert('platformCommission', (v) => v as num?),
    driverEarning: $checkedConvert('driverEarning', (v) => v as num?),
    merchantCommission: $checkedConvert('merchantCommission', (v) => v as num?),
    couponId: $checkedConvert('couponId', (v) => v as String?),
    couponCode: $checkedConvert('couponCode', (v) => v as String?),
    discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
    note: $checkedConvert('note', (v) => v == null ? null : OrderNote.fromJson(v as Map<String, dynamic>)),
    cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
    gender: $checkedConvert('gender', (v) => $enumDecodeNullable(_$UserGenderEnumMap, v)),
    genderPreference: $checkedConvert(
      'genderPreference',
      (v) => $enumDecodeNullable(_$UpdateOrderGenderPreferenceEnumEnumMap, v),
    ),
    itemCount: $checkedConvert('itemCount', (v) => v as num?),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>?)?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>)).toList(),
    ),
    user: $checkedConvert('user', (v) => v == null ? null : DriverUser.fromJson(v as Map<String, dynamic>)),
    driver: $checkedConvert('driver', (v) => v == null ? null : OrderDriver.fromJson(v as Map<String, dynamic>)),
    merchant: $checkedConvert('merchant', (v) => v == null ? null : OrderMerchant.fromJson(v as Map<String, dynamic>)),
  );
  return val;
});

Map<String, dynamic> _$UpdateOrderToJson(UpdateOrder instance) => <String, dynamic>{
  'driverId': ?instance.driverId,
  'merchantId': ?instance.merchantId,
  'type': ?_$OrderTypeEnumMap[instance.type],
  'status': ?_$OrderStatusEnumMap[instance.status],
  'distanceKm': ?instance.distanceKm,
  'tip': ?instance.tip,
  'totalPrice': ?instance.totalPrice,
  'platformCommission': ?instance.platformCommission,
  'driverEarning': ?instance.driverEarning,
  'merchantCommission': ?instance.merchantCommission,
  'couponId': ?instance.couponId,
  'couponCode': ?instance.couponCode,
  'discountAmount': ?instance.discountAmount,
  'note': ?instance.note?.toJson(),
  'cancelReason': ?instance.cancelReason,
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'genderPreference': ?_$UpdateOrderGenderPreferenceEnumEnumMap[instance.genderPreference],
  'itemCount': ?instance.itemCount,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
  'user': ?instance.user?.toJson(),
  'driver': ?instance.driver?.toJson(),
  'merchant': ?instance.merchant?.toJson(),
};

const _$OrderTypeEnumMap = {OrderType.RIDE: 'RIDE', OrderType.DELIVERY: 'DELIVERY', OrderType.FOOD: 'FOOD'};

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

const _$UserGenderEnumMap = {UserGender.MALE: 'MALE', UserGender.FEMALE: 'FEMALE'};

const _$UpdateOrderGenderPreferenceEnumEnumMap = {
  UpdateOrderGenderPreferenceEnum.SAME: 'SAME',
  UpdateOrderGenderPreferenceEnum.ANY: 'ANY',
};
