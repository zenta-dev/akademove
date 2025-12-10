//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/push_notification_job_payload.dart';
import 'package:api_client/src/model/queue_message_meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJob {
  /// Returns a new [PushNotificationJob] instance.
  const PushNotificationJob({
    required this.type,
    required this.meta,
    required this.payload,
  });
  @JsonKey(name: r'type', required: true, includeIfNull: true)
  final Object? type;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final QueueMessageMeta meta;

  @JsonKey(name: r'payload', required: true, includeIfNull: false)
  final PushNotificationJobPayload payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJob &&
          other.type == type &&
          other.meta == meta &&
          other.payload == payload;

  @override
  int get hashCode =>
      (type == null ? 0 : type.hashCode) + meta.hashCode + payload.hashCode;

  factory PushNotificationJob.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationJobFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationJobToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
