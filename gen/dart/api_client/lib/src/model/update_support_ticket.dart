//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_ticket_priority.dart';
import 'package:api_client/src/model/support_ticket_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_support_ticket.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateSupportTicket {
  /// Returns a new [UpdateSupportTicket] instance.
  const UpdateSupportTicket({this.assignedToId, this.priority, this.status});
  @JsonKey(name: r'assignedToId', required: false, includeIfNull: false)
  final String? assignedToId;

  @JsonKey(name: r'priority', required: false, includeIfNull: false)
  final SupportTicketPriority? priority;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final SupportTicketStatus? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateSupportTicket &&
          other.assignedToId == assignedToId &&
          other.priority == priority &&
          other.status == status;

  @override
  int get hashCode =>
      assignedToId.hashCode + priority.hashCode + status.hashCode;

  factory UpdateSupportTicket.fromJson(Map<String, dynamic> json) =>
      _$UpdateSupportTicketFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSupportTicketToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
