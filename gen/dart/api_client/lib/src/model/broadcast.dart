//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/broadcast_type.dart';
import 'package:api_client/src/model/broadcast_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Broadcast {
  /// Returns a new [Broadcast] instance.
  const Broadcast({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.status,
    required this.targetAudience,
    this.targetIds,
    this.scheduledAt,
    this.sentAt,
    this.completedAt,
    this.failedCount = 0,
    this.successCount = 0,
    this.totalCount = 0,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final BroadcastType type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final BroadcastStatus status;

  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BroadcastTargetAudienceEnum targetAudience;

  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;

  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;

  @JsonKey(name: r'sentAt', required: false, includeIfNull: false)
  final DateTime? sentAt;

  @JsonKey(name: r'completedAt', required: false, includeIfNull: false)
  final DateTime? completedAt;

  @JsonKey(
    defaultValue: 0,
    name: r'failedCount',
    required: false,
    includeIfNull: false,
  )
  final num? failedCount;

  @JsonKey(
    defaultValue: 0,
    name: r'successCount',
    required: false,
    includeIfNull: false,
  )
  final num? successCount;

  @JsonKey(
    defaultValue: 0,
    name: r'totalCount',
    required: false,
    includeIfNull: false,
  )
  final num? totalCount;

  @JsonKey(name: r'createdBy', required: false, includeIfNull: false)
  final String? createdBy;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Broadcast &&
          other.id == id &&
          other.title == title &&
          other.message == message &&
          other.type == type &&
          other.status == status &&
          other.targetAudience == targetAudience &&
          other.targetIds == targetIds &&
          other.scheduledAt == scheduledAt &&
          other.sentAt == sentAt &&
          other.completedAt == completedAt &&
          other.failedCount == failedCount &&
          other.successCount == successCount &&
          other.totalCount == totalCount &&
          other.createdBy == createdBy &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      title.hashCode +
      message.hashCode +
      type.hashCode +
      status.hashCode +
      targetAudience.hashCode +
      targetIds.hashCode +
      scheduledAt.hashCode +
      sentAt.hashCode +
      completedAt.hashCode +
      failedCount.hashCode +
      successCount.hashCode +
      totalCount.hashCode +
      createdBy.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Broadcast.fromJson(Map<String, dynamic> json) =>
      _$BroadcastFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BroadcastTargetAudienceEnum {
  @JsonValue(r'ALL')
  ALL(r'ALL'),
  @JsonValue(r'USERS')
  USERS(r'USERS'),
  @JsonValue(r'DRIVERS')
  DRIVERS(r'DRIVERS'),
  @JsonValue(r'MERCHANTS')
  MERCHANTS(r'MERCHANTS'),
  @JsonValue(r'ADMINS')
  ADMINS(r'ADMINS'),
  @JsonValue(r'OPERATORS')
  OPERATORS(r'OPERATORS');

  const BroadcastTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
