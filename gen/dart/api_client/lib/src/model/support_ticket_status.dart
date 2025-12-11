//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SupportTicketStatus {
      @JsonValue(r'OPEN')
      OPEN(r'OPEN'),
      @JsonValue(r'IN_PROGRESS')
      IN_PROGRESS(r'IN_PROGRESS'),
      @JsonValue(r'WAITING_USER')
      WAITING_USER(r'WAITING_USER'),
      @JsonValue(r'RESOLVED')
      RESOLVED(r'RESOLVED'),
      @JsonValue(r'CLOSED')
      CLOSED(r'CLOSED');

  const SupportTicketStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
