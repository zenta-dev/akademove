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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RidePricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RidePricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  RidePricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRidePricingConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRidePricingConfiguration.copyWith.fieldName(...)`
class _$RidePricingConfigurationCWProxyImpl
    implements _$RidePricingConfigurationCWProxy {
  const _$RidePricingConfigurationCWProxyImpl(this._value);

  final RidePricingConfiguration _value;

  @override
  RidePricingConfiguration baseFare(num baseFare) => this(baseFare: baseFare);

  @override
  RidePricingConfiguration perKmRate(num perKmRate) =>
      this(perKmRate: perKmRate);

  @override
  RidePricingConfiguration minimumFare(num minimumFare) =>
      this(minimumFare: minimumFare);

  @override
  RidePricingConfiguration platformFeeRate(num platformFeeRate) =>
      this(platformFeeRate: platformFeeRate);

  @override
  RidePricingConfiguration taxRate(num taxRate) => this(taxRate: taxRate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RidePricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RidePricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  RidePricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
  }) {
    return RidePricingConfiguration(
      baseFare: baseFare == const $CopyWithPlaceholder()
          ? _value.baseFare
          // ignore: cast_nullable_to_non_nullable
          : baseFare as num,
      perKmRate: perKmRate == const $CopyWithPlaceholder()
          ? _value.perKmRate
          // ignore: cast_nullable_to_non_nullable
          : perKmRate as num,
      minimumFare: minimumFare == const $CopyWithPlaceholder()
          ? _value.minimumFare
          // ignore: cast_nullable_to_non_nullable
          : minimumFare as num,
      platformFeeRate: platformFeeRate == const $CopyWithPlaceholder()
          ? _value.platformFeeRate
          // ignore: cast_nullable_to_non_nullable
          : platformFeeRate as num,
      taxRate: taxRate == const $CopyWithPlaceholder()
          ? _value.taxRate
          // ignore: cast_nullable_to_non_nullable
          : taxRate as num,
    );
  }
}

extension $RidePricingConfigurationCopyWith on RidePricingConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfRidePricingConfiguration.copyWith(...)` or like so:`instanceOfRidePricingConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RidePricingConfigurationCWProxy get copyWith =>
      _$RidePricingConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RidePricingConfiguration _$RidePricingConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RidePricingConfiguration', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'baseFare',
      'perKmRate',
      'minimumFare',
      'platformFeeRate',
      'taxRate',
    ],
  );
  final val = RidePricingConfiguration(
    baseFare: $checkedConvert('baseFare', (v) => v as num),
    perKmRate: $checkedConvert('perKmRate', (v) => v as num),
    minimumFare: $checkedConvert('minimumFare', (v) => v as num),
    platformFeeRate: $checkedConvert('platformFeeRate', (v) => v as num),
    taxRate: $checkedConvert('taxRate', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$RidePricingConfigurationToJson(
  RidePricingConfiguration instance,
) => <String, dynamic>{
  'baseFare': instance.baseFare,
  'perKmRate': instance.perKmRate,
  'minimumFare': instance.minimumFare,
  'platformFeeRate': instance.platformFeeRate,
  'taxRate': instance.taxRate,
};
