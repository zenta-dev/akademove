//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'audit_log_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuditLogJobPayload {
  /// Returns a new [AuditLogJobPayload] instance.
  const AuditLogJobPayload({
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.actorId,
    required this.actorRole,
    this.changes,
    this.ipAddress,
    this.userAgent,
  });
  @JsonKey(name: r'action', required: true, includeIfNull: false)
  final String action;

  @JsonKey(name: r'entityType', required: true, includeIfNull: false)
  final String entityType;

  @JsonKey(name: r'entityId', required: true, includeIfNull: false)
  final String entityId;

  @JsonKey(name: r'actorId', required: true, includeIfNull: false)
  final String actorId;

  @JsonKey(name: r'actorRole', required: true, includeIfNull: false)
  final String actorRole;

  @JsonKey(name: r'changes', required: false, includeIfNull: false)
  final Map<String, Object>? changes;

  @JsonKey(name: r'ipAddress', required: false, includeIfNull: false)
  final String? ipAddress;

  @JsonKey(name: r'userAgent', required: false, includeIfNull: false)
  final String? userAgent;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditLogJobPayload &&
          other.action == action &&
          other.entityType == entityType &&
          other.entityId == entityId &&
          other.actorId == actorId &&
          other.actorRole == actorRole &&
          other.changes == changes &&
          other.ipAddress == ipAddress &&
          other.userAgent == userAgent;

  @override
  int get hashCode =>
      action.hashCode +
      entityType.hashCode +
      entityId.hashCode +
      actorId.hashCode +
      actorRole.hashCode +
      changes.hashCode +
      ipAddress.hashCode +
      userAgent.hashCode;

  factory AuditLogJobPayload.fromJson(Map<String, dynamic> json) =>
      _$AuditLogJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$AuditLogJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
