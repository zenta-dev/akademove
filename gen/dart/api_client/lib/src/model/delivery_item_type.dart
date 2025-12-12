//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DeliveryItemType {
  @JsonValue(r'FOOD')
  FOOD(r'FOOD'),
  @JsonValue(r'CLOTH')
  CLOTH(r'CLOTH'),
  @JsonValue(r'DOCUMENT')
  DOCUMENT(r'DOCUMENT'),
  @JsonValue(r'MEDICINE')
  MEDICINE(r'MEDICINE'),
  @JsonValue(r'BOOK')
  BOOK(r'BOOK'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const DeliveryItemType(this.value);

  final String value;

  @override
  String toString() => value;
}
