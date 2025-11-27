//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TransactionStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'SUCCESS')
  SUCCESS(r'SUCCESS'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED'),
  @JsonValue(r'CANCELLED')
  CANCELLED(r'CANCELLED'),
  @JsonValue(r'EXPIRED')
  EXPIRED(r'EXPIRED'),
  @JsonValue(r'REFUNDED')
  REFUNDED(r'REFUNDED');

  const TransactionStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
