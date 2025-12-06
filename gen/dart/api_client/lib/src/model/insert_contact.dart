//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_contact.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertContact {
  /// Returns a new [InsertContact] instance.
  const InsertContact({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    this.userId,
  });
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'subject', required: true, includeIfNull: false)
  final String subject;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertContact &&
          other.name == name &&
          other.email == email &&
          other.subject == subject &&
          other.message == message &&
          other.userId == userId;

  @override
  int get hashCode =>
      name.hashCode +
      email.hashCode +
      subject.hashCode +
      message.hashCode +
      userId.hashCode;

  factory InsertContact.fromJson(Map<String, dynamic> json) =>
      _$InsertContactFromJson(json);

  Map<String, dynamic> toJson() => _$InsertContactToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
