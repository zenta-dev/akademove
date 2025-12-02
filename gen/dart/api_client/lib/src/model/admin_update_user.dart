//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/unban_user.dart';
import 'package:api_client/src/model/user_role.dart';
import 'package:api_client/src/model/update_user_password.dart';
import 'package:api_client/src/model/ban_user.dart';
import 'package:api_client/src/model/update_user_role.dart';
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
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.banReason,
    this.banExpiresIn,
    required this.id,
  });

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRole role;

  @JsonKey(name: r'oldPassword', required: true, includeIfNull: false)
  final String oldPassword;

  @JsonKey(name: r'newPassword', required: true, includeIfNull: false)
  final String newPassword;

  @JsonKey(name: r'confirmNewPassword', required: true, includeIfNull: false)
  final String confirmNewPassword;

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
          other.oldPassword == oldPassword &&
          other.newPassword == newPassword &&
          other.confirmNewPassword == confirmNewPassword &&
          other.banReason == banReason &&
          other.banExpiresIn == banExpiresIn &&
          other.id == id;

  @override
  int get hashCode =>
      role.hashCode +
      oldPassword.hashCode +
      newPassword.hashCode +
      confirmNewPassword.hashCode +
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
