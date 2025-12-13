//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReviewCategory {
  @JsonValue(r'CLEANLINESS')
  CLEANLINESS(r'CLEANLINESS'),
  @JsonValue(r'COURTESY')
  COURTESY(r'COURTESY'),
  @JsonValue(r'PUNCTUALITY')
  PUNCTUALITY(r'PUNCTUALITY'),
  @JsonValue(r'SAFETY')
  SAFETY(r'SAFETY'),
  @JsonValue(r'COMMUNICATION')
  COMMUNICATION(r'COMMUNICATION'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const ReviewCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
