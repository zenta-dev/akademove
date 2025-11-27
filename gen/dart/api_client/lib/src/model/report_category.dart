//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReportCategory {
  @JsonValue(r'BEHAVIOR')
  BEHAVIOR(r'BEHAVIOR'),
  @JsonValue(r'SAFETY')
  SAFETY(r'SAFETY'),
  @JsonValue(r'FRAUD')
  FRAUD(r'FRAUD'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const ReportCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
