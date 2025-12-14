//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum LeaderboardPeriod {
  @JsonValue(r'DAILY')
  DAILY(r'DAILY'),
  @JsonValue(r'WEEKLY')
  WEEKLY(r'WEEKLY'),
  @JsonValue(r'MONTHLY')
  MONTHLY(r'MONTHLY'),
  @JsonValue(r'QUARTERLY')
  QUARTERLY(r'QUARTERLY'),
  @JsonValue(r'YEARLY')
  YEARLY(r'YEARLY'),
  @JsonValue(r'ALL-TIME')
  ALL_TIME(r'ALL-TIME');

  const LeaderboardPeriod(this.value);

  final String value;

  @override
  String toString() => value;
}
