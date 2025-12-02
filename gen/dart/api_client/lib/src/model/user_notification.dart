//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_notification.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class UserNotification {
  /// Returns a new [UserNotification] instance.
  const UserNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.data,
    this.messageId,
    required this.isRead,
    required this.createdAt,
    this.readAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final String body;

  @JsonKey(name: r'data', required: false, includeIfNull: false)
  final Object? data;

  @JsonKey(name: r'messageId', required: false, includeIfNull: false)
  final String? messageId;

  @JsonKey(name: r'isRead', required: true, includeIfNull: false)
  final bool isRead;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'readAt', required: false, includeIfNull: false)
  final DateTime? readAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotification &&
          other.id == id &&
          other.userId == userId &&
          other.title == title &&
          other.body == body &&
          other.data == data &&
          other.messageId == messageId &&
          other.isRead == isRead &&
          other.createdAt == createdAt &&
          other.readAt == readAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      title.hashCode +
      body.hashCode +
      (data == null ? 0 : data.hashCode) +
      messageId.hashCode +
      isRead.hashCode +
      createdAt.hashCode +
      readAt.hashCode;

  factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
