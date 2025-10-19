// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_coupon_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertCouponRequestCWProxy {
  InsertCouponRequest name(String name);

  InsertCouponRequest code(String code);

  InsertCouponRequest rules(CouponRules rules);

  InsertCouponRequest discountAmount(num? discountAmount);

  InsertCouponRequest discountPercentage(num? discountPercentage);

  InsertCouponRequest usageLimit(num usageLimit);

  InsertCouponRequest periodStart(DateTime periodStart);

  InsertCouponRequest periodEnd(DateTime periodEnd);

  InsertCouponRequest isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertCouponRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertCouponRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertCouponRequest call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertCouponRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertCouponRequest.copyWith.fieldName(...)`
class _$InsertCouponRequestCWProxyImpl implements _$InsertCouponRequestCWProxy {
  const _$InsertCouponRequestCWProxyImpl(this._value);

  final InsertCouponRequest _value;

  @override
  InsertCouponRequest name(String name) => this(name: name);

  @override
  InsertCouponRequest code(String code) => this(code: code);

  @override
  InsertCouponRequest rules(CouponRules rules) => this(rules: rules);

  @override
  InsertCouponRequest discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  InsertCouponRequest discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  InsertCouponRequest usageLimit(num usageLimit) =>
      this(usageLimit: usageLimit);

  @override
  InsertCouponRequest periodStart(DateTime periodStart) =>
      this(periodStart: periodStart);

  @override
  InsertCouponRequest periodEnd(DateTime periodEnd) =>
      this(periodEnd: periodEnd);

  @override
  InsertCouponRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertCouponRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertCouponRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertCouponRequest call({
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
    return InsertCouponRequest(
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

extension $InsertCouponRequestCopyWith on InsertCouponRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertCouponRequest.copyWith(...)` or like so:`instanceOfInsertCouponRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertCouponRequestCWProxy get copyWith =>
      _$InsertCouponRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertCouponRequest _$InsertCouponRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertCouponRequest', json, ($checkedConvert) {
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
  final val = InsertCouponRequest(
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

Map<String, dynamic> _$InsertCouponRequestToJson(
  InsertCouponRequest instance,
) => <String, dynamic>{
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
