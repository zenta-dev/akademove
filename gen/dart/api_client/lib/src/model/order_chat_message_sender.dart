//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_chat_message_sender.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class OrderChatMessageSender {
  /// Returns a new [OrderChatMessageSender] instance.
  const OrderChatMessageSender({required this.name, this.image});

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OrderChatMessageSender && other.name == name && other.image == image;

  @override
  int get hashCode => name.hashCode + image.hashCode;

  factory OrderChatMessageSender.fromJson(Map<String, dynamic> json) => _$OrderChatMessageSenderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderChatMessageSenderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
