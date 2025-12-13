//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_chat_read_status.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderChatReadStatus {
  /// Returns a new [OrderChatReadStatus] instance.
  const OrderChatReadStatus({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.lastReadMessageId,
    required this.lastReadAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'lastReadMessageId', required: true, includeIfNull: true)
  final String? lastReadMessageId;

  @JsonKey(name: r'lastReadAt', required: true, includeIfNull: true)
  final DateTime? lastReadAt;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderChatReadStatus &&
          other.id == id &&
          other.orderId == orderId &&
          other.userId == userId &&
          other.lastReadMessageId == lastReadMessageId &&
          other.lastReadAt == lastReadAt &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      userId.hashCode +
      (lastReadMessageId == null ? 0 : lastReadMessageId.hashCode) +
      (lastReadAt == null ? 0 : lastReadAt.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory OrderChatReadStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderChatReadStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderChatReadStatusToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
