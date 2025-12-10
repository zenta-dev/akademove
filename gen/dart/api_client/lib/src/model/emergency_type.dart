//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum EmergencyType {
      @JsonValue(r'ACCIDENT')
      ACCIDENT(r'ACCIDENT'),
      @JsonValue(r'HARASSMENT')
      HARASSMENT(r'HARASSMENT'),
      @JsonValue(r'THEFT')
      THEFT(r'THEFT'),
      @JsonValue(r'MEDICAL')
      MEDICAL(r'MEDICAL'),
      @JsonValue(r'OTHER')
      OTHER(r'OTHER');

  const EmergencyType(this.value);

  final String value;

  @override
  String toString() => value;
}
