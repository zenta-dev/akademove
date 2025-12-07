//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum AccountDeletionKey {
      @JsonValue(r'id')
      id(r'id'),
      @JsonValue(r'fullName')
      fullName(r'fullName'),
      @JsonValue(r'email')
      email(r'email'),
      @JsonValue(r'phone')
      phone(r'phone'),
      @JsonValue(r'accountType')
      accountType(r'accountType'),
      @JsonValue(r'reason')
      reason(r'reason'),
      @JsonValue(r'additionalInfo')
      additionalInfo(r'additionalInfo'),
      @JsonValue(r'status')
      status(r'status'),
      @JsonValue(r'userId')
      userId(r'userId'),
      @JsonValue(r'reviewedById')
      reviewedById(r'reviewedById'),
      @JsonValue(r'reviewNotes')
      reviewNotes(r'reviewNotes'),
      @JsonValue(r'createdAt')
      createdAt(r'createdAt'),
      @JsonValue(r'updatedAt')
      updatedAt(r'updatedAt'),
      @JsonValue(r'reviewedAt')
      reviewedAt(r'reviewedAt'),
      @JsonValue(r'completedAt')
      completedAt(r'completedAt');

  const AccountDeletionKey(this.value);

  final String value;

  @override
  String toString() => value;
}
