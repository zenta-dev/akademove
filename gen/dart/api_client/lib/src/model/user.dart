//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_badge.dart';
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/user_role.dart';
import 'package:api_client/src/model/phone.dart';
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
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.image,
    required this.role,
    required this.banned,
    this.banReason,
    this.banExpires,
    this.gender,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.userBadges,
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
  final UserRole role;

  @JsonKey(name: r'banned', required: true, includeIfNull: false)
  final bool banned;

  @JsonKey(name: r'banReason', required: false, includeIfNull: false)
  final String? banReason;

  @JsonKey(name: r'banExpires', required: false, includeIfNull: false)
  final DateTime? banExpires;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final Phone phone;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'userBadges', required: true, includeIfNull: false)
  final List<UserBadge> userBadges;

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
          other.updatedAt == updatedAt &&
          other.userBadges == userBadges;

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
      updatedAt.hashCode +
      userBadges.hashCode;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
