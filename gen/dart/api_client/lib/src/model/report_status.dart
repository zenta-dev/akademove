//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReportStatus {
  @JsonValue(r'pending')
  pending(r'pending'),
  @JsonValue(r'investigating')
  investigating(r'investigating'),
  @JsonValue(r'resolved')
  resolved(r'resolved'),
  @JsonValue(r'dismissed')
  dismissed(r'dismissed');

  const ReportStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
