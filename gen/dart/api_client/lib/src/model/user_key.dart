//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum UserKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'email')
  email(r'email'),
  @JsonValue(r'emailVerified')
  emailVerified(r'emailVerified'),
  @JsonValue(r'image')
  image(r'image'),
  @JsonValue(r'role')
  role(r'role'),
  @JsonValue(r'banned')
  banned(r'banned'),
  @JsonValue(r'banReason')
  banReason(r'banReason'),
  @JsonValue(r'banExpires')
  banExpires(r'banExpires'),
  @JsonValue(r'gender')
  gender(r'gender'),
  @JsonValue(r'phone')
  phone(r'phone'),
  @JsonValue(r'rating')
  rating(r'rating'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt');

  const UserKey(this.value);

  final String value;

  @override
  String toString() => value;
}
