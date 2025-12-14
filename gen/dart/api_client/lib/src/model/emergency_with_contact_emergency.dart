//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_with_contact_emergency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyWithContactEmergency {
  /// Returns a new [EmergencyWithContactEmergency] instance.
  const EmergencyWithContactEmergency({
    required this.id,
    required this.orderId,
    required this.userId,
    this.driverId,
    required this.type,
    required this.status,
    required this.description,
    this.location,
    required this.reportedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final EmergencyLocation? location;

  @JsonKey(name: r'reportedAt', required: true, includeIfNull: false)
  final DateTime reportedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyWithContactEmergency &&
          other.id == id &&
          other.orderId == orderId &&
          other.userId == userId &&
          other.driverId == driverId &&
          other.type == type &&
          other.status == status &&
          other.description == description &&
          other.location == location &&
          other.reportedAt == reportedAt;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      userId.hashCode +
      driverId.hashCode +
      type.hashCode +
      status.hashCode +
      description.hashCode +
      location.hashCode +
      reportedAt.hashCode;

  factory EmergencyWithContactEmergency.fromJson(Map<String, dynamic> json) =>
      _$EmergencyWithContactEmergencyFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyWithContactEmergencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
