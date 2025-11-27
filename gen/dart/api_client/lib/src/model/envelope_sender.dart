//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Envelope sender: 's' for server, 'c' for client
enum EnvelopeSender {
  /// Envelope sender: 's' for server, 'c' for client
  @JsonValue(r's')
  s(r's'),

  /// Envelope sender: 's' for server, 'c' for client
  @JsonValue(r'c')
  c(r'c');

  const EnvelopeSender(this.value);

  final String value;

  @override
  String toString() => value;
}
