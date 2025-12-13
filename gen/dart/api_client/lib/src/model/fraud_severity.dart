//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum FraudSeverity {
      @JsonValue(r'LOW')
      LOW(r'LOW'),
      @JsonValue(r'MEDIUM')
      MEDIUM(r'MEDIUM'),
      @JsonValue(r'HIGH')
      HIGH(r'HIGH'),
      @JsonValue(r'CRITICAL')
      CRITICAL(r'CRITICAL');

  const FraudSeverity(this.value);

  final String value;

  @override
  String toString() => value;
}
