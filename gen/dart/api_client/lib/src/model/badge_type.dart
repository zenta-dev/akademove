//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum BadgeType {
  @JsonValue(r'performance')
  performance(r'performance'),
  @JsonValue(r'volume')
  volume(r'volume'),
  @JsonValue(r'streak')
  streak(r'streak'),
  @JsonValue(r'milestone')
  milestone(r'milestone'),
  @JsonValue(r'special')
  special(r'special');

  const BadgeType(this.value);

  final String value;

  @override
  String toString() => value;
}
