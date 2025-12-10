//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_chat_message_sender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_chat_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderChatMessage {
  /// Returns a new [OrderChatMessage] instance.
  const OrderChatMessage({
    required this.id,
    required this.orderId,
    required this.senderId,
    required this.message,
    required this.sentAt,
    required this.createdAt,
    required this.updatedAt,
    this.sender,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'senderId', required: true, includeIfNull: false)
  final String senderId;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'sentAt', required: true, includeIfNull: false)
  final DateTime sentAt;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'sender', required: false, includeIfNull: false)
  final OrderChatMessageSender? sender;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderChatMessage &&
          other.id == id &&
          other.orderId == orderId &&
          other.senderId == senderId &&
          other.message == message &&
          other.sentAt == sentAt &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.sender == sender;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      senderId.hashCode +
      message.hashCode +
      sentAt.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      sender.hashCode;

  factory OrderChatMessage.fromJson(Map<String, dynamic> json) =>
      _$OrderChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderChatMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
