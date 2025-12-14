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
    this.phone,
    this.rating = 0,
  });
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRole role;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final Phone? phone;

  // minimum: 0
  // maximum: 5
  @JsonKey(
    defaultValue: 0,
    name: r'rating',
    required: false,
    includeIfNull: false,
  )
  final num? rating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertUser &&
          other.name == name &&
          other.email == email &&
          other.role == role &&
          other.gender == gender &&
          other.phone == phone &&
          other.rating == rating;

  @override
  int get hashCode =>
      name.hashCode +
      email.hashCode +
      role.hashCode +
      gender.hashCode +
      phone.hashCode +
      rating.hashCode;

  factory InsertUser.fromJson(Map<String, dynamic> json) =>
      _$InsertUserFromJson(json);

  Map<String, dynamic> toJson() => _$InsertUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
