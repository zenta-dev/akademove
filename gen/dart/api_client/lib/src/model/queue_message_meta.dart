//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'queue_message_meta.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QueueMessageMeta {
  /// Returns a new [QueueMessageMeta] instance.
  const QueueMessageMeta({
    required this.messageId,
    required this.idempotencyKey,
    required this.createdAt,
    this.retryCount = 0,
    this.orderId,
    this.userId,
  });
  @JsonKey(name: r'messageId', required: true, includeIfNull: true)
  final String? messageId;

  @JsonKey(name: r'idempotencyKey', required: true, includeIfNull: true)
  final String? idempotencyKey;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'retryCount',
    required: false,
    includeIfNull: false,
  )
  final int? retryCount;

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueMessageMeta &&
          other.messageId == messageId &&
          other.idempotencyKey == idempotencyKey &&
          other.createdAt == createdAt &&
          other.retryCount == retryCount &&
          other.orderId == orderId &&
          other.userId == userId;

  @override
  int get hashCode =>
      (messageId == null ? 0 : messageId.hashCode) +
      (idempotencyKey == null ? 0 : idempotencyKey.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      retryCount.hashCode +
      (orderId == null ? 0 : orderId.hashCode) +
      (userId == null ? 0 : userId.hashCode);

  factory QueueMessageMeta.fromJson(Map<String, dynamic> json) =>
      _$QueueMessageMetaFromJson(json);

  Map<String, dynamic> toJson() => _$QueueMessageMetaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
