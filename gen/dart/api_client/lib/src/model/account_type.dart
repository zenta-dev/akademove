//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AccountType {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT');

  const AccountType(this.value);

  final String value;

  @override
  String toString() => value;
}
