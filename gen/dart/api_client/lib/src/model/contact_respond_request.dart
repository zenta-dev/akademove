//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'contact_respond_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ContactRespondRequest {
  /// Returns a new [ContactRespondRequest] instance.
  const ContactRespondRequest({required this.response, this.status});

  @JsonKey(name: r'response', required: true, includeIfNull: false)
  final String response;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final ContactRespondRequestStatusEnum? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactRespondRequest &&
          other.response == response &&
          other.status == status;

  @override
  int get hashCode => response.hashCode + status.hashCode;

  factory ContactRespondRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactRespondRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRespondRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ContactRespondRequestStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'REVIEWING')
  REVIEWING(r'REVIEWING'),
  @JsonValue(r'RESOLVED')
  RESOLVED(r'RESOLVED'),
  @JsonValue(r'CLOSED')
  CLOSED(r'CLOSED');

  const ContactRespondRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
