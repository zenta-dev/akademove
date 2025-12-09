//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Envelope target
enum EnvelopeTarget {
          /// Envelope target
      @JsonValue(r'ADMIN')
      ADMIN(r'ADMIN'),
          /// Envelope target
      @JsonValue(r'OPERATOR')
      OPERATOR(r'OPERATOR'),
          /// Envelope target
      @JsonValue(r'MERCHANT')
      MERCHANT(r'MERCHANT'),
          /// Envelope target
      @JsonValue(r'DRIVER')
      DRIVER(r'DRIVER'),
          /// Envelope target
      @JsonValue(r'USER')
      USER(r'USER'),
          /// Envelope target
      @JsonValue(r'SYSTEM')
      SYSTEM(r'SYSTEM'),
          /// Envelope target
      @JsonValue(r'ALL')
      ALL(r'ALL');

  const EnvelopeTarget(this.value);

  final String value;

  @override
  String toString() => value;
}
