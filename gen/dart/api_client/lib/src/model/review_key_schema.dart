//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReviewKeySchema {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'orderId')
  orderId(r'orderId'),
  @JsonValue(r'fromUserId')
  fromUserId(r'fromUserId'),
  @JsonValue(r'toUserId')
  toUserId(r'toUserId'),
  @JsonValue(r'categories')
  categories(r'categories'),
  @JsonValue(r'score')
  score(r'score'),
  @JsonValue(r'comment')
  comment(r'comment'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt');

  const ReviewKeySchema(this.value);

  final String value;

  @override
  String toString() => value;
}
