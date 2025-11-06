//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/user_role.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertUser {
  /// Returns a new [InsertUser] instance.
  const InsertUser({
    required this.name,
    required this.email,
    required this.role,
    this.gender,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRole role;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final Phone phone;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'confirmPassword', required: true, includeIfNull: false)
  final String confirmPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertUser &&
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

  factory InsertUser.fromJson(Map<String, dynamic> json) =>
      _$InsertUserFromJson(json);

  Map<String, dynamic> toJson() => _$InsertUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
