//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadMessage {
  /// Returns a new [OrderEnvelopePayloadMessage] instance.
  const OrderEnvelopePayloadMessage({
    required this.id,
    required this.orderId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.message,
    required this.sentAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;
  
  @JsonKey(name: r'senderId', required: true, includeIfNull: false)
  final String senderId;
  
  @JsonKey(name: r'senderName', required: true, includeIfNull: false)
  final String senderName;
  
  @JsonKey(name: r'senderRole', required: true, includeIfNull: false)
  final OrderEnvelopePayloadMessageSenderRoleEnum senderRole;
  
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'sentAt', required: true, includeIfNull: false)
  final DateTime sentAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEnvelopePayloadMessage &&
    other.id == id &&
    other.orderId == orderId &&
    other.senderId == senderId &&
    other.senderName == senderName &&
    other.senderRole == senderRole &&
    other.message == message &&
    other.sentAt == sentAt;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      senderId.hashCode +
      senderName.hashCode +
      senderRole.hashCode +
      message.hashCode +
      sentAt.hashCode;

  factory OrderEnvelopePayloadMessage.fromJson(Map<String, dynamic> json) => _$OrderEnvelopePayloadMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum OrderEnvelopePayloadMessageSenderRoleEnum {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT');
  
  const OrderEnvelopePayloadMessageSenderRoleEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

