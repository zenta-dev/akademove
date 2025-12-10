//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SupportTicketCategory {
      @JsonValue(r'GENERAL')
      GENERAL(r'GENERAL'),
      @JsonValue(r'ORDER_ISSUE')
      ORDER_ISSUE(r'ORDER_ISSUE'),
      @JsonValue(r'PAYMENT_ISSUE')
      PAYMENT_ISSUE(r'PAYMENT_ISSUE'),
      @JsonValue(r'DRIVER_COMPLAINT')
      DRIVER_COMPLAINT(r'DRIVER_COMPLAINT'),
      @JsonValue(r'MERCHANT_COMPLAINT')
      MERCHANT_COMPLAINT(r'MERCHANT_COMPLAINT'),
      @JsonValue(r'ACCOUNT_ISSUE')
      ACCOUNT_ISSUE(r'ACCOUNT_ISSUE'),
      @JsonValue(r'TECHNICAL_ISSUE')
      TECHNICAL_ISSUE(r'TECHNICAL_ISSUE'),
      @JsonValue(r'FEATURE_REQUEST')
      FEATURE_REQUEST(r'FEATURE_REQUEST'),
      @JsonValue(r'OTHER')
      OTHER(r'OTHER');

  const SupportTicketCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
