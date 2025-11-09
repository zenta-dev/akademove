//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ReportKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'orderId')
  orderId(r'orderId'),
  @JsonValue(r'reporterId')
  reporterId(r'reporterId'),
  @JsonValue(r'targetUserId')
  targetUserId(r'targetUserId'),
  @JsonValue(r'category')
  category(r'category'),
  @JsonValue(r'description')
  description(r'description'),
  @JsonValue(r'evidenceUrl')
  evidenceUrl(r'evidenceUrl'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'handledById')
  handledById(r'handledById'),
  @JsonValue(r'resolution')
  resolution(r'resolution'),
  @JsonValue(r'reportedAt')
  reportedAt(r'reportedAt'),
  @JsonValue(r'resolvedAt')
  resolvedAt(r'resolvedAt');

  const ReportKey(this.value);

  final String value;

  @override
  String toString() => value;
}
