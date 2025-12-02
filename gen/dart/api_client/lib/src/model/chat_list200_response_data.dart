//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_chat_message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'chat_list200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChatList200ResponseData {
  /// Returns a new [ChatList200ResponseData] instance.
  const ChatList200ResponseData({
    required this.rows,
    required this.hasMore,
     this.nextCursor,
  });

  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<OrderChatMessage> rows;
  
  @JsonKey(name: r'hasMore', required: true, includeIfNull: false)
  final bool hasMore;
  
  @JsonKey(name: r'nextCursor', required: false, includeIfNull: false)
  final String? nextCursor;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatList200ResponseData &&
    other.rows == rows &&
    other.hasMore == hasMore &&
    other.nextCursor == nextCursor;

  @override
  int get hashCode =>
      rows.hashCode +
      hasMore.hashCode +
      nextCursor.hashCode;

  factory ChatList200ResponseData.fromJson(Map<String, dynamic> json) => _$ChatList200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatList200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

