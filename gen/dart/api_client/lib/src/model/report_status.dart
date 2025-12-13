//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReportStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'INVESTIGATING')
  INVESTIGATING(r'INVESTIGATING'),
  @JsonValue(r'RESOLVED')
  RESOLVED(r'RESOLVED'),
  @JsonValue(r'DISMISSED')
  DISMISSED(r'DISMISSED');

  const ReportStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
