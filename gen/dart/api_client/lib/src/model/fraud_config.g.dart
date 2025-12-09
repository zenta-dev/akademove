// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_config.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudConfigCWProxy {
  FraudConfig gpsMaxVelocityKmh(num? gpsMaxVelocityKmh);

  FraudConfig gpsTeleportThresholdKm(num? gpsTeleportThresholdKm);

  FraudConfig gpsMinUpdateIntervalMs(num? gpsMinUpdateIntervalMs);

  FraudConfig duplicateIpWindowHours(num? duplicateIpWindowHours);

  FraudConfig duplicateIpMaxRegistrations(num? duplicateIpMaxRegistrations);

  FraudConfig nameSimilarityThreshold(num? nameSimilarityThreshold);

  FraudConfig highRiskScoreThreshold(num? highRiskScoreThreshold);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudConfig(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudConfig(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudConfig call({
    num? gpsMaxVelocityKmh,
    num? gpsTeleportThresholdKm,
    num? gpsMinUpdateIntervalMs,
    num? duplicateIpWindowHours,
    num? duplicateIpMaxRegistrations,
    num? nameSimilarityThreshold,
    num? highRiskScoreThreshold,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudConfig.copyWith(...)` or call `instanceOfFraudConfig.copyWith.fieldName(value)` for a single field.
class _$FraudConfigCWProxyImpl implements _$FraudConfigCWProxy {
  const _$FraudConfigCWProxyImpl(this._value);

  final FraudConfig _value;

  @override
  FraudConfig gpsMaxVelocityKmh(num? gpsMaxVelocityKmh) =>
      call(gpsMaxVelocityKmh: gpsMaxVelocityKmh);

  @override
  FraudConfig gpsTeleportThresholdKm(num? gpsTeleportThresholdKm) =>
      call(gpsTeleportThresholdKm: gpsTeleportThresholdKm);

  @override
  FraudConfig gpsMinUpdateIntervalMs(num? gpsMinUpdateIntervalMs) =>
      call(gpsMinUpdateIntervalMs: gpsMinUpdateIntervalMs);

  @override
  FraudConfig duplicateIpWindowHours(num? duplicateIpWindowHours) =>
      call(duplicateIpWindowHours: duplicateIpWindowHours);

  @override
  FraudConfig duplicateIpMaxRegistrations(num? duplicateIpMaxRegistrations) =>
      call(duplicateIpMaxRegistrations: duplicateIpMaxRegistrations);

  @override
  FraudConfig nameSimilarityThreshold(num? nameSimilarityThreshold) =>
      call(nameSimilarityThreshold: nameSimilarityThreshold);

  @override
  FraudConfig highRiskScoreThreshold(num? highRiskScoreThreshold) =>
      call(highRiskScoreThreshold: highRiskScoreThreshold);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudConfig(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudConfig(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudConfig call({
    Object? gpsMaxVelocityKmh = const $CopyWithPlaceholder(),
    Object? gpsTeleportThresholdKm = const $CopyWithPlaceholder(),
    Object? gpsMinUpdateIntervalMs = const $CopyWithPlaceholder(),
    Object? duplicateIpWindowHours = const $CopyWithPlaceholder(),
    Object? duplicateIpMaxRegistrations = const $CopyWithPlaceholder(),
    Object? nameSimilarityThreshold = const $CopyWithPlaceholder(),
    Object? highRiskScoreThreshold = const $CopyWithPlaceholder(),
  }) {
    return FraudConfig(
      gpsMaxVelocityKmh: gpsMaxVelocityKmh == const $CopyWithPlaceholder()
          ? _value.gpsMaxVelocityKmh
          // ignore: cast_nullable_to_non_nullable
          : gpsMaxVelocityKmh as num?,
      gpsTeleportThresholdKm:
          gpsTeleportThresholdKm == const $CopyWithPlaceholder()
          ? _value.gpsTeleportThresholdKm
          // ignore: cast_nullable_to_non_nullable
          : gpsTeleportThresholdKm as num?,
      gpsMinUpdateIntervalMs:
          gpsMinUpdateIntervalMs == const $CopyWithPlaceholder()
          ? _value.gpsMinUpdateIntervalMs
          // ignore: cast_nullable_to_non_nullable
          : gpsMinUpdateIntervalMs as num?,
      duplicateIpWindowHours:
          duplicateIpWindowHours == const $CopyWithPlaceholder()
          ? _value.duplicateIpWindowHours
          // ignore: cast_nullable_to_non_nullable
          : duplicateIpWindowHours as num?,
      duplicateIpMaxRegistrations:
          duplicateIpMaxRegistrations == const $CopyWithPlaceholder()
          ? _value.duplicateIpMaxRegistrations
          // ignore: cast_nullable_to_non_nullable
          : duplicateIpMaxRegistrations as num?,
      nameSimilarityThreshold:
          nameSimilarityThreshold == const $CopyWithPlaceholder()
          ? _value.nameSimilarityThreshold
          // ignore: cast_nullable_to_non_nullable
          : nameSimilarityThreshold as num?,
      highRiskScoreThreshold:
          highRiskScoreThreshold == const $CopyWithPlaceholder()
          ? _value.highRiskScoreThreshold
          // ignore: cast_nullable_to_non_nullable
          : highRiskScoreThreshold as num?,
    );
  }
}

extension $FraudConfigCopyWith on FraudConfig {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudConfig.copyWith(...)` or `instanceOfFraudConfig.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudConfigCWProxy get copyWith => _$FraudConfigCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudConfig _$FraudConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudConfig', json, ($checkedConvert) {
      final val = FraudConfig(
        gpsMaxVelocityKmh: $checkedConvert(
          'gpsMaxVelocityKmh',
          (v) => v as num? ?? 200,
        ),
        gpsTeleportThresholdKm: $checkedConvert(
          'gpsTeleportThresholdKm',
          (v) => v as num? ?? 50,
        ),
        gpsMinUpdateIntervalMs: $checkedConvert(
          'gpsMinUpdateIntervalMs',
          (v) => v as num? ?? 1000,
        ),
        duplicateIpWindowHours: $checkedConvert(
          'duplicateIpWindowHours',
          (v) => v as num? ?? 24,
        ),
        duplicateIpMaxRegistrations: $checkedConvert(
          'duplicateIpMaxRegistrations',
          (v) => v as num? ?? 3,
        ),
        nameSimilarityThreshold: $checkedConvert(
          'nameSimilarityThreshold',
          (v) => v as num? ?? 0.85,
        ),
        highRiskScoreThreshold: $checkedConvert(
          'highRiskScoreThreshold',
          (v) => v as num? ?? 70,
        ),
      );
      return val;
    });

Map<String, dynamic> _$FraudConfigToJson(FraudConfig instance) =>
    <String, dynamic>{
      'gpsMaxVelocityKmh': ?instance.gpsMaxVelocityKmh,
      'gpsTeleportThresholdKm': ?instance.gpsTeleportThresholdKm,
      'gpsMinUpdateIntervalMs': ?instance.gpsMinUpdateIntervalMs,
      'duplicateIpWindowHours': ?instance.duplicateIpWindowHours,
      'duplicateIpMaxRegistrations': ?instance.duplicateIpMaxRegistrations,
      'nameSimilarityThreshold': ?instance.nameSimilarityThreshold,
      'highRiskScoreThreshold': ?instance.highRiskScoreThreshold,
    };
