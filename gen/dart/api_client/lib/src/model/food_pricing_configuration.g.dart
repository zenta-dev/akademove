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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FoodPricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FoodPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  FoodPricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFoodPricingConfiguration.copyWith(...)` or call `instanceOfFoodPricingConfiguration.copyWith.fieldName(value)` for a single field.
class _$FoodPricingConfigurationCWProxyImpl
    implements _$FoodPricingConfigurationCWProxy {
  const _$FoodPricingConfigurationCWProxyImpl(this._value);

  final FoodPricingConfiguration _value;

  @override
  FoodPricingConfiguration baseFare(num baseFare) => call(baseFare: baseFare);

  @override
  FoodPricingConfiguration perKmRate(num perKmRate) =>
      call(perKmRate: perKmRate);

  @override
  FoodPricingConfiguration minimumFare(num minimumFare) =>
      call(minimumFare: minimumFare);

  @override
  FoodPricingConfiguration platformFeeRate(num platformFeeRate) =>
      call(platformFeeRate: platformFeeRate);

  @override
  FoodPricingConfiguration taxRate(num taxRate) => call(taxRate: taxRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FoodPricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FoodPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  FoodPricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
  }) {
    return FoodPricingConfiguration(
      baseFare: baseFare == const $CopyWithPlaceholder() || baseFare == null
          ? _value.baseFare
          // ignore: cast_nullable_to_non_nullable
          : baseFare as num,
      perKmRate: perKmRate == const $CopyWithPlaceholder() || perKmRate == null
          ? _value.perKmRate
          // ignore: cast_nullable_to_non_nullable
          : perKmRate as num,
      minimumFare:
          minimumFare == const $CopyWithPlaceholder() || minimumFare == null
          ? _value.minimumFare
          // ignore: cast_nullable_to_non_nullable
          : minimumFare as num,
      platformFeeRate:
          platformFeeRate == const $CopyWithPlaceholder() ||
              platformFeeRate == null
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

extension $FoodPricingConfigurationCopyWith on FoodPricingConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFoodPricingConfiguration.copyWith(...)` or `instanceOfFoodPricingConfiguration.copyWith.fieldName(...)`.
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
