//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_create_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserCreateRequest {
  /// Returns a new [UserCreateRequest] instance.
  UserCreateRequest({
    required this.name,

    required this.email,

    required this.role,

    required this.gender,

    required this.phone,

    required this.password,

    required this.confirmPassword,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserCreateRequestRoleEnum role;

  @JsonKey(name: r'gender', required: true, includeIfNull: false)
  final UserCreateRequestGenderEnum gender;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final Phone phone;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCreateRequest &&
          other.name == name &&
          other.email == email &&
          other.role == role &&
          other.gender == gender &&
          other.phone == phone &&
          other.password == password &&
          other.confirmPassword == confirmPassword;

  @override
  int get hashCode =>
      name.hashCode +
      email.hashCode +
      role.hashCode +
      gender.hashCode +
      phone.hashCode +
      password.hashCode +
      confirmPassword.hashCode;

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UserCreateRequestRoleEnum {
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

  const UserCreateRequestRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UserCreateRequestGenderEnum {
  @JsonValue(r'male')
  male(r'male'),
  @JsonValue(r'female')
  female(r'female');

  const UserCreateRequestGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
