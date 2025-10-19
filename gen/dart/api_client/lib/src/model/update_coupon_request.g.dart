// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_coupon_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCouponRequestCWProxy {
  UpdateCouponRequest name(String? name);

  UpdateCouponRequest code(String? code);

  UpdateCouponRequest rules(CouponRules? rules);

  UpdateCouponRequest discountAmount(num? discountAmount);

  UpdateCouponRequest discountPercentage(num? discountPercentage);

  UpdateCouponRequest usageLimit(num? usageLimit);

  UpdateCouponRequest periodStart(DateTime? periodStart);

  UpdateCouponRequest periodEnd(DateTime? periodEnd);

  UpdateCouponRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCouponRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCouponRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCouponRequest call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateCouponRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateCouponRequest.copyWith.fieldName(...)`
class _$UpdateCouponRequestCWProxyImpl implements _$UpdateCouponRequestCWProxy {
  const _$UpdateCouponRequestCWProxyImpl(this._value);

  final UpdateCouponRequest _value;

  @override
  UpdateCouponRequest name(String? name) => this(name: name);

  @override
  UpdateCouponRequest code(String? code) => this(code: code);

  @override
  UpdateCouponRequest rules(CouponRules? rules) => this(rules: rules);

  @override
  UpdateCouponRequest discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  UpdateCouponRequest discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  UpdateCouponRequest usageLimit(num? usageLimit) =>
      this(usageLimit: usageLimit);

  @override
  UpdateCouponRequest periodStart(DateTime? periodStart) =>
      this(periodStart: periodStart);

  @override
  UpdateCouponRequest periodEnd(DateTime? periodEnd) =>
      this(periodEnd: periodEnd);

  @override
  UpdateCouponRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCouponRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCouponRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCouponRequest call({
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
    return UpdateCouponRequest(
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

extension $UpdateCouponRequestCopyWith on UpdateCouponRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateCouponRequest.copyWith(...)` or like so:`instanceOfUpdateCouponRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCouponRequestCWProxy get copyWith =>
      _$UpdateCouponRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCouponRequest _$UpdateCouponRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateCouponRequest', json, ($checkedConvert) {
  final val = UpdateCouponRequest(
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

Map<String, dynamic> _$UpdateCouponRequestToJson(
  UpdateCouponRequest instance,
) => <String, dynamic>{
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
