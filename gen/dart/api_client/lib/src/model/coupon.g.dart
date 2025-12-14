// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCWProxy {
  Coupon id(String id);

  Coupon name(String name);

  Coupon code(String code);

  Coupon couponType(CouponType? couponType);

  Coupon rules(CouponRules rules);

  Coupon discountAmount(num? discountAmount);

  Coupon discountPercentage(num? discountPercentage);

  Coupon usageLimit(num usageLimit);

  Coupon usedCount(num usedCount);

  Coupon periodStart(DateTime periodStart);

  Coupon periodEnd(DateTime periodEnd);

  Coupon isActive(bool isActive);

  Coupon merchantId(String? merchantId);

  Coupon serviceTypes(List<OrderType>? serviceTypes);

  Coupon eventName(String? eventName);

  Coupon eventDescription(String? eventDescription);

  Coupon createdById(String createdById);

  Coupon createdAt(DateTime createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Coupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Coupon(...).copyWith(id: 12, name: "My name")
  /// ```
  Coupon call({
    String id,
    String name,
    String code,
    CouponType? couponType,
    CouponRules rules,
    num? discountAmount,
    num? discountPercentage,
    num usageLimit,
    num usedCount,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
    String? merchantId,
    List<OrderType>? serviceTypes,
    String? eventName,
    String? eventDescription,
    String createdById,
    DateTime createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCoupon.copyWith(...)` or call `instanceOfCoupon.copyWith.fieldName(value)` for a single field.
class _$CouponCWProxyImpl implements _$CouponCWProxy {
  const _$CouponCWProxyImpl(this._value);

  final Coupon _value;

  @override
  Coupon id(String id) => call(id: id);

  @override
  Coupon name(String name) => call(name: name);

  @override
  Coupon code(String code) => call(code: code);

  @override
  Coupon couponType(CouponType? couponType) => call(couponType: couponType);

  @override
  Coupon rules(CouponRules rules) => call(rules: rules);

  @override
  Coupon discountAmount(num? discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  Coupon discountPercentage(num? discountPercentage) =>
      call(discountPercentage: discountPercentage);

  @override
  Coupon usageLimit(num usageLimit) => call(usageLimit: usageLimit);

  @override
  Coupon usedCount(num usedCount) => call(usedCount: usedCount);

  @override
  Coupon periodStart(DateTime periodStart) => call(periodStart: periodStart);

  @override
  Coupon periodEnd(DateTime periodEnd) => call(periodEnd: periodEnd);

  @override
  Coupon isActive(bool isActive) => call(isActive: isActive);

  @override
  Coupon merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  Coupon serviceTypes(List<OrderType>? serviceTypes) =>
      call(serviceTypes: serviceTypes);

  @override
  Coupon eventName(String? eventName) => call(eventName: eventName);

  @override
  Coupon eventDescription(String? eventDescription) =>
      call(eventDescription: eventDescription);

  @override
  Coupon createdById(String createdById) => call(createdById: createdById);

  @override
  Coupon createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Coupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Coupon(...).copyWith(id: 12, name: "My name")
  /// ```
  Coupon call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? couponType = const $CopyWithPlaceholder(),
    Object? rules = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? discountPercentage = const $CopyWithPlaceholder(),
    Object? usageLimit = const $CopyWithPlaceholder(),
    Object? usedCount = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? serviceTypes = const $CopyWithPlaceholder(),
    Object? eventName = const $CopyWithPlaceholder(),
    Object? eventDescription = const $CopyWithPlaceholder(),
    Object? createdById = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return Coupon(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      couponType: couponType == const $CopyWithPlaceholder()
          ? _value.couponType
          // ignore: cast_nullable_to_non_nullable
          : couponType as CouponType?,
      rules: rules == const $CopyWithPlaceholder() || rules == null
          ? _value.rules
          // ignore: cast_nullable_to_non_nullable
          : rules as CouponRules,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num?,
      discountPercentage: discountPercentage == const $CopyWithPlaceholder()
          ? _value.discountPercentage
          // ignore: cast_nullable_to_non_nullable
          : discountPercentage as num?,
      usageLimit:
          usageLimit == const $CopyWithPlaceholder() || usageLimit == null
          ? _value.usageLimit
          // ignore: cast_nullable_to_non_nullable
          : usageLimit as num,
      usedCount: usedCount == const $CopyWithPlaceholder() || usedCount == null
          ? _value.usedCount
          // ignore: cast_nullable_to_non_nullable
          : usedCount as num,
      periodStart:
          periodStart == const $CopyWithPlaceholder() || periodStart == null
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime,
      periodEnd: periodEnd == const $CopyWithPlaceholder() || periodEnd == null
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      serviceTypes: serviceTypes == const $CopyWithPlaceholder()
          ? _value.serviceTypes
          // ignore: cast_nullable_to_non_nullable
          : serviceTypes as List<OrderType>?,
      eventName: eventName == const $CopyWithPlaceholder()
          ? _value.eventName
          // ignore: cast_nullable_to_non_nullable
          : eventName as String?,
      eventDescription: eventDescription == const $CopyWithPlaceholder()
          ? _value.eventDescription
          // ignore: cast_nullable_to_non_nullable
          : eventDescription as String?,
      createdById:
          createdById == const $CopyWithPlaceholder() || createdById == null
          ? _value.createdById
          // ignore: cast_nullable_to_non_nullable
          : createdById as String,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $CouponCopyWith on Coupon {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCoupon.copyWith(...)` or `instanceOfCoupon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCWProxy get copyWith => _$CouponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Coupon', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'code',
      'rules',
      'usageLimit',
      'usedCount',
      'periodStart',
      'periodEnd',
      'isActive',
      'createdById',
      'createdAt',
    ],
  );
  final val = Coupon(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    couponType: $checkedConvert(
      'couponType',
      (v) => $enumDecodeNullable(_$CouponTypeEnumMap, v) ?? CouponType.GENERAL,
    ),
    rules: $checkedConvert(
      'rules',
      (v) => CouponRules.fromJson(v as Map<String, dynamic>),
    ),
    discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
    discountPercentage: $checkedConvert('discountPercentage', (v) => v as num?),
    usageLimit: $checkedConvert('usageLimit', (v) => v as num),
    usedCount: $checkedConvert('usedCount', (v) => v as num),
    periodStart: $checkedConvert(
      'periodStart',
      (v) => DateTime.parse(v as String),
    ),
    periodEnd: $checkedConvert('periodEnd', (v) => DateTime.parse(v as String)),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    serviceTypes: $checkedConvert(
      'serviceTypes',
      (v) => (v as List<dynamic>?)
          ?.map((e) => $enumDecode(_$OrderTypeEnumMap, e))
          .toList(),
    ),
    eventName: $checkedConvert('eventName', (v) => v as String?),
    eventDescription: $checkedConvert('eventDescription', (v) => v as String?),
    createdById: $checkedConvert('createdById', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'couponType': ?_$CouponTypeEnumMap[instance.couponType],
  'rules': instance.rules.toJson(),
  'discountAmount': ?instance.discountAmount,
  'discountPercentage': ?instance.discountPercentage,
  'usageLimit': instance.usageLimit,
  'usedCount': instance.usedCount,
  'periodStart': instance.periodStart.toIso8601String(),
  'periodEnd': instance.periodEnd.toIso8601String(),
  'isActive': instance.isActive,
  'merchantId': ?instance.merchantId,
  'serviceTypes': ?instance.serviceTypes
      ?.map((e) => _$OrderTypeEnumMap[e]!)
      .toList(),
  'eventName': ?instance.eventName,
  'eventDescription': ?instance.eventDescription,
  'createdById': instance.createdById,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$CouponTypeEnumMap = {
  CouponType.GENERAL: 'GENERAL',
  CouponType.EVENT: 'EVENT',
  CouponType.MERCHANT: 'MERCHANT',
  CouponType.FIRST_ORDER: 'FIRST_ORDER',
};

const _$OrderTypeEnumMap = {
  OrderType.RIDE: 'RIDE',
  OrderType.DELIVERY: 'DELIVERY',
  OrderType.FOOD: 'FOOD',
};
