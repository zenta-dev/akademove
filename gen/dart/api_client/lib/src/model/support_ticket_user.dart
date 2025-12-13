//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_ticket_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportTicketUser {
  /// Returns a new [SupportTicketUser] instance.
  const SupportTicketUser({
    required this.name,
    this.image,
    required this.email,
  });
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportTicketUser &&
          other.name == name &&
          other.image == image &&
          other.email == email;

  @override
  int get hashCode =>
      name.hashCode + (image == null ? 0 : image.hashCode) + email.hashCode;

  factory SupportTicketUser.fromJson(Map<String, dynamic> json) =>
      _$SupportTicketUserFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
