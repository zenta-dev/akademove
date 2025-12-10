//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'web_socket_broadcast_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WebSocketBroadcastJobPayload {
  /// Returns a new [WebSocketBroadcastJobPayload] instance.
  const WebSocketBroadcastJobPayload({
    required this.roomName,
    required this.event,
    this.target,
    required this.data,
    this.excludeUserIds,
  });
  @JsonKey(name: r'roomName', required: true, includeIfNull: false)
  final String roomName;

  @JsonKey(name: r'event', required: true, includeIfNull: false)
  final String event;

  @JsonKey(name: r'target', required: false, includeIfNull: false)
  final WebSocketBroadcastJobPayloadTargetEnum? target;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Map<String, Object> data;

  @JsonKey(name: r'excludeUserIds', required: false, includeIfNull: false)
  final List<String>? excludeUserIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WebSocketBroadcastJobPayload &&
          other.roomName == roomName &&
          other.event == event &&
          other.target == target &&
          other.data == data &&
          other.excludeUserIds == excludeUserIds;

  @override
  int get hashCode =>
      roomName.hashCode +
      event.hashCode +
      target.hashCode +
      data.hashCode +
      excludeUserIds.hashCode;

  factory WebSocketBroadcastJobPayload.fromJson(Map<String, dynamic> json) =>
      _$WebSocketBroadcastJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketBroadcastJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum WebSocketBroadcastJobPayloadTargetEnum {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'ALL')
  ALL(r'ALL');

  const WebSocketBroadcastJobPayloadTargetEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
