//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_gender.dart';
import 'package:api_client/src/model/user_role.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_place_order200_response_data_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderPlaceOrder200ResponseDataUser {
  /// Returns a new [OrderPlaceOrder200ResponseDataUser] instance.
  const OrderPlaceOrder200ResponseDataUser({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.image,
    this.role,
    this.banned,
    this.banReason,
    this.banExpires,
    this.gender,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'emailVerified', required: false, includeIfNull: false)
  final bool? emailVerified;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'role', required: false, includeIfNull: false)
  final UserRole? role;

  @JsonKey(name: r'banned', required: false, includeIfNull: false)
  final bool? banned;

  @JsonKey(name: r'banReason', required: false, includeIfNull: false)
  final String? banReason;

  @JsonKey(name: r'banExpires', required: false, includeIfNull: false)
  final DateTime? banExpires;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final UserGender? gender;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final Phone? phone;

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: false, includeIfNull: false)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderPlaceOrder200ResponseDataUser &&
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

  factory OrderPlaceOrder200ResponseDataUser.fromJson(
    Map<String, dynamic> json,
  ) => _$OrderPlaceOrder200ResponseDataUserFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderPlaceOrder200ResponseDataUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
