// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertCouponCWProxy {
  InsertCoupon name(String name);

  InsertCoupon code(String code);

  InsertCoupon rules(CouponRules rules);

  InsertCoupon discountAmount(num? discountAmount);

  InsertCoupon discountPercentage(num? discountPercentage);

  InsertCoupon usageLimit(num usageLimit);

  InsertCoupon periodStart(DateTime periodStart);

  InsertCoupon periodEnd(DateTime periodEnd);

  InsertCoupon isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertCoupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertCoupon(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertCoupon call({
    String name,
    String code,
    CouponRules rules,
    num? discountAmount,
    num? discountPercentage,
    num usageLimit,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertCoupon.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertCoupon.copyWith.fieldName(...)`
class _$InsertCouponCWProxyImpl implements _$InsertCouponCWProxy {
  const _$InsertCouponCWProxyImpl(this._value);

  final InsertCoupon _value;

  @override
  InsertCoupon name(String name) => this(name: name);

  @override
  InsertCoupon code(String code) => this(code: code);

  @override
  InsertCoupon rules(CouponRules rules) => this(rules: rules);

  @override
  InsertCoupon discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  InsertCoupon discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  InsertCoupon usageLimit(num usageLimit) => this(usageLimit: usageLimit);

  @override
  InsertCoupon periodStart(DateTime periodStart) =>
      this(periodStart: periodStart);

  @override
  InsertCoupon periodEnd(DateTime periodEnd) => this(periodEnd: periodEnd);

  @override
  InsertCoupon isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertCoupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertCoupon(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertCoupon call({
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
    return InsertCoupon(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      rules: rules == const $CopyWithPlaceholder()
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
      usageLimit: usageLimit == const $CopyWithPlaceholder()
          ? _value.usageLimit
          // ignore: cast_nullable_to_non_nullable
          : usageLimit as num,
      periodStart: periodStart == const $CopyWithPlaceholder()
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime,
      periodEnd: periodEnd == const $CopyWithPlaceholder()
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $InsertCouponCopyWith on InsertCoupon {
  /// Returns a callable class that can be used as follows: `instanceOfInsertCoupon.copyWith(...)` or like so:`instanceOfInsertCoupon.copyWith.fieldName(...)`.
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
  );
  return val;
});

Map<String, dynamic> _$InsertCouponToJson(InsertCoupon instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'rules': instance.rules.toJson(),
      'discountAmount': ?instance.discountAmount,
      'discountPercentage': ?instance.discountPercentage,
      'usageLimit': instance.usageLimit,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'isActive': instance.isActive,
    };
