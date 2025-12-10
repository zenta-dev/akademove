//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_unsubscribe_to_topic_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationUnsubscribeToTopicRequest {
  /// Returns a new [NotificationUnsubscribeToTopicRequest] instance.
  const NotificationUnsubscribeToTopicRequest({
    required this.topic,
    required this.token,
  });
  @JsonKey(name: r'topic', required: true, includeIfNull: false)
  final String topic;
  
  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationUnsubscribeToTopicRequest &&
    other.topic == topic &&
    other.token == token;

  @override
  int get hashCode =>
      topic.hashCode +
      token.hashCode;

  factory NotificationUnsubscribeToTopicRequest.fromJson(Map<String, dynamic> json) => _$NotificationUnsubscribeToTopicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationUnsubscribeToTopicRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

