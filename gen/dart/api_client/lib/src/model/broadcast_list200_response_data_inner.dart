//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_list200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastList200ResponseDataInner {
  /// Returns a new [BroadcastList200ResponseDataInner] instance.
  const BroadcastList200ResponseDataInner({
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
  final BroadcastList200ResponseDataInnerTypeEnum type;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final BroadcastList200ResponseDataInnerStatusEnum status;
  
  @JsonKey(name: r'targetAudience', required: true, includeIfNull: false)
  final BroadcastList200ResponseDataInnerTargetAudienceEnum targetAudience;
  
  @JsonKey(name: r'targetIds', required: false, includeIfNull: false)
  final List<String>? targetIds;
  
  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;
  
  @JsonKey(name: r'sentAt', required: false, includeIfNull: false)
  final DateTime? sentAt;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 0,name: r'totalRecipients', required: false, includeIfNull: false)
  final int? totalRecipients;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 0,name: r'sentCount', required: false, includeIfNull: false)
  final int? sentCount;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 0,name: r'failedCount', required: false, includeIfNull: false)
  final int? failedCount;
  
  @JsonKey(name: r'createdBy', required: true, includeIfNull: false)
  final String createdBy;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BroadcastList200ResponseDataInner &&
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
      (scheduledAt == null ? 0 : scheduledAt.hashCode) +
      (sentAt == null ? 0 : sentAt.hashCode) +
      totalRecipients.hashCode +
      sentCount.hashCode +
      failedCount.hashCode +
      createdBy.hashCode +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory BroadcastList200ResponseDataInner.fromJson(Map<String, dynamic> json) => _$BroadcastList200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastList200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum BroadcastList200ResponseDataInnerTypeEnum {
  @JsonValue(r'EMAIL')
  EMAIL(r'EMAIL'),
  @JsonValue(r'IN_APP')
  IN_APP(r'IN_APP'),
  @JsonValue(r'ALL')
  ALL(r'ALL');
  
  const BroadcastList200ResponseDataInnerTypeEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum BroadcastList200ResponseDataInnerStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'SENDING')
  SENDING(r'SENDING'),
  @JsonValue(r'SENT')
  SENT(r'SENT'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');
  
  const BroadcastList200ResponseDataInnerStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum BroadcastList200ResponseDataInnerTargetAudienceEnum {
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
  
  const BroadcastList200ResponseDataInnerTargetAudienceEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

