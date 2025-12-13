//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum BankProvider {
      @JsonValue(r'BCA')
      BCA(r'BCA'),
      @JsonValue(r'BNI')
      BNI(r'BNI'),
      @JsonValue(r'BRI')
      BRI(r'BRI'),
      @JsonValue(r'MANDIRI')
      MANDIRI(r'MANDIRI'),
      @JsonValue(r'PERMATA')
      PERMATA(r'PERMATA');

  const BankProvider(this.value);

  final String value;

  @override
  String toString() => value;
}
