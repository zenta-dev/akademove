//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum BroadcastKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'title')
  title(r'title'),
  @JsonValue(r'message')
  message(r'message'),
  @JsonValue(r'type')
  type(r'type'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'targetAudience')
  targetAudience(r'targetAudience'),
  @JsonValue(r'targetIds')
  targetIds(r'targetIds'),
  @JsonValue(r'scheduledAt')
  scheduledAt(r'scheduledAt'),
  @JsonValue(r'sentAt')
  sentAt(r'sentAt'),
  @JsonValue(r'completedAt')
  completedAt(r'completedAt'),
  @JsonValue(r'failedCount')
  failedCount(r'failedCount'),
  @JsonValue(r'successCount')
  successCount(r'successCount'),
  @JsonValue(r'totalCount')
  totalCount(r'totalCount'),
  @JsonValue(r'createdBy')
  createdBy(r'createdBy'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt');

  const BroadcastKey(this.value);

  final String value;

  @override
  String toString() => value;
}
