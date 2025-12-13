//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum FraudStatus {
      @JsonValue(r'PENDING')
      PENDING(r'PENDING'),
      @JsonValue(r'REVIEWING')
      REVIEWING(r'REVIEWING'),
      @JsonValue(r'CONFIRMED')
      CONFIRMED(r'CONFIRMED'),
      @JsonValue(r'DISMISSED')
      DISMISSED(r'DISMISSED');

  const FraudStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
