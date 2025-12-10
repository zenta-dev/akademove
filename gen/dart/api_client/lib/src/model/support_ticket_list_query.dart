//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_ticket_priority.dart';
import 'package:api_client/src/model/support_ticket_category.dart';
import 'package:api_client/src/model/support_ticket_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_ticket_list_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportTicketListQuery {
  /// Returns a new [SupportTicketListQuery] instance.
  const SupportTicketListQuery({
     this.status,
     this.category,
     this.priority,
     this.assignedToId,
     this.userId,
     this.search,
     this.limit = 20,
     this.cursor,
  });
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final SupportTicketStatus? status;
  
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final SupportTicketCategory? category;
  
  @JsonKey(name: r'priority', required: false, includeIfNull: false)
  final SupportTicketPriority? priority;
  
  @JsonKey(name: r'assignedToId', required: false, includeIfNull: false)
  final String? assignedToId;
  
  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;
  
  @JsonKey(name: r'search', required: false, includeIfNull: false)
  final String? search;
  
          // minimum: -9007199254740991
          // maximum: 1000
  @JsonKey(defaultValue: 20,name: r'limit', required: false, includeIfNull: false)
  final int? limit;
  
  @JsonKey(name: r'cursor', required: false, includeIfNull: false)
  final String? cursor;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is SupportTicketListQuery &&
    other.status == status &&
    other.category == category &&
    other.priority == priority &&
    other.assignedToId == assignedToId &&
    other.userId == userId &&
    other.search == search &&
    other.limit == limit &&
    other.cursor == cursor;

  @override
  int get hashCode =>
      status.hashCode +
      category.hashCode +
      priority.hashCode +
      (assignedToId == null ? 0 : assignedToId.hashCode) +
      (userId == null ? 0 : userId.hashCode) +
      (search == null ? 0 : search.hashCode) +
      limit.hashCode +
      cursor.hashCode;

  factory SupportTicketListQuery.fromJson(Map<String, dynamic> json) => _$SupportTicketListQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketListQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

