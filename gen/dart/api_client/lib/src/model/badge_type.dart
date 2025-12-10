//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum BadgeType {
      @JsonValue(r'ACHIEVEMENT')
      ACHIEVEMENT(r'ACHIEVEMENT'),
      @JsonValue(r'PERFORMANCE')
      PERFORMANCE(r'PERFORMANCE'),
      @JsonValue(r'VOLUME')
      VOLUME(r'VOLUME'),
      @JsonValue(r'STREAK')
      STREAK(r'STREAK'),
      @JsonValue(r'MILESTONE')
      MILESTONE(r'MILESTONE'),
      @JsonValue(r'SPECIAL')
      SPECIAL(r'SPECIAL');

  const BadgeType(this.value);

  final String value;

  @override
  String toString() => value;
}
