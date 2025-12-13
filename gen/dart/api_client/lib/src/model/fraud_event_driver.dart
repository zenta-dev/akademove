//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_event_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudEventDriver {
  /// Returns a new [FraudEventDriver] instance.
  const FraudEventDriver({
    required this.id,
    required this.studentId,
    required this.licensePlate,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'studentId', required: true, includeIfNull: false)
  final num studentId;
  
  @JsonKey(name: r'licensePlate', required: true, includeIfNull: false)
  final String licensePlate;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FraudEventDriver &&
    other.id == id &&
    other.studentId == studentId &&
    other.licensePlate == licensePlate;

  @override
  int get hashCode =>
      id.hashCode +
      studentId.hashCode +
      licensePlate.hashCode;

  factory FraudEventDriver.fromJson(Map<String, dynamic> json) => _$FraudEventDriverFromJson(json);

  Map<String, dynamic> toJson() => _$FraudEventDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

