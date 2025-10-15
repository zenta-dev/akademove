// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponUpdateRequestCWProxy {
  CouponUpdateRequest name(String? name);

  CouponUpdateRequest code(String? code);

  CouponUpdateRequest rules(CouponCreateRequestRules? rules);

  CouponUpdateRequest discountAmount(num? discountAmount);

  CouponUpdateRequest discountPercentage(num? discountPercentage);

  CouponUpdateRequest usageLimit(num? usageLimit);

  CouponUpdateRequest periodStart(DateTime? periodStart);

  CouponUpdateRequest periodEnd(DateTime? periodEnd);

  CouponUpdateRequest isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponUpdateRequest call({
    String? name,
    String? code,
    CouponCreateRequestRules? rules,
    num? discountAmount,
    num? discountPercentage,
    num? usageLimit,
    DateTime? periodStart,
    DateTime? periodEnd,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponUpdateRequest.copyWith.fieldName(...)`
class _$CouponUpdateRequestCWProxyImpl implements _$CouponUpdateRequestCWProxy {
  const _$CouponUpdateRequestCWProxyImpl(this._value);

  final CouponUpdateRequest _value;

  @override
  CouponUpdateRequest name(String? name) => this(name: name);

  @override
  CouponUpdateRequest code(String? code) => this(code: code);

  @override
  CouponUpdateRequest rules(CouponCreateRequestRules? rules) =>
      this(rules: rules);

  @override
  CouponUpdateRequest discountAmount(num? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  CouponUpdateRequest discountPercentage(num? discountPercentage) =>
      this(discountPercentage: discountPercentage);

  @override
  CouponUpdateRequest usageLimit(num? usageLimit) =>
      this(usageLimit: usageLimit);

  @override
  CouponUpdateRequest periodStart(DateTime? periodStart) =>
      this(periodStart: periodStart);

  @override
  CouponUpdateRequest periodEnd(DateTime? periodEnd) =>
      this(periodEnd: periodEnd);

  @override
  CouponUpdateRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponUpdateRequest call({
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
    return CouponUpdateRequest(
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
          : rules as CouponCreateRequestRules?,
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

extension $CouponUpdateRequestCopyWith on CouponUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCouponUpdateRequest.copyWith(...)` or like so:`instanceOfCouponUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponUpdateRequestCWProxy get copyWith =>
      _$CouponUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponUpdateRequest _$CouponUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponUpdateRequest', json, ($checkedConvert) {
      final val = CouponUpdateRequest(
        name: $checkedConvert('name', (v) => v as String?),
        code: $checkedConvert('code', (v) => v as String?),
        rules: $checkedConvert(
          'rules',
          (v) => v == null
              ? null
              : CouponCreateRequestRules.fromJson(v as Map<String, dynamic>),
        ),
        discountAmount: $checkedConvert('discountAmount', (v) => v as num?),
        discountPercentage: $checkedConvert(
          'discountPercentage',
          (v) => v as num?,
        ),
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

Map<String, dynamic> _$CouponUpdateRequestToJson(
  CouponUpdateRequest instance,
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
