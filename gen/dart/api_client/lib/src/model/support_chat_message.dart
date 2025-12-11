//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_chat_message_sender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatMessage {
  /// Returns a new [SupportChatMessage] instance.
  const SupportChatMessage({
    required this.id,
    required this.ticketId,
    required this.senderId,
    required this.message,
    required this.isFromSupport,
     this.readAt,
    required this.sentAt,
    required this.createdAt,
    required this.updatedAt,
     this.sender,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'ticketId', required: true, includeIfNull: false)
  final String ticketId;
  
  @JsonKey(name: r'senderId', required: true, includeIfNull: false)
  final String senderId;
  
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'isFromSupport', required: true, includeIfNull: false)
  final bool isFromSupport;
  
  @JsonKey(name: r'readAt', required: false, includeIfNull: false)
  final DateTime? readAt;
  
  @JsonKey(name: r'sentAt', required: true, includeIfNull: true)
  final DateTime? sentAt;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;
  
  @JsonKey(name: r'sender', required: false, includeIfNull: false)
  final OrderChatMessageSender? sender;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is SupportChatMessage &&
    other.id == id &&
    other.ticketId == ticketId &&
    other.senderId == senderId &&
    other.message == message &&
    other.isFromSupport == isFromSupport &&
    other.readAt == readAt &&
    other.sentAt == sentAt &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.sender == sender;

  @override
  int get hashCode =>
      id.hashCode +
      ticketId.hashCode +
      senderId.hashCode +
      message.hashCode +
      isFromSupport.hashCode +
      (readAt == null ? 0 : readAt.hashCode) +
      (sentAt == null ? 0 : sentAt.hashCode) +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode) +
      sender.hashCode;

  factory SupportChatMessage.fromJson(Map<String, dynamic> json) => _$SupportChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SupportChatMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

