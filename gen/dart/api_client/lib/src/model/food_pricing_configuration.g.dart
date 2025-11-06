// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_pricing_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FoodPricingConfigurationCWProxy {
  FoodPricingConfiguration baseFare(num baseFare);

  FoodPricingConfiguration perKmRate(num perKmRate);

  FoodPricingConfiguration minimumFare(num minimumFare);

  FoodPricingConfiguration platformFeeRate(num platformFeeRate);

  FoodPricingConfiguration taxRate(num taxRate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodPricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodPricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoodPricingConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoodPricingConfiguration.copyWith.fieldName(...)`
class _$FoodPricingConfigurationCWProxyImpl
    implements _$FoodPricingConfigurationCWProxy {
  const _$FoodPricingConfigurationCWProxyImpl(this._value);

  final FoodPricingConfiguration _value;

  @override
  FoodPricingConfiguration baseFare(num baseFare) => this(baseFare: baseFare);

  @override
  FoodPricingConfiguration perKmRate(num perKmRate) =>
      this(perKmRate: perKmRate);

  @override
  FoodPricingConfiguration minimumFare(num minimumFare) =>
      this(minimumFare: minimumFare);

  @override
  FoodPricingConfiguration platformFeeRate(num platformFeeRate) =>
      this(platformFeeRate: platformFeeRate);

  @override
  FoodPricingConfiguration taxRate(num taxRate) => this(taxRate: taxRate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoodPricingConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoodPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  FoodPricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
  }) {
    return FoodPricingConfiguration(
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

extension $FoodPricingConfigurationCopyWith on FoodPricingConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfFoodPricingConfiguration.copyWith(...)` or like so:`instanceOfFoodPricingConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FoodPricingConfigurationCWProxy get copyWith =>
      _$FoodPricingConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodPricingConfiguration _$FoodPricingConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FoodPricingConfiguration', json, ($checkedConvert) {
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
  final val = FoodPricingConfiguration(
    baseFare: $checkedConvert('baseFare', (v) => v as num),
    perKmRate: $checkedConvert('perKmRate', (v) => v as num),
    minimumFare: $checkedConvert('minimumFare', (v) => v as num),
    platformFeeRate: $checkedConvert('platformFeeRate', (v) => v as num),
    taxRate: $checkedConvert('taxRate', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$FoodPricingConfigurationToJson(
  FoodPricingConfiguration instance,
) => <String, dynamic>{
  'baseFare': instance.baseFare,
  'perKmRate': instance.perKmRate,
  'minimumFare': instance.minimumFare,
  'platformFeeRate': instance.platformFeeRate,
  'taxRate': instance.taxRate,
};
