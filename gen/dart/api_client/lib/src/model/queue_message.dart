//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/web_socket_broadcast_job_payload.dart';
import 'package:api_client/src/model/queue_message_meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'queue_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QueueMessage {
  /// Returns a new [QueueMessage] instance.
  const QueueMessage({
    required this.type,
    required this.meta,
    required this.payload,
  });
  @JsonKey(name: r'type', required: true, includeIfNull: true)
  final Object? type;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final QueueMessageMeta meta;

  @JsonKey(name: r'payload', required: true, includeIfNull: false)
  final WebSocketBroadcastJobPayload payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueMessage &&
          other.type == type &&
          other.meta == meta &&
          other.payload == payload;

  @override
  int get hashCode =>
      (type == null ? 0 : type.hashCode) + meta.hashCode + payload.hashCode;

  factory QueueMessage.fromJson(Map<String, dynamic> json) =>
      _$QueueMessageFromJson(json);

  Map<String, dynamic> toJson() => _$QueueMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
