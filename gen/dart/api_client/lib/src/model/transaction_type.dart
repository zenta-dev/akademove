//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TransactionType {
  @JsonValue(r'topup')
  topup(r'topup'),
  @JsonValue(r'withdraw')
  withdraw(r'withdraw'),
  @JsonValue(r'payment')
  payment(r'payment'),
  @JsonValue(r'refund')
  refund(r'refund'),
  @JsonValue(r'adjustment')
  adjustment(r'adjustment');

  const TransactionType(this.value);

  final String value;

  @override
  String toString() => value;
}
