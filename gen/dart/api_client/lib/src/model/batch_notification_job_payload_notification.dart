//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'batch_notification_job_payload_notification.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BatchNotificationJobPayloadNotification {
  /// Returns a new [BatchNotificationJobPayloadNotification] instance.
  const BatchNotificationJobPayloadNotification({
    required this.title,
    required this.body,
    this.data,
  });
  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final String body;

  @JsonKey(name: r'data', required: false, includeIfNull: false)
  final Map<String, String>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchNotificationJobPayloadNotification &&
          other.title == title &&
          other.body == body &&
          other.data == data;

  @override
  int get hashCode => title.hashCode + body.hashCode + data.hashCode;

  factory BatchNotificationJobPayloadNotification.fromJson(
    Map<String, dynamic> json,
  ) => _$BatchNotificationJobPayloadNotificationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BatchNotificationJobPayloadNotificationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
