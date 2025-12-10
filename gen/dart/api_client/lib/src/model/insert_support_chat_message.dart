//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_support_chat_message.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertSupportChatMessage {
  /// Returns a new [InsertSupportChatMessage] instance.
  const InsertSupportChatMessage({
    required this.ticketId,
    required this.message,
  });
  @JsonKey(name: r'ticketId', required: true, includeIfNull: true)
  final String? ticketId;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertSupportChatMessage &&
          other.ticketId == ticketId &&
          other.message == message;

  @override
  int get hashCode =>
      (ticketId == null ? 0 : ticketId.hashCode) + message.hashCode;

  factory InsertSupportChatMessage.fromJson(Map<String, dynamic> json) =>
      _$InsertSupportChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$InsertSupportChatMessageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
