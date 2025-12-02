//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum PaginationMode {
      @JsonValue(r'offset')
      offset(r'offset'),
      @JsonValue(r'cursor')
      cursor(r'cursor');

  const PaginationMode(this.value);

  final String value;

  @override
  String toString() => value;
}
