// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_support_ticket.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateSupportTicketCWProxy {
  UpdateSupportTicket assignedToId(String? assignedToId);

  UpdateSupportTicket priority(SupportTicketPriority? priority);

  UpdateSupportTicket status(SupportTicketStatus? status);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateSupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateSupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateSupportTicket call({
    String? assignedToId,
    SupportTicketPriority? priority,
    SupportTicketStatus? status,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateSupportTicket.copyWith(...)` or call `instanceOfUpdateSupportTicket.copyWith.fieldName(value)` for a single field.
class _$UpdateSupportTicketCWProxyImpl implements _$UpdateSupportTicketCWProxy {
  const _$UpdateSupportTicketCWProxyImpl(this._value);

  final UpdateSupportTicket _value;

  @override
  UpdateSupportTicket assignedToId(String? assignedToId) =>
      call(assignedToId: assignedToId);

  @override
  UpdateSupportTicket priority(SupportTicketPriority? priority) =>
      call(priority: priority);

  @override
  UpdateSupportTicket status(SupportTicketStatus? status) =>
      call(status: status);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateSupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateSupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateSupportTicket call({
    Object? assignedToId = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return UpdateSupportTicket(
      assignedToId: assignedToId == const $CopyWithPlaceholder()
          ? _value.assignedToId
          // ignore: cast_nullable_to_non_nullable
          : assignedToId as String?,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as SupportTicketPriority?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SupportTicketStatus?,
    );
  }
}

extension $UpdateSupportTicketCopyWith on UpdateSupportTicket {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateSupportTicket.copyWith(...)` or `instanceOfUpdateSupportTicket.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateSupportTicketCWProxy get copyWith =>
      _$UpdateSupportTicketCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSupportTicket _$UpdateSupportTicketFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateSupportTicket', json, ($checkedConvert) {
      final val = UpdateSupportTicket(
        assignedToId: $checkedConvert('assignedToId', (v) => v as String?),
        priority: $checkedConvert(
          'priority',
          (v) => $enumDecodeNullable(_$SupportTicketPriorityEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$SupportTicketStatusEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateSupportTicketToJson(
  UpdateSupportTicket instance,
) => <String, dynamic>{
  'assignedToId': ?instance.assignedToId,
  'priority': ?_$SupportTicketPriorityEnumMap[instance.priority],
  'status': ?_$SupportTicketStatusEnumMap[instance.status],
};

const _$SupportTicketPriorityEnumMap = {
  SupportTicketPriority.LOW: 'LOW',
  SupportTicketPriority.MEDIUM: 'MEDIUM',
  SupportTicketPriority.HIGH: 'HIGH',
  SupportTicketPriority.URGENT: 'URGENT',
};

const _$SupportTicketStatusEnumMap = {
  SupportTicketStatus.OPEN: 'OPEN',
  SupportTicketStatus.IN_PROGRESS: 'IN_PROGRESS',
  SupportTicketStatus.WAITING_USER: 'WAITING_USER',
  SupportTicketStatus.RESOLVED: 'RESOLVED',
  SupportTicketStatus.CLOSED: 'CLOSED',
};
