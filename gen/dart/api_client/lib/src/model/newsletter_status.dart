//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum NewsletterStatus {
      @JsonValue(r'ACTIVE')
      ACTIVE(r'ACTIVE'),
      @JsonValue(r'UNSUBSCRIBED')
      UNSUBSCRIBED(r'UNSUBSCRIBED');

  const NewsletterStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
