//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReportCategory {
  @JsonValue(r'behavior')
  behavior(r'behavior'),
  @JsonValue(r'safety')
  safety(r'safety'),
  @JsonValue(r'fraud')
  fraud(r'fraud'),
  @JsonValue(r'other')
  other(r'other');

  const ReportCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
