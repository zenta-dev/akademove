//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'food_pricing_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FoodPricingConfiguration {
  /// Returns a new [FoodPricingConfiguration] instance.
  const FoodPricingConfiguration({
    required this.baseFare,
    required this.perKmRate,
    required this.minimumFare,
    required this.platformFeeRate,
    required this.taxRate,
    required this.merchantCommissionRate,
  });
  @JsonKey(name: r'baseFare', required: true, includeIfNull: false)
  final num baseFare;

  @JsonKey(name: r'perKmRate', required: true, includeIfNull: false)
  final num perKmRate;

  @JsonKey(name: r'minimumFare', required: true, includeIfNull: false)
  final num minimumFare;

  @JsonKey(name: r'platformFeeRate', required: true, includeIfNull: false)
  final num platformFeeRate;

  @JsonKey(name: r'taxRate', required: true, includeIfNull: false)
  final num taxRate;

  // minimum: 0
  // maximum: 1
  @JsonKey(
    name: r'merchantCommissionRate',
    required: true,
    includeIfNull: false,
  )
  final num merchantCommissionRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodPricingConfiguration &&
          other.baseFare == baseFare &&
          other.perKmRate == perKmRate &&
          other.minimumFare == minimumFare &&
          other.platformFeeRate == platformFeeRate &&
          other.taxRate == taxRate &&
          other.merchantCommissionRate == merchantCommissionRate;

  @override
  int get hashCode =>
      baseFare.hashCode +
      perKmRate.hashCode +
      minimumFare.hashCode +
      platformFeeRate.hashCode +
      taxRate.hashCode +
      merchantCommissionRate.hashCode;

  factory FoodPricingConfiguration.fromJson(Map<String, dynamic> json) =>
      _$FoodPricingConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPricingConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
