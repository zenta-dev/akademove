//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'chat_unread_count.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChatUnreadCount {
  /// Returns a new [ChatUnreadCount] instance.
  const ChatUnreadCount({required this.orderId, required this.unreadCount});
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'unreadCount', required: true, includeIfNull: false)
  final int unreadCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUnreadCount &&
          other.orderId == orderId &&
          other.unreadCount == unreadCount;

  @override
  int get hashCode => orderId.hashCode + unreadCount.hashCode;

  factory ChatUnreadCount.fromJson(Map<String, dynamic> json) =>
      _$ChatUnreadCountFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUnreadCountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
