//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TransactionStatus {
  @JsonValue(r'pending')
  pending(r'pending'),
  @JsonValue(r'success')
  success(r'success'),
  @JsonValue(r'failed')
  failed(r'failed'),
  @JsonValue(r'cancelled')
  cancelled(r'cancelled'),
  @JsonValue(r'expired')
  expired(r'expired'),
  @JsonValue(r'refunded')
  refunded(r'refunded');

  const TransactionStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
