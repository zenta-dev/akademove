// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_general_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponGeneralRulesCWProxy {
  CouponGeneralRules type(CouponGeneralRulesTypeEnum? type);

  CouponGeneralRules minOrderAmount(num? minOrderAmount);

  CouponGeneralRules maxDiscountAmount(num? maxDiscountAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponGeneralRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponGeneralRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponGeneralRules call({
    CouponGeneralRulesTypeEnum? type,
    num? minOrderAmount,
    num? maxDiscountAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponGeneralRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponGeneralRules.copyWith.fieldName(...)`
class _$CouponGeneralRulesCWProxyImpl implements _$CouponGeneralRulesCWProxy {
  const _$CouponGeneralRulesCWProxyImpl(this._value);

  final CouponGeneralRules _value;

  @override
  CouponGeneralRules type(CouponGeneralRulesTypeEnum? type) => this(type: type);

  @override
  CouponGeneralRules minOrderAmount(num? minOrderAmount) =>
      this(minOrderAmount: minOrderAmount);

  @override
  CouponGeneralRules maxDiscountAmount(num? maxDiscountAmount) =>
      this(maxDiscountAmount: maxDiscountAmount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponGeneralRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponGeneralRules(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponGeneralRules call({
    Object? type = const $CopyWithPlaceholder(),
    Object? minOrderAmount = const $CopyWithPlaceholder(),
    Object? maxDiscountAmount = const $CopyWithPlaceholder(),
  }) {
    return CouponGeneralRules(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as CouponGeneralRulesTypeEnum?,
      minOrderAmount: minOrderAmount == const $CopyWithPlaceholder()
          ? _value.minOrderAmount
          // ignore: cast_nullable_to_non_nullable
          : minOrderAmount as num?,
      maxDiscountAmount: maxDiscountAmount == const $CopyWithPlaceholder()
          ? _value.maxDiscountAmount
          // ignore: cast_nullable_to_non_nullable
          : maxDiscountAmount as num?,
    );
  }
}

extension $CouponGeneralRulesCopyWith on CouponGeneralRules {
  /// Returns a callable class that can be used as follows: `instanceOfCouponGeneralRules.copyWith(...)` or like so:`instanceOfCouponGeneralRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponGeneralRulesCWProxy get copyWith =>
      _$CouponGeneralRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponGeneralRules _$CouponGeneralRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponGeneralRules', json, ($checkedConvert) {
      final val = CouponGeneralRules(
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$CouponGeneralRulesTypeEnumEnumMap, v),
        ),
        minOrderAmount: $checkedConvert('minOrderAmount', (v) => v as num?),
        maxDiscountAmount: $checkedConvert(
          'maxDiscountAmount',
          (v) => v as num?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$CouponGeneralRulesToJson(CouponGeneralRules instance) =>
    <String, dynamic>{
      'type': ?_$CouponGeneralRulesTypeEnumEnumMap[instance.type],
      'minOrderAmount': ?instance.minOrderAmount,
      'maxDiscountAmount': ?instance.maxDiscountAmount,
    };

const _$CouponGeneralRulesTypeEnumEnumMap = {
  CouponGeneralRulesTypeEnum.percentage: 'percentage',
  CouponGeneralRulesTypeEnum.fixed: 'fixed',
};
