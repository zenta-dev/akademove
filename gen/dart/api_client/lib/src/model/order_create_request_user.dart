//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/phone.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_user.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestUser {
  /// Returns a new [OrderCreateRequestUser] instance.
  OrderCreateRequestUser({

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

  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final String? id;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'emailVerified',
    required: false,
    includeIfNull: false,
  )


  final bool? emailVerified;



  @JsonKey(
    
    name: r'image',
    required: false,
    includeIfNull: false,
  )


  final String? image;



  @JsonKey(
    
    name: r'role',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestUserRoleEnum? role;



  @JsonKey(
    
    name: r'banned',
    required: false,
    includeIfNull: false,
  )


  final bool? banned;



  @JsonKey(
    
    name: r'banReason',
    required: false,
    includeIfNull: false,
  )


  final String? banReason;



  @JsonKey(
    
    name: r'banExpires',
    required: false,
    includeIfNull: false,
  )


  final DateTime? banExpires;



  @JsonKey(
    
    name: r'gender',
    required: false,
    includeIfNull: false,
  )


  final OrderCreateRequestUserGenderEnum? gender;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final Phone? phone;



  @JsonKey(
    
    name: r'createdAt',
    required: false,
    includeIfNull: false,
  )


  final DateTime? createdAt;



  @JsonKey(
    
    name: r'updatedAt',
    required: false,
    includeIfNull: false,
  )


  final DateTime? updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderCreateRequestUser &&
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

  factory OrderCreateRequestUser.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestUserFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum OrderCreateRequestUserRoleEnum {
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

const OrderCreateRequestUserRoleEnum(this.value);

final String value;

@override
String toString() => value;
}



enum OrderCreateRequestUserGenderEnum {
@JsonValue(r'male')
male(r'male'),
@JsonValue(r'female')
female(r'female');

const OrderCreateRequestUserGenderEnum(this.value);

final String value;

@override
String toString() => value;
}


