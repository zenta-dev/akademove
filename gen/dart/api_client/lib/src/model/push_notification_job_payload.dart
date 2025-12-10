//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload_android.dart';
import 'package:api_client/src/model/push_notification_job_payload_apns.dart';
import 'package:api_client/src/model/push_notification_job_payload_webpush.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayload {
  /// Returns a new [PushNotificationJobPayload] instance.
  const PushNotificationJobPayload({
    required this.toUserId,
    this.fromUserId,
    required this.title,
    required this.body,
    this.data,
    this.android,
    this.apns,
    this.webpush,
  });
  @JsonKey(name: r'toUserId', required: true, includeIfNull: false)
  final String toUserId;

  @JsonKey(name: r'fromUserId', required: false, includeIfNull: false)
  final String? fromUserId;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final String body;

  @JsonKey(name: r'data', required: false, includeIfNull: false)
  final Map<String, String>? data;

  @JsonKey(name: r'android', required: false, includeIfNull: false)
  final PushNotificationJobPayloadAndroid? android;

  @JsonKey(name: r'apns', required: false, includeIfNull: false)
  final PushNotificationJobPayloadApns? apns;

  @JsonKey(name: r'webpush', required: false, includeIfNull: false)
  final PushNotificationJobPayloadWebpush? webpush;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayload &&
          other.toUserId == toUserId &&
          other.fromUserId == fromUserId &&
          other.title == title &&
          other.body == body &&
          other.data == data &&
          other.android == android &&
          other.apns == apns &&
          other.webpush == webpush;

  @override
  int get hashCode =>
      toUserId.hashCode +
      fromUserId.hashCode +
      title.hashCode +
      body.hashCode +
      data.hashCode +
      android.hashCode +
      apns.hashCode +
      webpush.hashCode;

  factory PushNotificationJobPayload.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
