// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_get_unread_count200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatGetUnreadCount200ResponseDataCWProxy {
  SupportChatGetUnreadCount200ResponseData unreadCount(num unreadCount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatGetUnreadCount200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatGetUnreadCount200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatGetUnreadCount200ResponseData call({num unreadCount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatGetUnreadCount200ResponseData.copyWith(...)` or call `instanceOfSupportChatGetUnreadCount200ResponseData.copyWith.fieldName(value)` for a single field.
class _$SupportChatGetUnreadCount200ResponseDataCWProxyImpl
    implements _$SupportChatGetUnreadCount200ResponseDataCWProxy {
  const _$SupportChatGetUnreadCount200ResponseDataCWProxyImpl(this._value);

  final SupportChatGetUnreadCount200ResponseData _value;

  @override
  SupportChatGetUnreadCount200ResponseData unreadCount(num unreadCount) =>
      call(unreadCount: unreadCount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatGetUnreadCount200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatGetUnreadCount200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatGetUnreadCount200ResponseData call({
    Object? unreadCount = const $CopyWithPlaceholder(),
  }) {
    return SupportChatGetUnreadCount200ResponseData(
      unreadCount:
          unreadCount == const $CopyWithPlaceholder() || unreadCount == null
          ? _value.unreadCount
          // ignore: cast_nullable_to_non_nullable
          : unreadCount as num,
    );
  }
}

extension $SupportChatGetUnreadCount200ResponseDataCopyWith
    on SupportChatGetUnreadCount200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatGetUnreadCount200ResponseData.copyWith(...)` or `instanceOfSupportChatGetUnreadCount200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatGetUnreadCount200ResponseDataCWProxy get copyWith =>
      _$SupportChatGetUnreadCount200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatGetUnreadCount200ResponseData
_$SupportChatGetUnreadCount200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatGetUnreadCount200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['unreadCount']);
      final val = SupportChatGetUnreadCount200ResponseData(
        unreadCount: $checkedConvert('unreadCount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatGetUnreadCount200ResponseDataToJson(
  SupportChatGetUnreadCount200ResponseData instance,
) => <String, dynamic>{'unreadCount': instance.unreadCount};
