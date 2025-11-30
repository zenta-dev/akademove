//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum DriverStatus {
      @JsonValue(r'PENDING')
      PENDING(r'PENDING'),
      @JsonValue(r'APPROVED')
      APPROVED(r'APPROVED'),
      @JsonValue(r'REJECTED')
      REJECTED(r'REJECTED'),
      @JsonValue(r'ACTIVE')
      ACTIVE(r'ACTIVE'),
      @JsonValue(r'INACTIVE')
      INACTIVE(r'INACTIVE'),
      @JsonValue(r'SUSPENDED')
      SUSPENDED(r'SUSPENDED');

  const DriverStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
