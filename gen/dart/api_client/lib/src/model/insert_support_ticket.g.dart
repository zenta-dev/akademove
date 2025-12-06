// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_support_ticket.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertSupportTicketCWProxy {
  InsertSupportTicket subject(String subject);

  InsertSupportTicket category(SupportTicketCategory category);

  InsertSupportTicket priority(SupportTicketPriority priority);

  InsertSupportTicket orderId(String? orderId);

  InsertSupportTicket message(String message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertSupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertSupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertSupportTicket call({
    String subject,
    SupportTicketCategory category,
    SupportTicketPriority priority,
    String? orderId,
    String message,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertSupportTicket.copyWith(...)` or call `instanceOfInsertSupportTicket.copyWith.fieldName(value)` for a single field.
class _$InsertSupportTicketCWProxyImpl implements _$InsertSupportTicketCWProxy {
  const _$InsertSupportTicketCWProxyImpl(this._value);

  final InsertSupportTicket _value;

  @override
  InsertSupportTicket subject(String subject) => call(subject: subject);

  @override
  InsertSupportTicket category(SupportTicketCategory category) =>
      call(category: category);

  @override
  InsertSupportTicket priority(SupportTicketPriority priority) =>
      call(priority: priority);

  @override
  InsertSupportTicket orderId(String? orderId) => call(orderId: orderId);

  @override
  InsertSupportTicket message(String message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertSupportTicket(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertSupportTicket(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertSupportTicket call({
    Object? subject = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return InsertSupportTicket(
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
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $InsertSupportTicketCopyWith on InsertSupportTicket {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertSupportTicket.copyWith(...)` or `instanceOfInsertSupportTicket.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertSupportTicketCWProxy get copyWith =>
      _$InsertSupportTicketCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertSupportTicket _$InsertSupportTicketFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertSupportTicket', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['subject', 'category', 'priority', 'message'],
      );
      final val = InsertSupportTicket(
        subject: $checkedConvert('subject', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$SupportTicketCategoryEnumMap, v),
        ),
        priority: $checkedConvert(
          'priority',
          (v) => $enumDecode(_$SupportTicketPriorityEnumMap, v),
        ),
        orderId: $checkedConvert('orderId', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$InsertSupportTicketToJson(
  InsertSupportTicket instance,
) => <String, dynamic>{
  'subject': instance.subject,
  'category': _$SupportTicketCategoryEnumMap[instance.category]!,
  'priority': _$SupportTicketPriorityEnumMap[instance.priority]!,
  'orderId': ?instance.orderId,
  'message': instance.message,
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
