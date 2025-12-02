//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum ContactStatus {
      @JsonValue(r'PENDING')
      PENDING(r'PENDING'),
      @JsonValue(r'REVIEWING')
      REVIEWING(r'REVIEWING'),
      @JsonValue(r'RESOLVED')
      RESOLVED(r'RESOLVED'),
      @JsonValue(r'CLOSED')
      CLOSED(r'CLOSED');

  const ContactStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
