//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum TransactionType {
      @JsonValue(r'TOPUP')
      TOPUP(r'TOPUP'),
      @JsonValue(r'WITHDRAW')
      WITHDRAW(r'WITHDRAW'),
      @JsonValue(r'PAYMENT')
      PAYMENT(r'PAYMENT'),
      @JsonValue(r'REFUND')
      REFUND(r'REFUND'),
      @JsonValue(r'ADJUSTMENT')
      ADJUSTMENT(r'ADJUSTMENT'),
      @JsonValue(r'COMMISSION')
      COMMISSION(r'COMMISSION'),
      @JsonValue(r'EARNING')
      EARNING(r'EARNING');

  const TransactionType(this.value);

  final String value;

  @override
  String toString() => value;
}
