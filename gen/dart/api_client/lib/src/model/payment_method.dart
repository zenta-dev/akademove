//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum PaymentMethod {
      @JsonValue(r'QRIS')
      QRIS(r'QRIS'),
      @JsonValue(r'BANK_TRANSFER')
      BANK_TRANSFER(r'BANK_TRANSFER'),
      @JsonValue(r'WALLET')
      WALLET(r'WALLET');

  const PaymentMethod(this.value);

  final String value;

  @override
  String toString() => value;
}
