// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_pricing_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RidePricingConfigurationCWProxy {
  RidePricingConfiguration baseFare(num baseFare);

  RidePricingConfiguration perKmRate(num perKmRate);

  RidePricingConfiguration minimumFare(num minimumFare);

  RidePricingConfiguration platformFeeRate(num platformFeeRate);

  RidePricingConfiguration taxRate(num taxRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RidePricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RidePricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  RidePricingConfiguration call({num baseFare, num perKmRate, num minimumFare, num platformFeeRate, num taxRate});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRidePricingConfiguration.copyWith(...)` or call `instanceOfRidePricingConfiguration.copyWith.fieldName(value)` for a single field.
class _$RidePricingConfigurationCWProxyImpl implements _$RidePricingConfigurationCWProxy {
  const _$RidePricingConfigurationCWProxyImpl(this._value);

  final RidePricingConfiguration _value;

  @override
  RidePricingConfiguration baseFare(num baseFare) => call(baseFare: baseFare);

  @override
  RidePricingConfiguration perKmRate(num perKmRate) => call(perKmRate: perKmRate);

  @override
  RidePricingConfiguration minimumFare(num minimumFare) => call(minimumFare: minimumFare);

  @override
  RidePricingConfiguration platformFeeRate(num platformFeeRate) => call(platformFeeRate: platformFeeRate);

  @override
  RidePricingConfiguration taxRate(num taxRate) => call(taxRate: taxRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RidePricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RidePricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  RidePricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
  }) {
    return RidePricingConfiguration(
      baseFare: baseFare == const $CopyWithPlaceholder() || baseFare == null
          ? _value.baseFare
          // ignore: cast_nullable_to_non_nullable
          : baseFare as num,
      perKmRate: perKmRate == const $CopyWithPlaceholder() || perKmRate == null
          ? _value.perKmRate
          // ignore: cast_nullable_to_non_nullable
          : perKmRate as num,
      minimumFare: minimumFare == const $CopyWithPlaceholder() || minimumFare == null
          ? _value.minimumFare
          // ignore: cast_nullable_to_non_nullable
          : minimumFare as num,
      platformFeeRate: platformFeeRate == const $CopyWithPlaceholder() || platformFeeRate == null
          ? _value.platformFeeRate
          // ignore: cast_nullable_to_non_nullable
          : platformFeeRate as num,
      taxRate: taxRate == const $CopyWithPlaceholder() || taxRate == null
          ? _value.taxRate
          // ignore: cast_nullable_to_non_nullable
          : taxRate as num,
    );
  }
}

extension $RidePricingConfigurationCopyWith on RidePricingConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRidePricingConfiguration.copyWith(...)` or `instanceOfRidePricingConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RidePricingConfigurationCWProxy get copyWith => _$RidePricingConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RidePricingConfiguration _$RidePricingConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RidePricingConfiguration', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['baseFare', 'perKmRate', 'minimumFare', 'platformFeeRate', 'taxRate']);
      final val = RidePricingConfiguration(
        baseFare: $checkedConvert('baseFare', (v) => v as num),
        perKmRate: $checkedConvert('perKmRate', (v) => v as num),
        minimumFare: $checkedConvert('minimumFare', (v) => v as num),
        platformFeeRate: $checkedConvert('platformFeeRate', (v) => v as num),
        taxRate: $checkedConvert('taxRate', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$RidePricingConfigurationToJson(RidePricingConfiguration instance) => <String, dynamic>{
  'baseFare': instance.baseFare,
  'perKmRate': instance.perKmRate,
  'minimumFare': instance.minimumFare,
  'platformFeeRate': instance.platformFeeRate,
  'taxRate': instance.taxRate,
};
