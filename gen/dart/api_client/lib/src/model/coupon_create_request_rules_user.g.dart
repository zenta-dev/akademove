// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreateRequestRulesUserCWProxy {
  CouponCreateRequestRulesUser newUserOnly(bool? newUserOnly);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesUser call({bool? newUserOnly});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreateRequestRulesUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreateRequestRulesUser.copyWith.fieldName(...)`
class _$CouponCreateRequestRulesUserCWProxyImpl
    implements _$CouponCreateRequestRulesUserCWProxy {
  const _$CouponCreateRequestRulesUserCWProxyImpl(this._value);

  final CouponCreateRequestRulesUser _value;

  @override
  CouponCreateRequestRulesUser newUserOnly(bool? newUserOnly) =>
      this(newUserOnly: newUserOnly);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesUser call({
    Object? newUserOnly = const $CopyWithPlaceholder(),
  }) {
    return CouponCreateRequestRulesUser(
      newUserOnly: newUserOnly == const $CopyWithPlaceholder()
          ? _value.newUserOnly
          // ignore: cast_nullable_to_non_nullable
          : newUserOnly as bool?,
    );
  }
}

extension $CouponCreateRequestRulesUserCopyWith
    on CouponCreateRequestRulesUser {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreateRequestRulesUser.copyWith(...)` or like so:`instanceOfCouponCreateRequestRulesUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreateRequestRulesUserCWProxy get copyWith =>
      _$CouponCreateRequestRulesUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreateRequestRulesUser _$CouponCreateRequestRulesUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreateRequestRulesUser', json, ($checkedConvert) {
  final val = CouponCreateRequestRulesUser(
    newUserOnly: $checkedConvert('newUserOnly', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$CouponCreateRequestRulesUserToJson(
  CouponCreateRequestRulesUser instance,
) => <String, dynamic>{'newUserOnly': ?instance.newUserOnly};
