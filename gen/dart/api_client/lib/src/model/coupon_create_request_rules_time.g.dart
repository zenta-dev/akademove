// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_time.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponCreateRequestRulesTimeCWProxy {
  CouponCreateRequestRulesTime allowedDays(
    List<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays,
  );

  CouponCreateRequestRulesTime allowedHours(List<int>? allowedHours);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesTime(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesTime(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesTime call({
    List<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays,
    List<int>? allowedHours,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCouponCreateRequestRulesTime.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCouponCreateRequestRulesTime.copyWith.fieldName(...)`
class _$CouponCreateRequestRulesTimeCWProxyImpl
    implements _$CouponCreateRequestRulesTimeCWProxy {
  const _$CouponCreateRequestRulesTimeCWProxyImpl(this._value);

  final CouponCreateRequestRulesTime _value;

  @override
  CouponCreateRequestRulesTime allowedDays(
    List<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays,
  ) => this(allowedDays: allowedDays);

  @override
  CouponCreateRequestRulesTime allowedHours(List<int>? allowedHours) =>
      this(allowedHours: allowedHours);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CouponCreateRequestRulesTime(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CouponCreateRequestRulesTime(...).copyWith(id: 12, name: "My name")
  /// ````
  CouponCreateRequestRulesTime call({
    Object? allowedDays = const $CopyWithPlaceholder(),
    Object? allowedHours = const $CopyWithPlaceholder(),
  }) {
    return CouponCreateRequestRulesTime(
      allowedDays: allowedDays == const $CopyWithPlaceholder()
          ? _value.allowedDays
          // ignore: cast_nullable_to_non_nullable
          : allowedDays as List<CouponCreateRequestRulesTimeAllowedDaysEnum>?,
      allowedHours: allowedHours == const $CopyWithPlaceholder()
          ? _value.allowedHours
          // ignore: cast_nullable_to_non_nullable
          : allowedHours as List<int>?,
    );
  }
}

extension $CouponCreateRequestRulesTimeCopyWith
    on CouponCreateRequestRulesTime {
  /// Returns a callable class that can be used as follows: `instanceOfCouponCreateRequestRulesTime.copyWith(...)` or like so:`instanceOfCouponCreateRequestRulesTime.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponCreateRequestRulesTimeCWProxy get copyWith =>
      _$CouponCreateRequestRulesTimeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCreateRequestRulesTime _$CouponCreateRequestRulesTimeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponCreateRequestRulesTime', json, ($checkedConvert) {
  final val = CouponCreateRequestRulesTime(
    allowedDays: $checkedConvert(
      'allowedDays',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => $enumDecode(
              _$CouponCreateRequestRulesTimeAllowedDaysEnumEnumMap,
              e,
            ),
          )
          .toList(),
    ),
    allowedHours: $checkedConvert(
      'allowedHours',
      (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$CouponCreateRequestRulesTimeToJson(
  CouponCreateRequestRulesTime instance,
) => <String, dynamic>{
  'allowedDays': ?instance.allowedDays
      ?.map((e) => _$CouponCreateRequestRulesTimeAllowedDaysEnumEnumMap[e]!)
      .toList(),
  'allowedHours': ?instance.allowedHours,
};

const _$CouponCreateRequestRulesTimeAllowedDaysEnumEnumMap = {
  CouponCreateRequestRulesTimeAllowedDaysEnum.sunday: 'sunday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.monday: 'monday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.tuesday: 'tuesday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.wednesday: 'wednesday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.thursday: 'thursday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.friday: 'friday',
  CouponCreateRequestRulesTimeAllowedDaysEnum.saturday: 'saturday',
};
