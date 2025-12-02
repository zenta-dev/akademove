//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/emergency_status.dart';
import 'package:api_client/src/model/emergency_type.dart';
import 'package:api_client/src/model/emergency_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Emergency {
  /// Returns a new [Emergency] instance.
  const Emergency({
    required this.id,
    required this.orderId,
    required this.userId,
    this.driverId,
    required this.type,
    required this.status,
    required this.description,
    this.location,
    this.contactedAuthorities,
    this.respondedById,
    this.resolution,
    required this.reportedAt,
    this.acknowledgedAt,
    this.respondingAt,
    this.resolvedAt,
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
  final EmergencyType type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final EmergencyStatus status;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'location', required: false, includeIfNull: false)
  final EmergencyLocation? location;

  @JsonKey(name: r'contactedAuthorities', required: false, includeIfNull: false)
  final List<String>? contactedAuthorities;

  @JsonKey(name: r'respondedById', required: false, includeIfNull: false)
  final String? respondedById;

  @JsonKey(name: r'resolution', required: false, includeIfNull: false)
  final String? resolution;

  @JsonKey(name: r'reportedAt', required: true, includeIfNull: false)
  final DateTime reportedAt;

  @JsonKey(name: r'acknowledgedAt', required: false, includeIfNull: false)
  final DateTime? acknowledgedAt;

  @JsonKey(name: r'respondingAt', required: false, includeIfNull: false)
  final DateTime? respondingAt;

  @JsonKey(name: r'resolvedAt', required: false, includeIfNull: false)
  final DateTime? resolvedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Emergency &&
          other.id == id &&
          other.orderId == orderId &&
          other.userId == userId &&
          other.driverId == driverId &&
          other.type == type &&
          other.status == status &&
          other.description == description &&
          other.location == location &&
          other.contactedAuthorities == contactedAuthorities &&
          other.respondedById == respondedById &&
          other.resolution == resolution &&
          other.reportedAt == reportedAt &&
          other.acknowledgedAt == acknowledgedAt &&
          other.respondingAt == respondingAt &&
          other.resolvedAt == resolvedAt;

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
      contactedAuthorities.hashCode +
      respondedById.hashCode +
      resolution.hashCode +
      reportedAt.hashCode +
      acknowledgedAt.hashCode +
      respondingAt.hashCode +
      resolvedAt.hashCode;

  factory Emergency.fromJson(Map<String, dynamic> json) =>
      _$EmergencyFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
