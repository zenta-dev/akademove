// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PricingConfigurationCWProxy {
  PricingConfiguration baseFare(num baseFare);

  PricingConfiguration perKmRate(num perKmRate);

  PricingConfiguration minimumFare(num minimumFare);

  PricingConfiguration platformFeeRate(num platformFeeRate);

  PricingConfiguration taxRate(num taxRate);

  PricingConfiguration perKgRate(num perKgRate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  PricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
    num perKgRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPricingConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPricingConfiguration.copyWith.fieldName(...)`
class _$PricingConfigurationCWProxyImpl
    implements _$PricingConfigurationCWProxy {
  const _$PricingConfigurationCWProxyImpl(this._value);

  final PricingConfiguration _value;

  @override
  PricingConfiguration baseFare(num baseFare) => this(baseFare: baseFare);

  @override
  PricingConfiguration perKmRate(num perKmRate) => this(perKmRate: perKmRate);

  @override
  PricingConfiguration minimumFare(num minimumFare) =>
      this(minimumFare: minimumFare);

  @override
  PricingConfiguration platformFeeRate(num platformFeeRate) =>
      this(platformFeeRate: platformFeeRate);

  @override
  PricingConfiguration taxRate(num taxRate) => this(taxRate: taxRate);

  @override
  PricingConfiguration perKgRate(num perKgRate) => this(perKgRate: perKgRate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  PricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? perKgRate = const $CopyWithPlaceholder(),
  }) {
    return PricingConfiguration(
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
      perKgRate: perKgRate == const $CopyWithPlaceholder()
          ? _value.perKgRate
          // ignore: cast_nullable_to_non_nullable
          : perKgRate as num,
    );
  }
}

extension $PricingConfigurationCopyWith on PricingConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfPricingConfiguration.copyWith(...)` or like so:`instanceOfPricingConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PricingConfigurationCWProxy get copyWith =>
      _$PricingConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingConfiguration _$PricingConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PricingConfiguration', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'baseFare',
      'perKmRate',
      'minimumFare',
      'platformFeeRate',
      'taxRate',
      'perKgRate',
    ],
  );
  final val = PricingConfiguration(
    baseFare: $checkedConvert('baseFare', (v) => v as num),
    perKmRate: $checkedConvert('perKmRate', (v) => v as num),
    minimumFare: $checkedConvert('minimumFare', (v) => v as num),
    platformFeeRate: $checkedConvert('platformFeeRate', (v) => v as num),
    taxRate: $checkedConvert('taxRate', (v) => v as num),
    perKgRate: $checkedConvert('perKgRate', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$PricingConfigurationToJson(
  PricingConfiguration instance,
) => <String, dynamic>{
  'baseFare': instance.baseFare,
  'perKmRate': instance.perKmRate,
  'minimumFare': instance.minimumFare,
  'platformFeeRate': instance.platformFeeRate,
  'taxRate': instance.taxRate,
  'perKgRate': instance.perKgRate,
};
