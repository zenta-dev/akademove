//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TransactionKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'walletId')
  walletId(r'walletId'),
  @JsonValue(r'type')
  type(r'type'),
  @JsonValue(r'amount')
  amount(r'amount'),
  @JsonValue(r'balanceBefore')
  balanceBefore(r'balanceBefore'),
  @JsonValue(r'balanceAfter')
  balanceAfter(r'balanceAfter'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'description')
  description(r'description'),
  @JsonValue(r'referenceId')
  referenceId(r'referenceId'),
  @JsonValue(r'metadata')
  metadata(r'metadata'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt');

  const TransactionKey(this.value);

  final String value;

  @override
  String toString() => value;
}
