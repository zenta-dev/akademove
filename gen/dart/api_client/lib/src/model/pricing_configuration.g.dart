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

  PricingConfiguration merchantCommissionRate(num? merchantCommissionRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  PricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
    num perKgRate,
    num? merchantCommissionRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPricingConfiguration.copyWith(...)` or call `instanceOfPricingConfiguration.copyWith.fieldName(value)` for a single field.
class _$PricingConfigurationCWProxyImpl
    implements _$PricingConfigurationCWProxy {
  const _$PricingConfigurationCWProxyImpl(this._value);

  final PricingConfiguration _value;

  @override
  PricingConfiguration baseFare(num baseFare) => call(baseFare: baseFare);

  @override
  PricingConfiguration perKmRate(num perKmRate) => call(perKmRate: perKmRate);

  @override
  PricingConfiguration minimumFare(num minimumFare) =>
      call(minimumFare: minimumFare);

  @override
  PricingConfiguration platformFeeRate(num platformFeeRate) =>
      call(platformFeeRate: platformFeeRate);

  @override
  PricingConfiguration taxRate(num taxRate) => call(taxRate: taxRate);

  @override
  PricingConfiguration perKgRate(num perKgRate) => call(perKgRate: perKgRate);

  @override
  PricingConfiguration merchantCommissionRate(num? merchantCommissionRate) =>
      call(merchantCommissionRate: merchantCommissionRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  PricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? perKgRate = const $CopyWithPlaceholder(),
    Object? merchantCommissionRate = const $CopyWithPlaceholder(),
  }) {
    return PricingConfiguration(
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
      perKgRate: perKgRate == const $CopyWithPlaceholder() || perKgRate == null
          ? _value.perKgRate
          // ignore: cast_nullable_to_non_nullable
          : perKgRate as num,
      merchantCommissionRate:
          merchantCommissionRate == const $CopyWithPlaceholder()
          ? _value.merchantCommissionRate
          // ignore: cast_nullable_to_non_nullable
          : merchantCommissionRate as num?,
    );
  }
}

extension $PricingConfigurationCopyWith on PricingConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPricingConfiguration.copyWith(...)` or `instanceOfPricingConfiguration.copyWith.fieldName(...)`.
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
    merchantCommissionRate: $checkedConvert(
      'merchantCommissionRate',
      (v) => v as num? ?? 0.1,
    ),
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
  'merchantCommissionRate': ?instance.merchantCommissionRate,
};
