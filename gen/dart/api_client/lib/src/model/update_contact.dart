//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/contact_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_contact.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateContact {
  /// Returns a new [UpdateContact] instance.
  const UpdateContact({
    this.name,
    this.email,
    this.subject,
    this.message,
    this.status,
    this.userId,
    this.respondedById,
    this.response,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'subject', required: false, includeIfNull: false)
  final String? subject;

  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final String? message;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final ContactStatus? status;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'respondedById', required: false, includeIfNull: false)
  final String? respondedById;

  @JsonKey(name: r'response', required: false, includeIfNull: false)
  final String? response;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateContact &&
          other.name == name &&
          other.email == email &&
          other.subject == subject &&
          other.message == message &&
          other.status == status &&
          other.userId == userId &&
          other.respondedById == respondedById &&
          other.response == response;

  @override
  int get hashCode =>
      name.hashCode +
      email.hashCode +
      subject.hashCode +
      message.hashCode +
      status.hashCode +
      userId.hashCode +
      respondedById.hashCode +
      response.hashCode;

  factory UpdateContact.fromJson(Map<String, dynamic> json) =>
      _$UpdateContactFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
