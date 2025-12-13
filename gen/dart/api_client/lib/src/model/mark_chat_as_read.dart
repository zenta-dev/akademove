//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'mark_chat_as_read.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MarkChatAsRead {
  /// Returns a new [MarkChatAsRead] instance.
  const MarkChatAsRead({required this.orderId, this.lastReadMessageId});
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'lastReadMessageId', required: false, includeIfNull: false)
  final String? lastReadMessageId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkChatAsRead &&
          other.orderId == orderId &&
          other.lastReadMessageId == lastReadMessageId;

  @override
  int get hashCode => orderId.hashCode + lastReadMessageId.hashCode;

  factory MarkChatAsRead.fromJson(Map<String, dynamic> json) =>
      _$MarkChatAsReadFromJson(json);

  Map<String, dynamic> toJson() => _$MarkChatAsReadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
