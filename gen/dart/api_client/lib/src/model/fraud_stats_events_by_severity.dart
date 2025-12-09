//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_stats_events_by_severity.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudStatsEventsBySeverity {
  /// Returns a new [FraudStatsEventsBySeverity] instance.
  const FraudStatsEventsBySeverity({
    required this.LOW,
    required this.MEDIUM,
    required this.HIGH,
    required this.CRITICAL,
  });
  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'LOW', required: true, includeIfNull: false)
  final int LOW;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'MEDIUM', required: true, includeIfNull: false)
  final int MEDIUM;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'HIGH', required: true, includeIfNull: false)
  final int HIGH;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'CRITICAL', required: true, includeIfNull: false)
  final int CRITICAL;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FraudStatsEventsBySeverity &&
          other.LOW == LOW &&
          other.MEDIUM == MEDIUM &&
          other.HIGH == HIGH &&
          other.CRITICAL == CRITICAL;

  @override
  int get hashCode =>
      LOW.hashCode + MEDIUM.hashCode + HIGH.hashCode + CRITICAL.hashCode;

  factory FraudStatsEventsBySeverity.fromJson(Map<String, dynamic> json) =>
      _$FraudStatsEventsBySeverityFromJson(json);

  Map<String, dynamic> toJson() => _$FraudStatsEventsBySeverityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
