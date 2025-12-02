//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_user_password.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class UpdateUserPassword {
  /// Returns a new [UpdateUserPassword] instance.
  const UpdateUserPassword({required this.oldPassword, required this.newPassword, required this.confirmNewPassword});

  @JsonKey(name: r'oldPassword', required: true, includeIfNull: false)
  final String oldPassword;

  @JsonKey(name: r'newPassword', required: true, includeIfNull: false)
  final String newPassword;

  @JsonKey(name: r'confirmNewPassword', required: true, includeIfNull: false)
  final String confirmNewPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateUserPassword &&
          other.oldPassword == oldPassword &&
          other.newPassword == newPassword &&
          other.confirmNewPassword == confirmNewPassword;

  @override
  int get hashCode => oldPassword.hashCode + newPassword.hashCode + confirmNewPassword.hashCode;

  factory UpdateUserPassword.fromJson(Map<String, dynamic> json) => _$UpdateUserPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPasswordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
