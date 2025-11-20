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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DeliveryPricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DeliveryPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  DeliveryPricingConfiguration call({
    num baseFare,
    num perKmRate,
    num minimumFare,
    num platformFeeRate,
    num taxRate,
    num perKgRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDeliveryPricingConfiguration.copyWith(...)` or call `instanceOfDeliveryPricingConfiguration.copyWith.fieldName(value)` for a single field.
class _$DeliveryPricingConfigurationCWProxyImpl
    implements _$DeliveryPricingConfigurationCWProxy {
  const _$DeliveryPricingConfigurationCWProxyImpl(this._value);

  final DeliveryPricingConfiguration _value;

  @override
  DeliveryPricingConfiguration baseFare(num baseFare) =>
      call(baseFare: baseFare);

  @override
  DeliveryPricingConfiguration perKmRate(num perKmRate) =>
      call(perKmRate: perKmRate);

  @override
  DeliveryPricingConfiguration minimumFare(num minimumFare) =>
      call(minimumFare: minimumFare);

  @override
  DeliveryPricingConfiguration platformFeeRate(num platformFeeRate) =>
      call(platformFeeRate: platformFeeRate);

  @override
  DeliveryPricingConfiguration taxRate(num taxRate) => call(taxRate: taxRate);

  @override
  DeliveryPricingConfiguration perKgRate(num perKgRate) =>
      call(perKgRate: perKgRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DeliveryPricingConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DeliveryPricingConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  DeliveryPricingConfiguration call({
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? perKmRate = const $CopyWithPlaceholder(),
    Object? minimumFare = const $CopyWithPlaceholder(),
    Object? platformFeeRate = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? perKgRate = const $CopyWithPlaceholder(),
  }) {
    return DeliveryPricingConfiguration(
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
    );
  }
}

extension $DeliveryPricingConfigurationCopyWith
    on DeliveryPricingConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDeliveryPricingConfiguration.copyWith(...)` or `instanceOfDeliveryPricingConfiguration.copyWith.fieldName(...)`.
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
