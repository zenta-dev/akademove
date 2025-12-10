//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Primary merchant category
enum MerchantCategory {
  /// Primary merchant category
  @JsonValue(r'ATK')
  ATK(r'ATK'),

  /// Primary merchant category
  @JsonValue(r'Printing')
  printing(r'Printing'),

  /// Primary merchant category
  @JsonValue(r'Food')
  food(r'Food');

  const MerchantCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
