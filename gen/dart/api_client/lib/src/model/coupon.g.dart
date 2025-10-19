// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCWProxy {
  Coupon id(String id);

  Coupon name(String name);

  Coupon code(String code);

  Coupon rules(CouponRules rules);

  Coupon discountAmount(num? discountAmount);

  Coupon discountPercentage(num? discountPercentage);

  Coupon usageLimit(num usageLimit);

  Coupon usedCount(num usedCount);

  Coupon periodStart(DateTime periodStart);

  Coupon periodEnd(DateTime periodEnd);

  Coupon isActive(bool isActive);

  Coupon createdById(String createdById);

  Coupon createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coupon(...).copyWith(id: 12, name: "My name")
  /// ````
  Coupon call({
    String id,
    String name,
    String code,
    CouponRules rules,
    num? discountAmount,
    num? discountPercentage,
    num usageLimit,
    num usedCount,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
    String createdById,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCoupon.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCoupon.copyWith.fieldName(...)`
class _$CouponCWProxyImpl implements _$CouponCWProxy {
  const _$CouponCWProxyImpl(this._value);

  final Coupon _value;

  @override
  Coupon id(String id) => this(id: id);

  @override
  Coupon name(String name) => this(name: name);

  @override
  Coupon code(String code) => this(code: code);

  @override
  Coupon rules(CouponRules rules) => this(rules: rules);

  @override
  Coupon discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  Coupon discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  Coupon usageLimit(num usageLimit) => this(usageLimit: usageLimit);

  @override
  Coupon usedCount(num usedCount) => this(usedCount: usedCount);

  @override
  Coupon periodStart(DateTime periodStart) => this(periodStart: periodStart);

  @override
  Coupon periodEnd(DateTime periodEnd) => this(periodEnd: periodEnd);

  @override
  Coupon isActive(bool isActive) => this(isActive: isActive);

  @override
  Coupon createdById(String createdById) => this(createdById: createdById);

  @override
  Coupon createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coupon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coupon(...).copyWith(id: 12, name: "My name")
  /// ````
  Coupon call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? rules = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? discountPercentage = const $CopyWithPlaceholder(),
    Object? usageLimit = const $CopyWithPlaceholder(),
    Object? usedCount = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? createdById = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return Coupon(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      usedCount: usedCount == const $CopyWithPlaceholder()
          ? _value.usedCount
          // ignore: cast_nullable_to_non_nullable
          : usedCount as num,
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
      createdById: createdById == const $CopyWithPlaceholder()
          ? _value.createdById
          // ignore: cast_nullable_to_non_nullable
          : createdById as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $CouponCopyWith on Coupon {
  /// Returns a callable class that can be used as follows: `instanceOfCoupon.copyWith(...)` or like so:`instanceOfCoupon.copyWith.fieldName(...)`.
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
    createdById: $checkedConvert('createdById', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'rules': instance.rules.toJson(),
  'discountAmount': ?instance.discountAmount,
  'discountPercentage': ?instance.discountPercentage,
  'usageLimit': instance.usageLimit,
  'usedCount': instance.usedCount,
  'periodStart': instance.periodStart.toIso8601String(),
  'periodEnd': instance.periodEnd.toIso8601String(),
  'isActive': instance.isActive,
  'createdById': instance.createdById,
  'createdAt': instance.createdAt.toIso8601String(),
};
