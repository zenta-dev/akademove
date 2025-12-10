//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_config.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudConfig {
  /// Returns a new [FraudConfig] instance.
  const FraudConfig({
     this.gpsMaxVelocityKmh = 200,
     this.gpsTeleportThresholdKm = 50,
     this.gpsMinUpdateIntervalMs = 1000,
     this.duplicateIpWindowHours = 24,
     this.duplicateIpMaxRegistrations = 3,
     this.nameSimilarityThreshold = 0.85,
     this.highRiskScoreThreshold = 70,
  });
  @JsonKey(defaultValue: 200,name: r'gpsMaxVelocityKmh', required: false, includeIfNull: false)
  final num? gpsMaxVelocityKmh;
  
  @JsonKey(defaultValue: 50,name: r'gpsTeleportThresholdKm', required: false, includeIfNull: false)
  final num? gpsTeleportThresholdKm;
  
  @JsonKey(defaultValue: 1000,name: r'gpsMinUpdateIntervalMs', required: false, includeIfNull: false)
  final num? gpsMinUpdateIntervalMs;
  
  @JsonKey(defaultValue: 24,name: r'duplicateIpWindowHours', required: false, includeIfNull: false)
  final num? duplicateIpWindowHours;
  
  @JsonKey(defaultValue: 3,name: r'duplicateIpMaxRegistrations', required: false, includeIfNull: false)
  final num? duplicateIpMaxRegistrations;
  
          // minimum: 0
          // maximum: 1
  @JsonKey(defaultValue: 0.85,name: r'nameSimilarityThreshold', required: false, includeIfNull: false)
  final num? nameSimilarityThreshold;
  
          // minimum: 0
          // maximum: 100
  @JsonKey(defaultValue: 70,name: r'highRiskScoreThreshold', required: false, includeIfNull: false)
  final num? highRiskScoreThreshold;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudConfig &&
    other.gpsMaxVelocityKmh == gpsMaxVelocityKmh &&
    other.gpsTeleportThresholdKm == gpsTeleportThresholdKm &&
    other.gpsMinUpdateIntervalMs == gpsMinUpdateIntervalMs &&
    other.duplicateIpWindowHours == duplicateIpWindowHours &&
    other.duplicateIpMaxRegistrations == duplicateIpMaxRegistrations &&
    other.nameSimilarityThreshold == nameSimilarityThreshold &&
    other.highRiskScoreThreshold == highRiskScoreThreshold;

  @override
  int get hashCode =>
      gpsMaxVelocityKmh.hashCode +
      gpsTeleportThresholdKm.hashCode +
      gpsMinUpdateIntervalMs.hashCode +
      duplicateIpWindowHours.hashCode +
      duplicateIpMaxRegistrations.hashCode +
      nameSimilarityThreshold.hashCode +
      highRiskScoreThreshold.hashCode;

  factory FraudConfig.fromJson(Map<String, dynamic> json) => _$FraudConfigFromJson(json);

  Map<String, dynamic> toJson() => _$FraudConfigToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

