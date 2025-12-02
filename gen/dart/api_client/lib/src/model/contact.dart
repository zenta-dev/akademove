//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/contact_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'contact.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Contact {
  /// Returns a new [Contact] instance.
  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.status,
    this.userId,
    this.respondedById,
    this.response,
    required this.createdAt,
    required this.updatedAt,
    this.respondedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'subject', required: true, includeIfNull: false)
  final String subject;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final ContactStatus status;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'respondedById', required: false, includeIfNull: false)
  final String? respondedById;

  @JsonKey(name: r'response', required: false, includeIfNull: false)
  final String? response;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'respondedAt', required: false, includeIfNull: false)
  final DateTime? respondedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          other.id == id &&
          other.name == name &&
          other.email == email &&
          other.subject == subject &&
          other.message == message &&
          other.status == status &&
          other.userId == userId &&
          other.respondedById == respondedById &&
          other.response == response &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.respondedAt == respondedAt;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      email.hashCode +
      subject.hashCode +
      message.hashCode +
      status.hashCode +
      userId.hashCode +
      respondedById.hashCode +
      response.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      respondedAt.hashCode;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
