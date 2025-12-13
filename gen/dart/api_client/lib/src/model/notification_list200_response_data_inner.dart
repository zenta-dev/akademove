//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_list200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationList200ResponseDataInner {
  /// Returns a new [NotificationList200ResponseDataInner] instance.
  const NotificationList200ResponseDataInner({
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
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;
  
  @JsonKey(name: r'readAt', required: false, includeIfNull: false)
  final DateTime? readAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationList200ResponseDataInner &&
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
      (createdAt == null ? 0 : createdAt.hashCode) +
      (readAt == null ? 0 : readAt.hashCode);

  factory NotificationList200ResponseDataInner.fromJson(Map<String, dynamic> json) => _$NotificationList200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationList200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

