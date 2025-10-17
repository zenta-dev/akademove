//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserUpdateRequest {
  /// Returns a new [UserUpdateRequest] instance.
  UserUpdateRequest({
    required this.role,

    required this.password,

    required this.confirmPassword,

    required this.banReason,

    this.banExpiresIn,

    required this.id,
  });

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserUpdateRequestRoleEnum role;

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
      other is UserUpdateRequest &&
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

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UserUpdateRequestRoleEnum {
  @JsonValue(r'admin')
  admin(r'admin'),
  @JsonValue(r'operator')
  operator_(r'operator'),
  @JsonValue(r'merchant')
  merchant(r'merchant'),
  @JsonValue(r'driver')
  driver(r'driver'),
  @JsonValue(r'user')
  user(r'user');

  const UserUpdateRequestRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
