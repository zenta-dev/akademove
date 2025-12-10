//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_fraud_profile_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserFraudProfileUser {
  /// Returns a new [UserFraudProfileUser] instance.
  const UserFraudProfileUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final String role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFraudProfileUser &&
          other.id == id &&
          other.name == name &&
          other.email == email &&
          other.role == role;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + email.hashCode + role.hashCode;

  factory UserFraudProfileUser.fromJson(Map<String, dynamic> json) =>
      _$UserFraudProfileUserFromJson(json);

  Map<String, dynamic> toJson() => _$UserFraudProfileUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
