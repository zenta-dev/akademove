//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_mark_as_read_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatMarkAsReadRequest {
  /// Returns a new [SupportChatMarkAsReadRequest] instance.
  const SupportChatMarkAsReadRequest({required this.ticketId});
  @JsonKey(name: r'ticketId', required: true, includeIfNull: false)
  final String ticketId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportChatMarkAsReadRequest && other.ticketId == ticketId;

  @override
  int get hashCode => ticketId.hashCode;

  factory SupportChatMarkAsReadRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportChatMarkAsReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupportChatMarkAsReadRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
