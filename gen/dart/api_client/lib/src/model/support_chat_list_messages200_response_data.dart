//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_chat_message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_list_messages200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatListMessages200ResponseData {
  /// Returns a new [SupportChatListMessages200ResponseData] instance.
  const SupportChatListMessages200ResponseData({
    required this.rows,
    required this.hasMore,
    this.nextCursor,
  });
  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<SupportChatMessage> rows;

  @JsonKey(name: r'hasMore', required: true, includeIfNull: false)
  final bool hasMore;

  @JsonKey(name: r'nextCursor', required: false, includeIfNull: false)
  final String? nextCursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatListMessages200ResponseData &&
          other.rows == rows &&
          other.hasMore == hasMore &&
          other.nextCursor == nextCursor;

  @override
  int get hashCode => rows.hashCode + hasMore.hashCode + nextCursor.hashCode;

  factory SupportChatListMessages200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportChatListMessages200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupportChatListMessages200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
