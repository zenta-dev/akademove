//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload_android_notification.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_android.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadAndroid {
  /// Returns a new [PushNotificationJobPayloadAndroid] instance.
  const PushNotificationJobPayloadAndroid({this.priority, this.notification});
  @JsonKey(name: r'priority', required: false, includeIfNull: false)
  final PushNotificationJobPayloadAndroidPriorityEnum? priority;

  @JsonKey(name: r'notification', required: false, includeIfNull: false)
  final PushNotificationJobPayloadAndroidNotification? notification;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadAndroid &&
          other.priority == priority &&
          other.notification == notification;

  @override
  int get hashCode => priority.hashCode + notification.hashCode;

  factory PushNotificationJobPayloadAndroid.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadAndroidFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadAndroidToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PushNotificationJobPayloadAndroidPriorityEnum {
  @JsonValue(r'high')
  high(r'high'),
  @JsonValue(r'normal')
  normal(r'normal');

  const PushNotificationJobPayloadAndroidPriorityEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
