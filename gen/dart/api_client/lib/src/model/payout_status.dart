//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum PayoutStatus {
  @JsonValue(r'queued')
  queued(r'queued'),
  @JsonValue(r'processed')
  processed(r'processed'),
  @JsonValue(r'completed')
  completed(r'completed'),
  @JsonValue(r'failed')
  failed(r'failed');

  const PayoutStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
