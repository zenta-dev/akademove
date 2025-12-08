//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ContactKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'email')
  email(r'email'),
  @JsonValue(r'subject')
  subject(r'subject'),
  @JsonValue(r'message')
  message(r'message'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'userId')
  userId(r'userId'),
  @JsonValue(r'respondedById')
  respondedById(r'respondedById'),
  @JsonValue(r'response')
  response(r'response'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt'),
  @JsonValue(r'respondedAt')
  respondedAt(r'respondedAt');

  const ContactKey(this.value);

  final String value;

  @override
  String toString() => value;
}
