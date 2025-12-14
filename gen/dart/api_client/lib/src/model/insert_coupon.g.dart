// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertCouponCWProxy {
  InsertCoupon name(String name);

  InsertCoupon code(String code);

  InsertCoupon couponType(CouponType? couponType);

  InsertCoupon rules(CouponRules rules);

  InsertCoupon discountAmount(num? discountAmount);

  InsertCoupon discountPercentage(num? discountPercentage);

  InsertCoupon usageLimit(num usageLimit);

  InsertCoupon periodStart(DateTime periodStart);

  InsertCoupon periodEnd(DateTime periodEnd);

  InsertCoupon isActive(bool isActive);

  InsertCoupon merchantId(String? merchantId);

  InsertCoupon serviceTypes(List<OrderType>? serviceTypes);

  InsertCoupon eventName(String? eventName);

  InsertCoupon eventDescription(String? eventDescription);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertCoupon call({
    String name,
    String code,
    CouponType? couponType,
    CouponRules rules,
    num? discountAmount,
    num? discountPercentage,
    num usageLimit,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
    String? merchantId,
    List<OrderType>? serviceTypes,
    String? eventName,
    String? eventDescription,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertCoupon.copyWith(...)` or call `instanceOfInsertCoupon.copyWith.fieldName(value)` for a single field.
class _$InsertCouponCWProxyImpl implements _$InsertCouponCWProxy {
  const _$InsertCouponCWProxyImpl(this._value);

  final InsertCoupon _value;

  @override
  InsertCoupon name(String name) => call(name: name);

  @override
  InsertCoupon code(String code) => call(code: code);

  @override
  InsertCoupon couponType(CouponType? couponType) =>
      call(couponType: couponType);

  @override
  InsertCoupon rules(CouponRules rules) => call(rules: rules);

  @override
  InsertCoupon discountAmount(num? discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  InsertCoupon discountPercentage(num? discountPercentage) =>
      call(discountPercentage: discountPercentage);

  @override
  InsertCoupon usageLimit(num usageLimit) => call(usageLimit: usageLimit);

  @override
  InsertCoupon periodStart(DateTime periodStart) =>
      call(periodStart: periodStart);

  @override
  InsertCoupon periodEnd(DateTime periodEnd) => call(periodEnd: periodEnd);

  @override
  InsertCoupon isActive(bool isActive) => call(isActive: isActive);

  @override
  InsertCoupon merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  InsertCoupon serviceTypes(List<OrderType>? serviceTypes) =>
      call(serviceTypes: serviceTypes);

  @override
  InsertCoupon eventName(String? eventName) => call(eventName: eventName);

  @override
  InsertCoupon eventDescription(String? eventDescription) =>
      call(eventDescription: eventDescription);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertCoupon call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? couponType = const $CopyWithPlaceholder(),
    Object? rules = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? discountPercentage = const $CopyWithPlaceholder(),
    Object? usageLimit = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? serviceTypes = const $CopyWithPlaceholder(),
    Object? eventName = const $CopyWithPlaceholder(),
    Object? eventDescription = const $CopyWithPlaceholder(),
  }) {
    return InsertCoupon(
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
    );
  }
}

extension $InsertCouponCopyWith on InsertCoupon {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertCoupon.copyWith(...)` or `instanceOfInsertCoupon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertCouponCWProxy get copyWith => _$InsertCouponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertCoupon _$InsertCouponFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertCoupon', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'code',
      'rules',
      'usageLimit',
      'periodStart',
      'periodEnd',
      'isActive',
    ],
  );
  final val = InsertCoupon(
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
  );
  return val;
});

Map<String, dynamic> _$InsertCouponToJson(InsertCoupon instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'couponType': ?_$CouponTypeEnumMap[instance.couponType],
      'rules': instance.rules.toJson(),
      'discountAmount': ?instance.discountAmount,
      'discountPercentage': ?instance.discountPercentage,
      'usageLimit': instance.usageLimit,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'isActive': instance.isActive,
      'merchantId': ?instance.merchantId,
      'serviceTypes': ?instance.serviceTypes
          ?.map((e) => _$OrderTypeEnumMap[e]!)
          .toList(),
      'eventName': ?instance.eventName,
      'eventDescription': ?instance.eventDescription,
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
