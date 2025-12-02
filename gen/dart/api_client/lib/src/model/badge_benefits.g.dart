// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_benefits.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeBenefitsCWProxy {
  BadgeBenefits priorityBoost(int? priorityBoost);

  BadgeBenefits commissionReduction(num? commissionReduction);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeBenefits(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeBenefits(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeBenefits call({int? priorityBoost, num? commissionReduction});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeBenefits.copyWith(...)` or call `instanceOfBadgeBenefits.copyWith.fieldName(value)` for a single field.
class _$BadgeBenefitsCWProxyImpl implements _$BadgeBenefitsCWProxy {
  const _$BadgeBenefitsCWProxyImpl(this._value);

  final BadgeBenefits _value;

  @override
  BadgeBenefits priorityBoost(int? priorityBoost) => call(priorityBoost: priorityBoost);

  @override
  BadgeBenefits commissionReduction(num? commissionReduction) => call(commissionReduction: commissionReduction);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeBenefits(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeBenefits(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeBenefits.copyWith(...)` or `instanceOfBadgeBenefits.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeBenefitsCWProxy get copyWith => _$BadgeBenefitsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeBenefits _$BadgeBenefitsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeBenefits', json, ($checkedConvert) {
      final val = BadgeBenefits(
        priorityBoost: $checkedConvert('priorityBoost', (v) => (v as num?)?.toInt()),
        commissionReduction: $checkedConvert('commissionReduction', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$BadgeBenefitsToJson(BadgeBenefits instance) => <String, dynamic>{
  'priorityBoost': ?instance.priorityBoost,
  'commissionReduction': ?instance.commissionReduction,
};
