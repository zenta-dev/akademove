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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCoupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCoupon(...).copyWith(id: 12, name: "My name")
  /// ````
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
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateCoupon.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateCoupon.copyWith.fieldName(...)`
class _$UpdateCouponCWProxyImpl implements _$UpdateCouponCWProxy {
  const _$UpdateCouponCWProxyImpl(this._value);

  final UpdateCoupon _value;

  @override
  UpdateCoupon name(String? name) => this(name: name);

  @override
  UpdateCoupon code(String? code) => this(code: code);

  @override
  UpdateCoupon rules(CouponRules? rules) => this(rules: rules);

  @override
  UpdateCoupon discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  UpdateCoupon discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  UpdateCoupon usageLimit(num? usageLimit) => this(usageLimit: usageLimit);

  @override
  UpdateCoupon periodStart(DateTime? periodStart) =>
      this(periodStart: periodStart);

  @override
  UpdateCoupon periodEnd(DateTime? periodEnd) => this(periodEnd: periodEnd);

  @override
  UpdateCoupon isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCoupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCoupon(...).copyWith(id: 12, name: "My name")
  /// ````
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
    );
  }
}

extension $UpdateCouponCopyWith on UpdateCoupon {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateCoupon.copyWith(...)` or like so:`instanceOfUpdateCoupon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCouponCWProxy get copyWith => _$UpdateCouponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCoupon _$UpdateCouponFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateCoupon', json, ($checkedConvert) {
  final val = UpdateCoupon(
    name: $checkedConvert('name', (v) => v as String?),
    code: $checkedConvert('code', (v) => v as String?),
    rules: $checkedConvert(
      'rules',
      (v) => v == null ? null : CouponRules.fromJson(v as Map<String, dynamic>),
    ),
    discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
    discountPercentage: $checkedConvert('discountPercentage', (v) => v as num?),
    usageLimit: $checkedConvert('usageLimit', (v) => v as num?),
    periodStart: $checkedConvert(
      'periodStart',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    periodEnd: $checkedConvert(
      'periodEnd',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$UpdateCouponToJson(UpdateCoupon instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'code': ?instance.code,
      'rules': ?instance.rules?.toJson(),
      'discountAmount': ?instance.discountAmount,
      'discountPercentage': ?instance.discountPercentage,
      'usageLimit': ?instance.usageLimit,
      'periodStart': ?instance.periodStart?.toIso8601String(),
      'periodEnd': ?instance.periodEnd?.toIso8601String(),
      'isActive': ?instance.isActive,
    };
