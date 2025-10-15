// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreateRequestCWProxy {
  CouponCreateRequest name(String name);

  CouponCreateRequest code(String code);

  CouponCreateRequest rules(CouponCreateRequestRules rules);

  CouponCreateRequest discountAmount(num? discountAmount);

  CouponCreateRequest discountPercentage(num? discountPercentage);

  CouponCreateRequest usageLimit(num usageLimit);

  CouponCreateRequest periodStart(DateTime periodStart);

  CouponCreateRequest periodEnd(DateTime periodEnd);

  CouponCreateRequest isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequest call({
    String name,
    String code,
    CouponCreateRequestRules rules,
    num? discountAmount,
    num? discountPercentage,
    num usageLimit,
    DateTime periodStart,
    DateTime periodEnd,
    bool isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreateRequest.copyWith.fieldName(...)`
class _$CouponCreateRequestCWProxyImpl implements _$CouponCreateRequestCWProxy {
  const _$CouponCreateRequestCWProxyImpl(this._value);

  final CouponCreateRequest _value;

  @override
  CouponCreateRequest name(String name) => this(name: name);

  @override
  CouponCreateRequest code(String code) => this(code: code);

  @override
  CouponCreateRequest rules(CouponCreateRequestRules rules) =>
      this(rules: rules);

  @override
  CouponCreateRequest discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  CouponCreateRequest discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  CouponCreateRequest usageLimit(num usageLimit) =>
      this(usageLimit: usageLimit);

  @override
  CouponCreateRequest periodStart(DateTime periodStart) =>
      this(periodStart: periodStart);

  @override
  CouponCreateRequest periodEnd(DateTime periodEnd) =>
      this(periodEnd: periodEnd);

  @override
  CouponCreateRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequest call({
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
    return CouponCreateRequest(
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
          : rules as CouponCreateRequestRules,
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

extension $CouponCreateRequestCopyWith on CouponCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreateRequest.copyWith(...)` or like so:`instanceOfCouponCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreateRequestCWProxy get copyWith =>
      _$CouponCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreateRequest _$CouponCreateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreateRequest', json, ($checkedConvert) {
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
  final val = CouponCreateRequest(
    name: $checkedConvert('name', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    rules: $checkedConvert(
      'rules',
      (v) => CouponCreateRequestRules.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$CouponCreateRequestToJson(
  CouponCreateRequest instance,
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
