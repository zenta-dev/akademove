// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_unread_count.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatUnreadCountCWProxy {
  ChatUnreadCount orderId(String orderId);

  ChatUnreadCount unreadCount(int unreadCount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatUnreadCount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatUnreadCount(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatUnreadCount call({String orderId, int unreadCount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatUnreadCount.copyWith(...)` or call `instanceOfChatUnreadCount.copyWith.fieldName(value)` for a single field.
class _$ChatUnreadCountCWProxyImpl implements _$ChatUnreadCountCWProxy {
  const _$ChatUnreadCountCWProxyImpl(this._value);

  final ChatUnreadCount _value;

  @override
  ChatUnreadCount orderId(String orderId) => call(orderId: orderId);

  @override
  ChatUnreadCount unreadCount(int unreadCount) =>
      call(unreadCount: unreadCount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatUnreadCount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatUnreadCount(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatUnreadCount call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? unreadCount = const $CopyWithPlaceholder(),
  }) {
    return ChatUnreadCount(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      unreadCount:
          unreadCount == const $CopyWithPlaceholder() || unreadCount == null
          ? _value.unreadCount
          // ignore: cast_nullable_to_non_nullable
          : unreadCount as int,
    );
  }
}

extension $ChatUnreadCountCopyWith on ChatUnreadCount {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatUnreadCount.copyWith(...)` or `instanceOfChatUnreadCount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatUnreadCountCWProxy get copyWith => _$ChatUnreadCountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUnreadCount _$ChatUnreadCountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatUnreadCount', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['orderId', 'unreadCount']);
      final val = ChatUnreadCount(
        orderId: $checkedConvert('orderId', (v) => v as String),
        unreadCount: $checkedConvert('unreadCount', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ChatUnreadCountToJson(ChatUnreadCount instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'unreadCount': instance.unreadCount,
    };
