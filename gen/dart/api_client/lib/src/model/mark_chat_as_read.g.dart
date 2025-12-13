// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_chat_as_read.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MarkChatAsReadCWProxy {
  MarkChatAsRead orderId(String orderId);

  MarkChatAsRead lastReadMessageId(String? lastReadMessageId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MarkChatAsRead(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkChatAsRead(...).copyWith(id: 12, name: "My name")
  /// ```
  MarkChatAsRead call({String orderId, String? lastReadMessageId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMarkChatAsRead.copyWith(...)` or call `instanceOfMarkChatAsRead.copyWith.fieldName(value)` for a single field.
class _$MarkChatAsReadCWProxyImpl implements _$MarkChatAsReadCWProxy {
  const _$MarkChatAsReadCWProxyImpl(this._value);

  final MarkChatAsRead _value;

  @override
  MarkChatAsRead orderId(String orderId) => call(orderId: orderId);

  @override
  MarkChatAsRead lastReadMessageId(String? lastReadMessageId) =>
      call(lastReadMessageId: lastReadMessageId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MarkChatAsRead(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkChatAsRead(...).copyWith(id: 12, name: "My name")
  /// ```
  MarkChatAsRead call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? lastReadMessageId = const $CopyWithPlaceholder(),
  }) {
    return MarkChatAsRead(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      lastReadMessageId: lastReadMessageId == const $CopyWithPlaceholder()
          ? _value.lastReadMessageId
          // ignore: cast_nullable_to_non_nullable
          : lastReadMessageId as String?,
    );
  }
}

extension $MarkChatAsReadCopyWith on MarkChatAsRead {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMarkChatAsRead.copyWith(...)` or `instanceOfMarkChatAsRead.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MarkChatAsReadCWProxy get copyWith => _$MarkChatAsReadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkChatAsRead _$MarkChatAsReadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MarkChatAsRead', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['orderId']);
      final val = MarkChatAsRead(
        orderId: $checkedConvert('orderId', (v) => v as String),
        lastReadMessageId: $checkedConvert(
          'lastReadMessageId',
          (v) => v as String?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$MarkChatAsReadToJson(MarkChatAsRead instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'lastReadMessageId': ?instance.lastReadMessageId,
    };
