//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/fraud_event_type.dart';
import 'package:api_client/src/model/fraud_severity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_signal.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudSignal {
  /// Returns a new [FraudSignal] instance.
  const FraudSignal({
    required this.type,
    required this.severity,
    required this.confidence,
    this.metadata,
  });
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final FraudEventType type;

  @JsonKey(name: r'severity', required: true, includeIfNull: false)
  final FraudSeverity severity;

  // minimum: 0
  // maximum: 100
  @JsonKey(name: r'confidence', required: true, includeIfNull: false)
  final num confidence;

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Map<String, Object>? metadata;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FraudSignal &&
          other.type == type &&
          other.severity == severity &&
          other.confidence == confidence &&
          other.metadata == metadata;

  @override
  int get hashCode =>
      type.hashCode +
      severity.hashCode +
      confidence.hashCode +
      metadata.hashCode;

  factory FraudSignal.fromJson(Map<String, dynamic> json) =>
      _$FraudSignalFromJson(json);

  Map<String, dynamic> toJson() => _$FraudSignalToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
