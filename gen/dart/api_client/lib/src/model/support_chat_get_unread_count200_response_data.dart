//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_get_unread_count200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatGetUnreadCount200ResponseData {
  /// Returns a new [SupportChatGetUnreadCount200ResponseData] instance.
  const SupportChatGetUnreadCount200ResponseData({required this.unreadCount});
  @JsonKey(name: r'unreadCount', required: true, includeIfNull: false)
  final num unreadCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatGetUnreadCount200ResponseData &&
          other.unreadCount == unreadCount;

  @override
  int get hashCode => unreadCount.hashCode;

  factory SupportChatGetUnreadCount200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportChatGetUnreadCount200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupportChatGetUnreadCount200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
