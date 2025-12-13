//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_create201_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastCreate201ResponseData {
  /// Returns a new [BroadcastCreate201ResponseData] instance.
  const BroadcastCreate201ResponseData({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.status,
    required this.targetAudience,
    this.targetIds,
    this.scheduledAt,
    this.sentAt,
    this.totalRecipients = 0,
    this.sentCount = 0,
    this.failedCount = 0,
    required this.createdBy,
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
  final BroadcastCreate201ResponseDataTypeEnum type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final BroadcastCreate201ResponseDataStatusEnum status;

  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BroadcastCreate201ResponseDataTargetAudienceEnum targetAudience;

  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;

  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;

  @JsonKey(name: r'sentAt', required: false, includeIfNull: false)
  final DateTime? sentAt;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'totalRecipients',
    required: false,
    includeIfNull: false,
  )
  final int? totalRecipients;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'sentCount',
    required: false,
    includeIfNull: false,
  )
  final int? sentCount;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'failedCount',
    required: false,
    includeIfNull: false,
  )
  final int? failedCount;

  @JsonKey(name: r'createdBy', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastCreate201ResponseData &&
          other.id == id &&
          other.title == title &&
          other.message == message &&
          other.type == type &&
          other.status == status &&
          other.targetAudience == targetAudience &&
          other.targetIds == targetIds &&
          other.scheduledAt == scheduledAt &&
          other.sentAt == sentAt &&
          other.totalRecipients == totalRecipients &&
          other.sentCount == sentCount &&
          other.failedCount == failedCount &&
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
      totalRecipients.hashCode +
      sentCount.hashCode +
      failedCount.hashCode +
      createdBy.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory BroadcastCreate201ResponseData.fromJson(Map<String, dynamic> json) =>
      _$BroadcastCreate201ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastCreate201ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BroadcastCreate201ResponseDataTypeEnum {
  @JsonValue(r'EMAIL')
  EMAIL(r'EMAIL'),
  @JsonValue(r'IN_APP')
  IN_APP(r'IN_APP'),
  @JsonValue(r'ALL')
  ALL(r'ALL');

  const BroadcastCreate201ResponseDataTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BroadcastCreate201ResponseDataStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'SENDING')
  SENDING(r'SENDING'),
  @JsonValue(r'SENT')
  SENT(r'SENT'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');

  const BroadcastCreate201ResponseDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum BroadcastCreate201ResponseDataTargetAudienceEnum {
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

  const BroadcastCreate201ResponseDataTargetAudienceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
