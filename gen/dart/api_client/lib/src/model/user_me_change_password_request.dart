//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_me_change_password_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserMeChangePasswordRequest {
  /// Returns a new [UserMeChangePasswordRequest] instance.
  const UserMeChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });
  @JsonKey(name: r'oldPassword', required: true, includeIfNull: false)
  final String oldPassword;

  @JsonKey(name: r'newPassword', required: true, includeIfNull: false)
  final String newPassword;

  @JsonKey(name: r'confirmNewPassword', required: true, includeIfNull: false)
  final String confirmNewPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserMeChangePasswordRequest &&
          other.oldPassword == oldPassword &&
          other.newPassword == newPassword &&
          other.confirmNewPassword == confirmNewPassword;

  @override
  int get hashCode =>
      oldPassword.hashCode + newPassword.hashCode + confirmNewPassword.hashCode;

  factory UserMeChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UserMeChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserMeChangePasswordRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
