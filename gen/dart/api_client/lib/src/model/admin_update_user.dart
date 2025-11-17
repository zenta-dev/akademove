//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_role.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'admin_update_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AdminUpdateUser {
  /// Returns a new [AdminUpdateUser] instance.
  const AdminUpdateUser({
    required this.role,
    required this.password,
    required this.confirmPassword,
    required this.banReason,
    this.banExpiresIn,
    required this.id,
  });

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRole role;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @JsonKey(name: r'banReason', required: true, includeIfNull: false)
  final String banReason;

  @JsonKey(name: r'banExpiresIn', required: false, includeIfNull: false)
  final num? banExpiresIn;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminUpdateUser &&
          other.role == role &&
          other.password == password &&
          other.confirmPassword == confirmPassword &&
          other.banReason == banReason &&
          other.banExpiresIn == banExpiresIn &&
          other.id == id;

  @override
  int get hashCode =>
      role.hashCode +
      password.hashCode +
      confirmPassword.hashCode +
      banReason.hashCode +
      banExpiresIn.hashCode +
      id.hashCode;

  factory AdminUpdateUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
