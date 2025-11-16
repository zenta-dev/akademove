//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum BadgeLevel {
  @JsonValue(r'bronze')
  bronze(r'bronze'),
  @JsonValue(r'silver')
  silver(r'silver'),
  @JsonValue(r'gold')
  gold(r'gold'),
  @JsonValue(r'platinum')
  platinum(r'platinum'),
  @JsonValue(r'diamond')
  diamond(r'diamond');

  const BadgeLevel(this.value);

  final String value;

  @override
  String toString() => value;
}
