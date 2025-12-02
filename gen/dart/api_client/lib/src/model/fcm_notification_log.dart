//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fcm_notification_log.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FCMNotificationLog {
  /// Returns a new [FCMNotificationLog] instance.
  const FCMNotificationLog({
    required this.id,
    required this.userId,
     this.token,
     this.topic,
    required this.title,
    required this.body,
     this.data,
     this.messageId,
    required this.status,
     this.error,
    required this.sentAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;
  
  @JsonKey(name: r'token', required: false, includeIfNull: false)
  final String? token;
  
  @JsonKey(name: r'topic', required: false, includeIfNull: false)
  final String? topic;
  
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;
  
  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final String body;
  
  @JsonKey(name: r'data', required: false, includeIfNull: false)
  final Object? data;
  
  @JsonKey(name: r'messageId', required: false, includeIfNull: false)
  final String? messageId;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final FCMNotificationLogStatusEnum status;
  
  @JsonKey(name: r'error', required: false, includeIfNull: false)
  final String? error;
  
  @JsonKey(name: r'sentAt', required: true, includeIfNull: false)
  final DateTime sentAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is FCMNotificationLog &&
    other.id == id &&
    other.userId == userId &&
    other.token == token &&
    other.topic == topic &&
    other.title == title &&
    other.body == body &&
    other.data == data &&
    other.messageId == messageId &&
    other.status == status &&
    other.error == error &&
    other.sentAt == sentAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      token.hashCode +
      topic.hashCode +
      title.hashCode +
      body.hashCode +
      (data == null ? 0 : data.hashCode) +
      messageId.hashCode +
      status.hashCode +
      error.hashCode +
      sentAt.hashCode;

  factory FCMNotificationLog.fromJson(Map<String, dynamic> json) => _$FCMNotificationLogFromJson(json);

  Map<String, dynamic> toJson() => _$FCMNotificationLogToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum FCMNotificationLogStatusEnum {
  @JsonValue(r'SUCCESS')
  SUCCESS(r'SUCCESS'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');
  
  const FCMNotificationLogStatusEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}


