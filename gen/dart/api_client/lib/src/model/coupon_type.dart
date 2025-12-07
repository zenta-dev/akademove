//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum CouponType {
      @JsonValue(r'GENERAL')
      GENERAL(r'GENERAL'),
      @JsonValue(r'EVENT')
      EVENT(r'EVENT'),
      @JsonValue(r'MERCHANT')
      MERCHANT(r'MERCHANT'),
      @JsonValue(r'FIRST_ORDER')
      FIRST_ORDER(r'FIRST_ORDER');

  const CouponType(this.value);

  final String value;

  @override
  String toString() => value;
}
