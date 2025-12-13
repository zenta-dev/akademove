//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum CommissionReportPeriod {
      @JsonValue(r'daily')
      daily(r'daily'),
      @JsonValue(r'weekly')
      weekly(r'weekly'),
      @JsonValue(r'monthly')
      monthly(r'monthly');

  const CommissionReportPeriod(this.value);

  final String value;

  @override
  String toString() => value;
}
