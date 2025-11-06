// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_pricing_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryPricingConfigurationCWProxy {
  DeliveryPricingConfiguration baseFare(num baseFare);

  DeliveryPricingConfiguration perKmRate(num perKmRate);

  DeliveryPricingConfiguration minimumFare(num minimumFare);

  DeliveryPricingConfiguration platformFeeRate(num platformFeeRate);

  DeliveryPricingConfiguration taxRate(num taxRate);

  DeliveryPricingConfiguration perKgRate(num perKgRate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryPricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryPricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
    num perKgRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryPricingConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryPricingConfiguration.copyWith.fieldName(...)`
class _$DeliveryPricingConfigurationCWProxyImpl
    implements _$DeliveryPricingConfigurationCWProxy {
  const _$DeliveryPricingConfigurationCWProxyImpl(this._value);

  final DeliveryPricingConfiguration _value;

  @override
  DeliveryPricingConfiguration baseFare(num baseFare) =>
      this(baseFare: baseFare);

  @override
  DeliveryPricingConfiguration perKmRate(num perKmRate) =>
      this(perKmRate: perKmRate);

  @override
  DeliveryPricingConfiguration minimumFare(num minimumFare) =>
      this(minimumFare: minimumFare);

  @override
  DeliveryPricingConfiguration platformFeeRate(num platformFeeRate) =>
      this(platformFeeRate: platformFeeRate);

  @override
  DeliveryPricingConfiguration taxRate(num taxRate) => this(taxRate: taxRate);

  @override
  DeliveryPricingConfiguration perKgRate(num perKgRate) =>
      this(perKgRate: perKgRate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryPricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryPricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? perKgRate = const $CopyWithPlaceholder(),
  }) {
    return DeliveryPricingConfiguration(
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

extension $DeliveryPricingConfigurationCopyWith
    on DeliveryPricingConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryPricingConfiguration.copyWith(...)` or like so:`instanceOfDeliveryPricingConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryPricingConfigurationCWProxy get copyWith =>
      _$DeliveryPricingConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryPricingConfiguration _$DeliveryPricingConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DeliveryPricingConfiguration', json, ($checkedConvert) {
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
  final val = DeliveryPricingConfiguration(
    baseFare: $checkedConvert('baseFare', (v) => v as num),
    perKmRate: $checkedConvert('perKmRate', (v) => v as num),
    minimumFare: $checkedConvert('minimumFare', (v) => v as num),
    platformFeeRate: $checkedConvert('platformFeeRate', (v) => v as num),
    taxRate: $checkedConvert('taxRate', (v) => v as num),
    perKgRate: $checkedConvert('perKgRate', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DeliveryPricingConfigurationToJson(
  DeliveryPricingConfiguration instance,
) => <String, dynamic>{
  'baseFare': instance.baseFare,
  'perKmRate': instance.perKmRate,
  'minimumFare': instance.minimumFare,
  'platformFeeRate': instance.platformFeeRate,
  'taxRate': instance.taxRate,
  'perKgRate': instance.perKgRate,
};
