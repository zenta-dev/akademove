//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_ticket_priority.dart';
import 'package:api_client/src/model/support_ticket_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_support_ticket.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertSupportTicket {
  /// Returns a new [InsertSupportTicket] instance.
  const InsertSupportTicket({
    required this.subject,
    required this.category,
    required this.priority,
    this.orderId,
    required this.message,
  });
  @JsonKey(name: r'subject', required: true, includeIfNull: false)
  final String subject;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final SupportTicketCategory category;

  @JsonKey(name: r'priority', required: true, includeIfNull: false)
  final SupportTicketPriority priority;

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertSupportTicket &&
          other.subject == subject &&
          other.category == category &&
          other.priority == priority &&
          other.orderId == orderId &&
          other.message == message;

  @override
  int get hashCode =>
      subject.hashCode +
      category.hashCode +
      priority.hashCode +
      (orderId == null ? 0 : orderId.hashCode) +
      message.hashCode;

  factory InsertSupportTicket.fromJson(Map<String, dynamic> json) =>
      _$InsertSupportTicketFromJson(json);

  Map<String, dynamic> toJson() => _$InsertSupportTicketToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
