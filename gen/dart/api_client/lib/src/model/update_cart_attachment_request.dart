//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_cart_attachment_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateCartAttachmentRequest {
  /// Returns a new [UpdateCartAttachmentRequest] instance.
  const UpdateCartAttachmentRequest({required this.attachmentUrl});
  @JsonKey(name: r'attachmentUrl', required: true, includeIfNull: true)
  final String? attachmentUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateCartAttachmentRequest &&
          other.attachmentUrl == attachmentUrl;

  @override
  int get hashCode => (attachmentUrl == null ? 0 : attachmentUrl.hashCode);

  factory UpdateCartAttachmentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartAttachmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartAttachmentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
