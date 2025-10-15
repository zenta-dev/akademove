//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_reset_password_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthResetPasswordRequest {
  /// Returns a new [AuthResetPasswordRequest] instance.
  AuthResetPasswordRequest({
    required this.token,

    required this.newPassword,

    required this.confirmPassword,
  });

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @JsonKey(name: r'newPassword', required: true, includeIfNull: false)
  final String newPassword;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthResetPasswordRequest &&
          other.token == token &&
          other.newPassword == newPassword &&
          other.confirmPassword == confirmPassword;

  @override
  int get hashCode =>
      token.hashCode + newPassword.hashCode + confirmPassword.hashCode;

  factory AuthResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResetPasswordRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
