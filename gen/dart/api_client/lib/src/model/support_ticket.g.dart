// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportTicketCWProxy {
  SupportTicket id(String? id);

  SupportTicket userId(String? userId);

  SupportTicket assignedToId(String? assignedToId);

  SupportTicket subject(String subject);

  SupportTicket category(SupportTicketCategory category);

  SupportTicket priority(SupportTicketPriority priority);

  SupportTicket status(SupportTicketStatus status);

  SupportTicket orderId(String? orderId);

  SupportTicket lastMessageAt(DateTime? lastMessageAt);

  SupportTicket resolvedAt(DateTime? resolvedAt);

  SupportTicket createdAt(DateTime? createdAt);

  SupportTicket updatedAt(DateTime? updatedAt);

  SupportTicket user(SupportTicketUser? user);

  SupportTicket assignedTo(OrderChatMessageSender? assignedTo);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicket call({
    String? id,
    String? userId,
    String? assignedToId,
    String subject,
    SupportTicketCategory category,
    SupportTicketPriority priority,
    SupportTicketStatus status,
    String? orderId,
    DateTime? lastMessageAt,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    SupportTicketUser? user,
    OrderChatMessageSender? assignedTo,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportTicket.copyWith(...)` or call `instanceOfSupportTicket.copyWith.fieldName(value)` for a single field.
class _$SupportTicketCWProxyImpl implements _$SupportTicketCWProxy {
  const _$SupportTicketCWProxyImpl(this._value);

  final SupportTicket _value;

  @override
  SupportTicket id(String? id) => call(id: id);

  @override
  SupportTicket userId(String? userId) => call(userId: userId);

  @override
  SupportTicket assignedToId(String? assignedToId) =>
      call(assignedToId: assignedToId);

  @override
  SupportTicket subject(String subject) => call(subject: subject);

  @override
  SupportTicket category(SupportTicketCategory category) =>
      call(category: category);

  @override
  SupportTicket priority(SupportTicketPriority priority) =>
      call(priority: priority);

  @override
  SupportTicket status(SupportTicketStatus status) => call(status: status);

  @override
  SupportTicket orderId(String? orderId) => call(orderId: orderId);

  @override
  SupportTicket lastMessageAt(DateTime? lastMessageAt) =>
      call(lastMessageAt: lastMessageAt);

  @override
  SupportTicket resolvedAt(DateTime? resolvedAt) =>
      call(resolvedAt: resolvedAt);

  @override
  SupportTicket createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  SupportTicket updatedAt(DateTime? updatedAt) => call(updatedAt: updatedAt);

  @override
  SupportTicket user(SupportTicketUser? user) => call(user: user);

  @override
  SupportTicket assignedTo(OrderChatMessageSender? assignedTo) =>
      call(assignedTo: assignedTo);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicket call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? assignedToId = const $CopyWithPlaceholder(),
    Object? subject = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? lastMessageAt = const $CopyWithPlaceholder(),
    Object? resolvedAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? assignedTo = const $CopyWithPlaceholder(),
  }) {
    return SupportTicket(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      assignedToId: assignedToId == const $CopyWithPlaceholder()
          ? _value.assignedToId
          // ignore: cast_nullable_to_non_nullable
          : assignedToId as String?,
      subject: subject == const $CopyWithPlaceholder() || subject == null
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as SupportTicketCategory,
      priority: priority == const $CopyWithPlaceholder() || priority == null
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as SupportTicketPriority,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SupportTicketStatus,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      lastMessageAt: lastMessageAt == const $CopyWithPlaceholder()
          ? _value.lastMessageAt
          // ignore: cast_nullable_to_non_nullable
          : lastMessageAt as DateTime?,
      resolvedAt: resolvedAt == const $CopyWithPlaceholder()
          ? _value.resolvedAt
          // ignore: cast_nullable_to_non_nullable
          : resolvedAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as SupportTicketUser?,
      assignedTo: assignedTo == const $CopyWithPlaceholder()
          ? _value.assignedTo
          // ignore: cast_nullable_to_non_nullable
          : assignedTo as OrderChatMessageSender?,
    );
  }
}

extension $SupportTicketCopyWith on SupportTicket {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportTicket.copyWith(...)` or `instanceOfSupportTicket.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportTicketCWProxy get copyWith => _$SupportTicketCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicket _$SupportTicketFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportTicket', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'userId',
          'subject',
          'category',
          'priority',
          'status',
          'createdAt',
          'updatedAt',
        ],
      );
      final val = SupportTicket(
        id: $checkedConvert('id', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
        assignedToId: $checkedConvert('assignedToId', (v) => v as String?),
        subject: $checkedConvert('subject', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$SupportTicketCategoryEnumMap, v),
        ),
        priority: $checkedConvert(
          'priority',
          (v) => $enumDecode(_$SupportTicketPriorityEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$SupportTicketStatusEnumMap, v),
        ),
        orderId: $checkedConvert('orderId', (v) => v as String?),
        lastMessageAt: $checkedConvert(
          'lastMessageAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        resolvedAt: $checkedConvert(
          'resolvedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        user: $checkedConvert(
          'user',
          (v) => v == null
              ? null
              : SupportTicketUser.fromJson(v as Map<String, dynamic>),
        ),
        assignedTo: $checkedConvert(
          'assignedTo',
          (v) => v == null
              ? null
              : OrderChatMessageSender.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SupportTicketToJson(SupportTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'assignedToId': ?instance.assignedToId,
      'subject': instance.subject,
      'category': _$SupportTicketCategoryEnumMap[instance.category]!,
      'priority': _$SupportTicketPriorityEnumMap[instance.priority]!,
      'status': _$SupportTicketStatusEnumMap[instance.status]!,
      'orderId': ?instance.orderId,
      'lastMessageAt': ?instance.lastMessageAt?.toIso8601String(),
      'resolvedAt': ?instance.resolvedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user': ?instance.user?.toJson(),
      'assignedTo': ?instance.assignedTo?.toJson(),
    };

const _$SupportTicketCategoryEnumMap = {
  SupportTicketCategory.GENERAL: 'GENERAL',
  SupportTicketCategory.ORDER_ISSUE: 'ORDER_ISSUE',
  SupportTicketCategory.PAYMENT_ISSUE: 'PAYMENT_ISSUE',
  SupportTicketCategory.DRIVER_COMPLAINT: 'DRIVER_COMPLAINT',
  SupportTicketCategory.MERCHANT_COMPLAINT: 'MERCHANT_COMPLAINT',
  SupportTicketCategory.ACCOUNT_ISSUE: 'ACCOUNT_ISSUE',
  SupportTicketCategory.TECHNICAL_ISSUE: 'TECHNICAL_ISSUE',
  SupportTicketCategory.FEATURE_REQUEST: 'FEATURE_REQUEST',
  SupportTicketCategory.OTHER: 'OTHER',
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
