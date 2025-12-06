//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum BroadcastStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'SENDING')
  SENDING(r'SENDING'),
  @JsonValue(r'SENT')
  SENT(r'SENT'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');

  const BroadcastStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
