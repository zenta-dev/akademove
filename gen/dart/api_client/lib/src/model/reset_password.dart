//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'reset_password.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResetPassword {
  /// Returns a new [ResetPassword] instance.
  const ResetPassword({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'newPassword', required: true, includeIfNull: false)
  final String newPassword;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResetPassword &&
          other.email == email &&
          other.code == code &&
          other.newPassword == newPassword &&
          other.confirmPassword == confirmPassword;

  @override
  int get hashCode =>
      email.hashCode +
      code.hashCode +
      newPassword.hashCode +
      confirmPassword.hashCode;

  factory ResetPassword.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
