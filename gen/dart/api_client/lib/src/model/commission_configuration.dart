//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'commission_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CommissionConfiguration {
  /// Returns a new [CommissionConfiguration] instance.
  const CommissionConfiguration({
    required this.rideCommissionRate,
    required this.deliveryCommissionRate,
    required this.foodCommissionRate,
    required this.merchantCommissionRate,
  });

      /// Platform commission rate for RIDE orders (0-1, e.g., 0.15 for 15%)
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'rideCommissionRate', required: true, includeIfNull: false)
  final num rideCommissionRate;
  
      /// Platform commission rate for DELIVERY orders (0-1, e.g., 0.15 for 15%)
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'deliveryCommissionRate', required: true, includeIfNull: false)
  final num deliveryCommissionRate;
  
      /// Platform commission rate for FOOD orders (0-1, e.g., 0.20 for 20%)
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'foodCommissionRate', required: true, includeIfNull: false)
  final num foodCommissionRate;
  
      /// Merchant commission rate on food orders (0-1, e.g., 0.10 for 10%)
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'merchantCommissionRate', required: true, includeIfNull: false)
  final num merchantCommissionRate;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is CommissionConfiguration &&
    other.rideCommissionRate == rideCommissionRate &&
    other.deliveryCommissionRate == deliveryCommissionRate &&
    other.foodCommissionRate == foodCommissionRate &&
    other.merchantCommissionRate == merchantCommissionRate;

  @override
  int get hashCode =>
      rideCommissionRate.hashCode +
      deliveryCommissionRate.hashCode +
      foodCommissionRate.hashCode +
      merchantCommissionRate.hashCode;

  factory CommissionConfiguration.fromJson(Map<String, dynamic> json) => _$CommissionConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

