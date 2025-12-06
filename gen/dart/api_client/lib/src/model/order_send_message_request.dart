//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_send_message_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderSendMessageRequest {
  /// Returns a new [OrderSendMessageRequest] instance.
  const OrderSendMessageRequest({required this.message});
  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderSendMessageRequest && other.message == message;

  @override
  int get hashCode => message.hashCode;

  factory OrderSendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderSendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSendMessageRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
