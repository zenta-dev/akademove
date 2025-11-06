//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_user_password.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateUserPassword {
  /// Returns a new [UpdateUserPassword] instance.
  const UpdateUserPassword({
    required this.password,
    required this.confirmPassword,
  });

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateUserPassword &&
          other.password == password &&
          other.confirmPassword == confirmPassword;

  @override
  int get hashCode => password.hashCode + confirmPassword.hashCode;

  factory UpdateUserPassword.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPasswordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
