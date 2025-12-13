//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_chat_unread_count.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadChatUnreadCount {
  /// Returns a new [OrderEnvelopePayloadChatUnreadCount] instance.
  const OrderEnvelopePayloadChatUnreadCount({
    required this.orderId,
    required this.userId,
    required this.unreadCount,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;
  
  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'unreadCount', required: true, includeIfNull: false)
  final int unreadCount;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEnvelopePayloadChatUnreadCount &&
    other.orderId == orderId &&
    other.userId == userId &&
    other.unreadCount == unreadCount;

  @override
  int get hashCode =>
      orderId.hashCode +
      userId.hashCode +
      unreadCount.hashCode;

  factory OrderEnvelopePayloadChatUnreadCount.fromJson(Map<String, dynamic> json) => _$OrderEnvelopePayloadChatUnreadCountFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadChatUnreadCountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

