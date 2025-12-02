//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_chat_message_list_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderChatMessageListQuery {
  /// Returns a new [OrderChatMessageListQuery] instance.
  const OrderChatMessageListQuery({
    required this.orderId,
    required this.limit,
    this.cursor,
  });

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  // minimum: -9007199254740991
  // maximum: 100
  @JsonKey(name: r'limit', required: true, includeIfNull: false)
  final int limit;

  @JsonKey(name: r'cursor', required: false, includeIfNull: false)
  final String? cursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderChatMessageListQuery &&
          other.orderId == orderId &&
          other.limit == limit &&
          other.cursor == cursor;

  @override
  int get hashCode => orderId.hashCode + limit.hashCode + cursor.hashCode;

  factory OrderChatMessageListQuery.fromJson(Map<String, dynamic> json) =>
      _$OrderChatMessageListQueryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderChatMessageListQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
