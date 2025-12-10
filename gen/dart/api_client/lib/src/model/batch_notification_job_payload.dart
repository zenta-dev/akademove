//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/batch_notification_job_payload_notification.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'batch_notification_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BatchNotificationJobPayload {
  /// Returns a new [BatchNotificationJobPayload] instance.
  const BatchNotificationJobPayload({
    required this.orderId,
    required this.driverUserIds,
    required this.notification,
    this.sendWebSocket = true,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'driverUserIds', required: true, includeIfNull: false)
  final List<String> driverUserIds;

  @JsonKey(name: r'notification', required: true, includeIfNull: false)
  final BatchNotificationJobPayloadNotification notification;

  @JsonKey(
    defaultValue: true,
    name: r'sendWebSocket',
    required: false,
    includeIfNull: false,
  )
  final bool? sendWebSocket;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchNotificationJobPayload &&
          other.orderId == orderId &&
          other.driverUserIds == driverUserIds &&
          other.notification == notification &&
          other.sendWebSocket == sendWebSocket;

  @override
  int get hashCode =>
      orderId.hashCode +
      driverUserIds.hashCode +
      notification.hashCode +
      sendWebSocket.hashCode;

  factory BatchNotificationJobPayload.fromJson(Map<String, dynamic> json) =>
      _$BatchNotificationJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$BatchNotificationJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
