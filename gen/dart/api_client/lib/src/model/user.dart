//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class User {
  /// Returns a new [User] instance.
  User({
    required this.id,

    required this.name,

    required this.email,

    required this.emailVerified,

    this.image,

    required this.role,

    required this.banned,

    this.banReason,

    this.banExpires,

    required this.gender,

    required this.phone,

    required this.createdAt,

    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'emailVerified', required: true, includeIfNull: false)
  final bool emailVerified;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRoleEnum role;

  @JsonKey(name: r'banned', required: true, includeIfNull: false)
  final bool banned;

  @JsonKey(name: r'banReason', required: false, includeIfNull: false)
  final String? banReason;

  @JsonKey(name: r'banExpires', required: false, includeIfNull: false)
  final DateTime? banExpires;

  @JsonKey(name: r'gender', required: true, includeIfNull: false)
  final UserGenderEnum gender;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          other.id == id &&
          other.name == name &&
          other.email == email &&
          other.emailVerified == emailVerified &&
          other.image == image &&
          other.role == role &&
          other.banned == banned &&
          other.banReason == banReason &&
          other.banExpires == banExpires &&
          other.gender == gender &&
          other.phone == phone &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      email.hashCode +
      emailVerified.hashCode +
      image.hashCode +
      role.hashCode +
      banned.hashCode +
      banReason.hashCode +
      banExpires.hashCode +
      gender.hashCode +
      phone.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UserRoleEnum {
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

  const UserRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UserGenderEnum {
  @JsonValue(r'male')
  male(r'male'),
  @JsonValue(r'female')
  female(r'female');

  const UserGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
