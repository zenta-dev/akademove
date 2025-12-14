//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_list_tickets200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatListTickets200ResponseData {
  /// Returns a new [SupportChatListTickets200ResponseData] instance.
  const SupportChatListTickets200ResponseData({
    required this.rows,
    required this.hasMore,
    this.nextCursor,
  });
  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<SupportTicket> rows;

  @JsonKey(name: r'hasMore', required: true, includeIfNull: false)
  final bool hasMore;

  @JsonKey(name: r'nextCursor', required: false, includeIfNull: false)
  final String? nextCursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatListTickets200ResponseData &&
          other.rows == rows &&
          other.hasMore == hasMore &&
          other.nextCursor == nextCursor;

  @override
  int get hashCode => rows.hashCode + hasMore.hashCode + nextCursor.hashCode;

  factory SupportChatListTickets200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportChatListTickets200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupportChatListTickets200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
