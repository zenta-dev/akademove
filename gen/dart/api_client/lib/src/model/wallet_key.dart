//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum WalletKey {
      @JsonValue(r'id')
      id(r'id'),
      @JsonValue(r'userId')
      userId(r'userId'),
      @JsonValue(r'balance')
      balance(r'balance'),
      @JsonValue(r'currency')
      currency(r'currency'),
      @JsonValue(r'isActive')
      isActive(r'isActive'),
      @JsonValue(r'createdAt')
      createdAt(r'createdAt'),
      @JsonValue(r'updatedAt')
      updatedAt(r'updatedAt');

  const WalletKey(this.value);

  final String value;

  @override
  String toString() => value;
}
