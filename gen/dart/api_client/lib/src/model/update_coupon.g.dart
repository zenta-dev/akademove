// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCouponCWProxy {
  UpdateCoupon name(String? name);

  UpdateCoupon code(String? code);

  UpdateCoupon rules(CouponRules? rules);

  UpdateCoupon discountAmount(num? discountAmount);

  UpdateCoupon discountPercentage(num? discountPercentage);

  UpdateCoupon usageLimit(num? usageLimit);

  UpdateCoupon periodStart(DateTime? periodStart);

  UpdateCoupon periodEnd(DateTime? periodEnd);

  UpdateCoupon isActive(bool? isActive);

  UpdateCoupon merchantId(String? merchantId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCoupon call({
    String? name,
    String? code,
    CouponRules? rules,
    num? discountAmount,
    num? discountPercentage,
    num? usageLimit,
    DateTime? periodStart,
    DateTime? periodEnd,
    bool? isActive,
    String? merchantId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateCoupon.copyWith(...)` or call `instanceOfUpdateCoupon.copyWith.fieldName(value)` for a single field.
class _$UpdateCouponCWProxyImpl implements _$UpdateCouponCWProxy {
  const _$UpdateCouponCWProxyImpl(this._value);

  final UpdateCoupon _value;

  @override
  UpdateCoupon name(String? name) => call(name: name);

  @override
  UpdateCoupon code(String? code) => call(code: code);

  @override
  UpdateCoupon rules(CouponRules? rules) => call(rules: rules);

  @override
  UpdateCoupon discountAmount(num? discountAmount) => call(discountAmount: discountAmount);

  @override
  UpdateCoupon discountPercentage(num? discountPercentage) => call(discountPercentage: discountPercentage);

  @override
  UpdateCoupon usageLimit(num? usageLimit) => call(usageLimit: usageLimit);

  @override
  UpdateCoupon periodStart(DateTime? periodStart) => call(periodStart: periodStart);

  @override
  UpdateCoupon periodEnd(DateTime? periodEnd) => call(periodEnd: periodEnd);

  @override
  UpdateCoupon isActive(bool? isActive) => call(isActive: isActive);

  @override
  UpdateCoupon merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCoupon call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? rules = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? discountPercentage = const $CopyWithPlaceholder(),
    Object? usageLimit = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
  }) {
    return UpdateCoupon(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      rules: rules == const $CopyWithPlaceholder()
          ? _value.rules
          // ignore: cast_nullable_to_non_nullable
          : rules as CouponRules?,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num?,
      discountPercentage: discountPercentage == const $CopyWithPlaceholder()
          ? _value.discountPercentage
          // ignore: cast_nullable_to_non_nullable
          : discountPercentage as num?,
      usageLimit: usageLimit == const $CopyWithPlaceholder()
          ? _value.usageLimit
          // ignore: cast_nullable_to_non_nullable
          : usageLimit as num?,
      periodStart: periodStart == const $CopyWithPlaceholder()
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime?,
      periodEnd: periodEnd == const $CopyWithPlaceholder()
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
    );
  }
}

extension $UpdateCouponCopyWith on UpdateCoupon {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateCoupon.copyWith(...)` or `instanceOfUpdateCoupon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCouponCWProxy get copyWith => _$UpdateCouponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCoupon _$UpdateCouponFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateCoupon', json, ($checkedConvert) {
      final val = UpdateCoupon(
        name: $checkedConvert('name', (v) => v as String?),
        code: $checkedConvert('code', (v) => v as String?),
        rules: $checkedConvert('rules', (v) => v == null ? null : CouponRules.fromJson(v as Map<String, dynamic>)),
        discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
        discountPercentage: $checkedConvert('discountPercentage', (v) => v as num?),
        usageLimit: $checkedConvert('usageLimit', (v) => v as num?),
        periodStart: $checkedConvert('periodStart', (v) => v == null ? null : DateTime.parse(v as String)),
        periodEnd: $checkedConvert('periodEnd', (v) => v == null ? null : DateTime.parse(v as String)),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateCouponToJson(UpdateCoupon instance) => <String, dynamic>{
  'name': ?instance.name,
  'code': ?instance.code,
  'rules': ?instance.rules?.toJson(),
  'discountAmount': ?instance.discountAmount,
  'discountPercentage': ?instance.discountPercentage,
  'usageLimit': ?instance.usageLimit,
  'periodStart': ?instance.periodStart?.toIso8601String(),
  'periodEnd': ?instance.periodEnd?.toIso8601String(),
  'isActive': ?instance.isActive,
  'merchantId': ?instance.merchantId,
};
