//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReviewCategory {
  @JsonValue(r'cleanliness')
  cleanliness(r'cleanliness'),
  @JsonValue(r'courtesy')
  courtesy(r'courtesy'),
  @JsonValue(r'other')
  other(r'other');

  const ReviewCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
