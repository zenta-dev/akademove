//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_chat_message.dart';
import 'package:api_client/src/model/support_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatEnvelopePayload {
  /// Returns a new [SupportChatEnvelopePayload] instance.
  const SupportChatEnvelopePayload({
     this.message,
     this.ticket,
     this.ticketId,
     this.messageId,
     this.isTyping,
     this.userId,
  });
  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final SupportChatMessage? message;
  
  @JsonKey(name: r'ticket', required: false, includeIfNull: false)
  final SupportTicket? ticket;
  
  @JsonKey(name: r'ticketId', required: false, includeIfNull: false)
  final String? ticketId;
  
  @JsonKey(name: r'messageId', required: false, includeIfNull: false)
  final String? messageId;
  
  @JsonKey(name: r'isTyping', required: false, includeIfNull: false)
  final bool? isTyping;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is SupportChatEnvelopePayload &&
    other.message == message &&
    other.ticket == ticket &&
    other.ticketId == ticketId &&
    other.messageId == messageId &&
    other.isTyping == isTyping &&
    other.userId == userId;

  @override
  int get hashCode =>
      message.hashCode +
      ticket.hashCode +
      ticketId.hashCode +
      messageId.hashCode +
      isTyping.hashCode +
      (userId == null ? 0 : userId.hashCode);

  factory SupportChatEnvelopePayload.fromJson(Map<String, dynamic> json) => _$SupportChatEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SupportChatEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

