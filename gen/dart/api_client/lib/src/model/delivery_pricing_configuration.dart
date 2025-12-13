//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'delivery_pricing_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryPricingConfiguration {
  /// Returns a new [DeliveryPricingConfiguration] instance.
  const DeliveryPricingConfiguration({
    required this.baseFare,
    required this.perKmRate,
    required this.minimumFare,
    required this.platformFeeRate,
    required this.taxRate,
    required this.perKgRate,
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
  
  @JsonKey(name: r'perKgRate', required: true, includeIfNull: false)
  final num perKgRate;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DeliveryPricingConfiguration &&
    other.baseFare == baseFare &&
    other.perKmRate == perKmRate &&
    other.minimumFare == minimumFare &&
    other.platformFeeRate == platformFeeRate &&
    other.taxRate == taxRate &&
    other.perKgRate == perKgRate;

  @override
  int get hashCode =>
      baseFare.hashCode +
      perKmRate.hashCode +
      minimumFare.hashCode +
      platformFeeRate.hashCode +
      taxRate.hashCode +
      perKgRate.hashCode;

  factory DeliveryPricingConfiguration.fromJson(Map<String, dynamic> json) => _$DeliveryPricingConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryPricingConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

