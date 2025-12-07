//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SupportTicketKey {
      @JsonValue(r'id')
      id(r'id'),
      @JsonValue(r'userId')
      userId(r'userId'),
      @JsonValue(r'assignedToId')
      assignedToId(r'assignedToId'),
      @JsonValue(r'subject')
      subject(r'subject'),
      @JsonValue(r'category')
      category(r'category'),
      @JsonValue(r'priority')
      priority(r'priority'),
      @JsonValue(r'status')
      status(r'status'),
      @JsonValue(r'orderId')
      orderId(r'orderId'),
      @JsonValue(r'lastMessageAt')
      lastMessageAt(r'lastMessageAt'),
      @JsonValue(r'resolvedAt')
      resolvedAt(r'resolvedAt'),
      @JsonValue(r'createdAt')
      createdAt(r'createdAt'),
      @JsonValue(r'updatedAt')
      updatedAt(r'updatedAt'),
      @JsonValue(r'user')
      user(r'user'),
      @JsonValue(r'assignedTo')
      assignedTo(r'assignedTo');

  const SupportTicketKey(this.value);

  final String value;

  @override
  String toString() => value;
}
