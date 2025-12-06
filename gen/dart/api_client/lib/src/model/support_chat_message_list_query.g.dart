// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_message_list_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatMessageListQueryCWProxy {
  SupportChatMessageListQuery ticketId(String ticketId);

  SupportChatMessageListQuery limit(int? limit);

  SupportChatMessageListQuery cursor(String? cursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMessageListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMessageListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMessageListQuery call({
    String ticketId,
    int? limit,
    String? cursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatMessageListQuery.copyWith(...)` or call `instanceOfSupportChatMessageListQuery.copyWith.fieldName(value)` for a single field.
class _$SupportChatMessageListQueryCWProxyImpl
    implements _$SupportChatMessageListQueryCWProxy {
  const _$SupportChatMessageListQueryCWProxyImpl(this._value);

  final SupportChatMessageListQuery _value;

  @override
  SupportChatMessageListQuery ticketId(String ticketId) =>
      call(ticketId: ticketId);

  @override
  SupportChatMessageListQuery limit(int? limit) => call(limit: limit);

  @override
  SupportChatMessageListQuery cursor(String? cursor) => call(cursor: cursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMessageListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMessageListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMessageListQuery call({
    Object? ticketId = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? cursor = const $CopyWithPlaceholder(),
  }) {
    return SupportChatMessageListQuery(
      ticketId: ticketId == const $CopyWithPlaceholder() || ticketId == null
          ? _value.ticketId
          // ignore: cast_nullable_to_non_nullable
          : ticketId as String,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int?,
      cursor: cursor == const $CopyWithPlaceholder()
          ? _value.cursor
          // ignore: cast_nullable_to_non_nullable
          : cursor as String?,
    );
  }
}

extension $SupportChatMessageListQueryCopyWith on SupportChatMessageListQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatMessageListQuery.copyWith(...)` or `instanceOfSupportChatMessageListQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatMessageListQueryCWProxy get copyWith =>
      _$SupportChatMessageListQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatMessageListQuery _$SupportChatMessageListQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportChatMessageListQuery', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ticketId']);
  final val = SupportChatMessageListQuery(
    ticketId: $checkedConvert('ticketId', (v) => v as String),
    limit: $checkedConvert('limit', (v) => (v as num?)?.toInt() ?? 50),
    cursor: $checkedConvert('cursor', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$SupportChatMessageListQueryToJson(
  SupportChatMessageListQuery instance,
) => <String, dynamic>{
  'ticketId': instance.ticketId,
  'limit': ?instance.limit,
  'cursor': ?instance.cursor,
};
