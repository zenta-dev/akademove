//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload_apns_payload.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_apns.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadApns {
  /// Returns a new [PushNotificationJobPayloadApns] instance.
  const PushNotificationJobPayloadApns({this.payload});
  @JsonKey(name: r'payload', required: false, includeIfNull: false)
  final PushNotificationJobPayloadApnsPayload? payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadApns && other.payload == payload;

  @override
  int get hashCode => payload.hashCode;

  factory PushNotificationJobPayloadApns.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationJobPayloadApnsFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationJobPayloadApnsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
