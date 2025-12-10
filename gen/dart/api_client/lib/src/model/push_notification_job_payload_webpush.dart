//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload_webpush_fcm_options.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_webpush.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadWebpush {
  /// Returns a new [PushNotificationJobPayloadWebpush] instance.
  const PushNotificationJobPayloadWebpush({this.fcmOptions});
  @JsonKey(name: r'fcmOptions', required: false, includeIfNull: false)
  final PushNotificationJobPayloadWebpushFcmOptions? fcmOptions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadWebpush &&
          other.fcmOptions == fcmOptions;

  @override
  int get hashCode => fcmOptions.hashCode;

  factory PushNotificationJobPayloadWebpush.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadWebpushFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadWebpushToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
