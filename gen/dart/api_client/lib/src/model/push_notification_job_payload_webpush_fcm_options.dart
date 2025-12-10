//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_webpush_fcm_options.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadWebpushFcmOptions {
  /// Returns a new [PushNotificationJobPayloadWebpushFcmOptions] instance.
  const PushNotificationJobPayloadWebpushFcmOptions({this.link});
  @JsonKey(name: r'link', required: false, includeIfNull: false)
  final String? link;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadWebpushFcmOptions &&
          other.link == link;

  @override
  int get hashCode => link.hashCode;

  factory PushNotificationJobPayloadWebpushFcmOptions.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadWebpushFcmOptionsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadWebpushFcmOptionsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
