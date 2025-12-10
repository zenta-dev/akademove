//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_message_list_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatMessageListQuery {
  /// Returns a new [SupportChatMessageListQuery] instance.
  const SupportChatMessageListQuery({
    required this.ticketId,
    this.limit = 50,
    this.cursor,
  });
  @JsonKey(name: r'ticketId', required: true, includeIfNull: true)
  final String? ticketId;

  // minimum: -9007199254740991
  // maximum: 1000
  @JsonKey(
    defaultValue: 50,
    name: r'limit',
    required: false,
    includeIfNull: false,
  )
  final int? limit;

  @JsonKey(name: r'cursor', required: false, includeIfNull: false)
  final String? cursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatMessageListQuery &&
          other.ticketId == ticketId &&
          other.limit == limit &&
          other.cursor == cursor;

  @override
  int get hashCode =>
      (ticketId == null ? 0 : ticketId.hashCode) +
      limit.hashCode +
      (cursor == null ? 0 : cursor.hashCode);

  factory SupportChatMessageListQuery.fromJson(Map<String, dynamic> json) =>
      _$SupportChatMessageListQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SupportChatMessageListQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
