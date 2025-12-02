//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum ReviewCategory {
      @JsonValue(r'CLEANLINESS')
      CLEANLINESS(r'CLEANLINESS'),
      @JsonValue(r'COURTESY')
      COURTESY(r'COURTESY'),
      @JsonValue(r'OTHER')
      OTHER(r'OTHER');

  const ReviewCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
