//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum LeaderboardCategory {
  @JsonValue(r'RATING')
  RATING(r'RATING'),
  @JsonValue(r'VOLUME')
  VOLUME(r'VOLUME'),
  @JsonValue(r'EARNINGS')
  EARNINGS(r'EARNINGS'),
  @JsonValue(r'STREAK')
  STREAK(r'STREAK'),
  @JsonValue(r'ON-TIME')
  ON_TIME(r'ON-TIME'),
  @JsonValue(r'COMPLETION-RATE')
  COMPLETION_RATE(r'COMPLETION-RATE');

  const LeaderboardCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
