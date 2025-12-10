//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_android_notification.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadAndroidNotification {
  /// Returns a new [PushNotificationJobPayloadAndroidNotification] instance.
  const PushNotificationJobPayloadAndroidNotification({
    this.clickAction,
    this.channelId,
  });
  @JsonKey(name: r'clickAction', required: false, includeIfNull: false)
  final String? clickAction;

  @JsonKey(name: r'channelId', required: false, includeIfNull: false)
  final String? channelId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadAndroidNotification &&
          other.clickAction == clickAction &&
          other.channelId == channelId;

  @override
  int get hashCode => clickAction.hashCode + channelId.hashCode;

  factory PushNotificationJobPayloadAndroidNotification.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadAndroidNotificationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadAndroidNotificationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
