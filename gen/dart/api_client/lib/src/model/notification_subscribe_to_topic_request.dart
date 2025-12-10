//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_subscribe_to_topic_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationSubscribeToTopicRequest {
  /// Returns a new [NotificationSubscribeToTopicRequest] instance.
  const NotificationSubscribeToTopicRequest({
    required this.topic,
    required this.token,
  });
  @JsonKey(name: r'topic', required: true, includeIfNull: true)
  final String? topic;

  @JsonKey(name: r'token', required: true, includeIfNull: true)
  final String? token;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSubscribeToTopicRequest &&
          other.topic == topic &&
          other.token == token;

  @override
  int get hashCode =>
      (topic == null ? 0 : topic.hashCode) +
      (token == null ? 0 : token.hashCode);

  factory NotificationSubscribeToTopicRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationSubscribeToTopicRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NotificationSubscribeToTopicRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
