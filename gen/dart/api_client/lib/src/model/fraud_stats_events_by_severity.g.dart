// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_stats_events_by_severity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudStatsEventsBySeverityCWProxy {
  FraudStatsEventsBySeverity LOW(int LOW);

  FraudStatsEventsBySeverity MEDIUM(int MEDIUM);

  FraudStatsEventsBySeverity HIGH(int HIGH);

  FraudStatsEventsBySeverity CRITICAL(int CRITICAL);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsEventsBySeverity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsEventsBySeverity(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsEventsBySeverity call({
    int LOW,
    int MEDIUM,
    int HIGH,
    int CRITICAL,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudStatsEventsBySeverity.copyWith(...)` or call `instanceOfFraudStatsEventsBySeverity.copyWith.fieldName(value)` for a single field.
class _$FraudStatsEventsBySeverityCWProxyImpl
    implements _$FraudStatsEventsBySeverityCWProxy {
  const _$FraudStatsEventsBySeverityCWProxyImpl(this._value);

  final FraudStatsEventsBySeverity _value;

  @override
  FraudStatsEventsBySeverity LOW(int LOW) => call(LOW: LOW);

  @override
  FraudStatsEventsBySeverity MEDIUM(int MEDIUM) => call(MEDIUM: MEDIUM);

  @override
  FraudStatsEventsBySeverity HIGH(int HIGH) => call(HIGH: HIGH);

  @override
  FraudStatsEventsBySeverity CRITICAL(int CRITICAL) => call(CRITICAL: CRITICAL);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsEventsBySeverity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsEventsBySeverity(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsEventsBySeverity call({
    Object? LOW = const $CopyWithPlaceholder(),
    Object? MEDIUM = const $CopyWithPlaceholder(),
    Object? HIGH = const $CopyWithPlaceholder(),
    Object? CRITICAL = const $CopyWithPlaceholder(),
  }) {
    return FraudStatsEventsBySeverity(
      LOW: LOW == const $CopyWithPlaceholder() || LOW == null
          ? _value.LOW
          // ignore: cast_nullable_to_non_nullable
          : LOW as int,
      MEDIUM: MEDIUM == const $CopyWithPlaceholder() || MEDIUM == null
          ? _value.MEDIUM
          // ignore: cast_nullable_to_non_nullable
          : MEDIUM as int,
      HIGH: HIGH == const $CopyWithPlaceholder() || HIGH == null
          ? _value.HIGH
          // ignore: cast_nullable_to_non_nullable
          : HIGH as int,
      CRITICAL: CRITICAL == const $CopyWithPlaceholder() || CRITICAL == null
          ? _value.CRITICAL
          // ignore: cast_nullable_to_non_nullable
          : CRITICAL as int,
    );
  }
}

extension $FraudStatsEventsBySeverityCopyWith on FraudStatsEventsBySeverity {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudStatsEventsBySeverity.copyWith(...)` or `instanceOfFraudStatsEventsBySeverity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudStatsEventsBySeverityCWProxy get copyWith =>
      _$FraudStatsEventsBySeverityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudStatsEventsBySeverity _$FraudStatsEventsBySeverityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudStatsEventsBySeverity', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']);
  final val = FraudStatsEventsBySeverity(
    LOW: $checkedConvert('LOW', (v) => (v as num).toInt()),
    MEDIUM: $checkedConvert('MEDIUM', (v) => (v as num).toInt()),
    HIGH: $checkedConvert('HIGH', (v) => (v as num).toInt()),
    CRITICAL: $checkedConvert('CRITICAL', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$FraudStatsEventsBySeverityToJson(
  FraudStatsEventsBySeverity instance,
) => <String, dynamic>{
  'LOW': instance.LOW,
  'MEDIUM': instance.MEDIUM,
  'HIGH': instance.HIGH,
  'CRITICAL': instance.CRITICAL,
};
