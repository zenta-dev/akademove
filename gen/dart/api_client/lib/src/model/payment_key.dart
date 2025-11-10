//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum PaymentKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'transactionId')
  transactionId(r'transactionId'),
  @JsonValue(r'provider')
  provider(r'provider'),
  @JsonValue(r'method')
  method(r'method'),
  @JsonValue(r'amount')
  amount(r'amount'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'externalId')
  externalId(r'externalId'),
  @JsonValue(r'paymentUrl')
  paymentUrl(r'paymentUrl'),
  @JsonValue(r'metadata')
  metadata(r'metadata'),
  @JsonValue(r'expiresAt')
  expiresAt(r'expiresAt'),
  @JsonValue(r'payload')
  payload(r'payload'),
  @JsonValue(r'response')
  response(r'response'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt');

  const PaymentKey(this.value);

  final String value;

  @override
  String toString() => value;
}
