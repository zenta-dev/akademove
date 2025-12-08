//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Merchant approval status
enum MerchantStatus {
  /// Merchant approval status
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),

  /// Merchant approval status
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),

  /// Merchant approval status
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),

  /// Merchant approval status
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),

  /// Merchant approval status
  @JsonValue(r'INACTIVE')
  INACTIVE(r'INACTIVE'),

  /// Merchant approval status
  @JsonValue(r'SUSPENDED')
  SUSPENDED(r'SUSPENDED');

  const MerchantStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
