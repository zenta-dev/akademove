//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_ticket_user.dart';
import 'package:api_client/src/model/support_ticket_priority.dart';
import 'package:api_client/src/model/support_ticket_category.dart';
import 'package:api_client/src/model/support_ticket_assigned_to.dart';
import 'package:api_client/src/model/support_ticket_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_ticket.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportTicket {
  /// Returns a new [SupportTicket] instance.
  const SupportTicket({
    required this.id,
    required this.userId,
    this.assignedToId,
    required this.subject,
    required this.category,
    required this.priority,
    required this.status,
    this.orderId,
    this.lastMessageAt,
    this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.assignedTo,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'assignedToId', required: false, includeIfNull: false)
  final String? assignedToId;

  @JsonKey(name: r'subject', required: true, includeIfNull: false)
  final String subject;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final SupportTicketCategory category;

  @JsonKey(name: r'priority', required: true, includeIfNull: false)
  final SupportTicketPriority priority;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final SupportTicketStatus status;

  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;

  @JsonKey(name: r'lastMessageAt', required: false, includeIfNull: false)
  final DateTime? lastMessageAt;

  @JsonKey(name: r'resolvedAt', required: false, includeIfNull: false)
  final DateTime? resolvedAt;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final SupportTicketUser? user;

  @JsonKey(name: r'assignedTo', required: false, includeIfNull: false)
  final SupportTicketAssignedTo? assignedTo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportTicket &&
          other.id == id &&
          other.userId == userId &&
          other.assignedToId == assignedToId &&
          other.subject == subject &&
          other.category == category &&
          other.priority == priority &&
          other.status == status &&
          other.orderId == orderId &&
          other.lastMessageAt == lastMessageAt &&
          other.resolvedAt == resolvedAt &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.user == user &&
          other.assignedTo == assignedTo;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      assignedToId.hashCode +
      subject.hashCode +
      category.hashCode +
      priority.hashCode +
      status.hashCode +
      orderId.hashCode +
      lastMessageAt.hashCode +
      resolvedAt.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      user.hashCode +
      assignedTo.hashCode;

  factory SupportTicket.fromJson(Map<String, dynamic> json) =>
      _$SupportTicketFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
