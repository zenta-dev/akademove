// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_general.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreateRequestRulesGeneralCWProxy {
  CouponCreateRequestRulesGeneral type(
    CouponCreateRequestRulesGeneralTypeEnum? type,
  );

  CouponCreateRequestRulesGeneral minOrderAmount(num? minOrderAmount);

  CouponCreateRequestRulesGeneral maxDiscountAmount(num? maxDiscountAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesGeneral(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesGeneral(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesGeneral call({
    CouponCreateRequestRulesGeneralTypeEnum? type,
    num? minOrderAmount,
    num? maxDiscountAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreateRequestRulesGeneral.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreateRequestRulesGeneral.copyWith.fieldName(...)`
class _$CouponCreateRequestRulesGeneralCWProxyImpl
    implements _$CouponCreateRequestRulesGeneralCWProxy {
  const _$CouponCreateRequestRulesGeneralCWProxyImpl(this._value);

  final CouponCreateRequestRulesGeneral _value;

  @override
  CouponCreateRequestRulesGeneral type(
    CouponCreateRequestRulesGeneralTypeEnum? type,
  ) => this(type: type);

  @override
  CouponCreateRequestRulesGeneral minOrderAmount(num? minOrderAmount) =>
      this(minOrderAmount: minOrderAmount);

  @override
  CouponCreateRequestRulesGeneral maxDiscountAmount(num? maxDiscountAmount) =>
      this(maxDiscountAmount: maxDiscountAmount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesGeneral(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesGeneral(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesGeneral call({
    Object? type = const $CopyWithPlaceholder(),
    Object? minOrderAmount = const $CopyWithPlaceholder(),
    Object? maxDiscountAmount = const $CopyWithPlaceholder(),
  }) {
    return CouponCreateRequestRulesGeneral(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as CouponCreateRequestRulesGeneralTypeEnum?,
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

extension $CouponCreateRequestRulesGeneralCopyWith
    on CouponCreateRequestRulesGeneral {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreateRequestRulesGeneral.copyWith(...)` or like so:`instanceOfCouponCreateRequestRulesGeneral.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreateRequestRulesGeneralCWProxy get copyWith =>
      _$CouponCreateRequestRulesGeneralCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreateRequestRulesGeneral _$CouponCreateRequestRulesGeneralFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreateRequestRulesGeneral', json, ($checkedConvert) {
  final val = CouponCreateRequestRulesGeneral(
    type: $checkedConvert(
      'type',
      (v) => $enumDecodeNullable(
        _$CouponCreateRequestRulesGeneralTypeEnumEnumMap,
        v,
      ),
    ),
    minOrderAmount: $checkedConvert('minOrderAmount', (v) => v as num?),
    maxDiscountAmount: $checkedConvert('maxDiscountAmount', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$CouponCreateRequestRulesGeneralToJson(
  CouponCreateRequestRulesGeneral instance,
) => <String, dynamic>{
  'type': ?_$CouponCreateRequestRulesGeneralTypeEnumEnumMap[instance.type],
  'minOrderAmount': ?instance.minOrderAmount,
  'maxDiscountAmount': ?instance.maxDiscountAmount,
};

const _$CouponCreateRequestRulesGeneralTypeEnumEnumMap = {
  CouponCreateRequestRulesGeneralTypeEnum.percentage: 'percentage',
  CouponCreateRequestRulesGeneralTypeEnum.fixed: 'fixed',
};
