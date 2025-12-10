//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload_apns_payload_aps.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_apns_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadApnsPayload {
  /// Returns a new [PushNotificationJobPayloadApnsPayload] instance.
  const PushNotificationJobPayloadApnsPayload({this.aps});
  @JsonKey(name: r'aps', required: false, includeIfNull: false)
  final PushNotificationJobPayloadApnsPayloadAps? aps;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadApnsPayload && other.aps == aps;

  @override
  int get hashCode => aps.hashCode;

  factory PushNotificationJobPayloadApnsPayload.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadApnsPayloadFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadApnsPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
