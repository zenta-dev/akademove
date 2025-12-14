//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_mark_as_read200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatMarkAsRead200ResponseData {
  /// Returns a new [SupportChatMarkAsRead200ResponseData] instance.
  const SupportChatMarkAsRead200ResponseData({required this.count});
  @JsonKey(name: r'count', required: true, includeIfNull: false)
  final num count;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatMarkAsRead200ResponseData && other.count == count;

  @override
  int get hashCode => count.hashCode;

  factory SupportChatMarkAsRead200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportChatMarkAsRead200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupportChatMarkAsRead200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
