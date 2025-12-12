//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum SupportTicketPriority {
  @JsonValue(r'LOW')
  LOW(r'LOW'),
  @JsonValue(r'MEDIUM')
  MEDIUM(r'MEDIUM'),
  @JsonValue(r'HIGH')
  HIGH(r'HIGH'),
  @JsonValue(r'URGENT')
  URGENT(r'URGENT');

  const SupportTicketPriority(this.value);

  final String value;

  @override
  String toString() => value;
}
