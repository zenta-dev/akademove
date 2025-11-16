// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_benefits.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeBenefitsCWProxy {
  BadgeBenefits priorityBoost(int? priorityBoost);

  BadgeBenefits commissionReduction(num? commissionReduction);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeBenefits(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeBenefits(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeBenefits call({int? priorityBoost, num? commissionReduction});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeBenefits.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeBenefits.copyWith.fieldName(...)`
class _$BadgeBenefitsCWProxyImpl implements _$BadgeBenefitsCWProxy {
  const _$BadgeBenefitsCWProxyImpl(this._value);

  final BadgeBenefits _value;

  @override
  BadgeBenefits priorityBoost(int? priorityBoost) =>
      this(priorityBoost: priorityBoost);

  @override
  BadgeBenefits commissionReduction(num? commissionReduction) =>
      this(commissionReduction: commissionReduction);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeBenefits(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeBenefits(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeBenefits call({
    Object? priorityBoost = const $CopyWithPlaceholder(),
    Object? commissionReduction = const $CopyWithPlaceholder(),
  }) {
    return BadgeBenefits(
      priorityBoost: priorityBoost == const $CopyWithPlaceholder()
          ? _value.priorityBoost
          // ignore: cast_nullable_to_non_nullable
          : priorityBoost as int?,
      commissionReduction: commissionReduction == const $CopyWithPlaceholder()
          ? _value.commissionReduction
          // ignore: cast_nullable_to_non_nullable
          : commissionReduction as num?,
    );
  }
}

extension $BadgeBenefitsCopyWith on BadgeBenefits {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeBenefits.copyWith(...)` or like so:`instanceOfBadgeBenefits.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeBenefitsCWProxy get copyWith => _$BadgeBenefitsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeBenefits _$BadgeBenefitsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeBenefits', json, ($checkedConvert) {
      final val = BadgeBenefits(
        priorityBoost: $checkedConvert(
          'priorityBoost',
          (v) => (v as num?)?.toInt(),
        ),
        commissionReduction: $checkedConvert(
          'commissionReduction',
          (v) => v as num?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$BadgeBenefitsToJson(BadgeBenefits instance) =>
    <String, dynamic>{
      'priorityBoost': ?instance.priorityBoost,
      'commissionReduction': ?instance.commissionReduction,
    };
