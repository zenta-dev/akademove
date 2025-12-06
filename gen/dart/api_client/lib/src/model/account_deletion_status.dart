//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AccountDeletionStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'REVIEWING')
  REVIEWING(r'REVIEWING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED');

  const AccountDeletionStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
