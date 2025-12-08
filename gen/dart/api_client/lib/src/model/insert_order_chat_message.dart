//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_order_chat_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertOrderChatMessage {
  /// Returns a new [InsertOrderChatMessage] instance.
  const InsertOrderChatMessage({required this.orderId, required this.message});
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertOrderChatMessage &&
          other.orderId == orderId &&
          other.message == message;

  @override
  int get hashCode => orderId.hashCode + message.hashCode;

  factory InsertOrderChatMessage.fromJson(Map<String, dynamic> json) =>
      _$InsertOrderChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$InsertOrderChatMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
