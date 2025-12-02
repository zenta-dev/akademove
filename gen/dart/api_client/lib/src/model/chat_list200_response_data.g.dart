// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatList200ResponseDataCWProxy {
  ChatList200ResponseData rows(List<OrderChatMessage> rows);

  ChatList200ResponseData hasMore(bool hasMore);

  ChatList200ResponseData nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatList200ResponseData call({List<OrderChatMessage> rows, bool hasMore, String? nextCursor});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatList200ResponseData.copyWith(...)` or call `instanceOfChatList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$ChatList200ResponseDataCWProxyImpl implements _$ChatList200ResponseDataCWProxy {
  const _$ChatList200ResponseDataCWProxyImpl(this._value);

  final ChatList200ResponseData _value;

  @override
  ChatList200ResponseData rows(List<OrderChatMessage> rows) => call(rows: rows);

  @override
  ChatList200ResponseData hasMore(bool hasMore) => call(hasMore: hasMore);

  @override
  ChatList200ResponseData nextCursor(String? nextCursor) => call(nextCursor: nextCursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
    Object? hasMore = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return ChatList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<OrderChatMessage>,
      hasMore: hasMore == const $CopyWithPlaceholder() || hasMore == null
          ? _value.hasMore
          // ignore: cast_nullable_to_non_nullable
          : hasMore as bool,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $ChatList200ResponseDataCopyWith on ChatList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatList200ResponseData.copyWith(...)` or `instanceOfChatList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatList200ResponseDataCWProxy get copyWith => _$ChatList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatList200ResponseData _$ChatList200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatList200ResponseData', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['rows', 'hasMore']);
      final val = ChatList200ResponseData(
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>).map((e) => OrderChatMessage.fromJson(e as Map<String, dynamic>)).toList(),
        ),
        hasMore: $checkedConvert('hasMore', (v) => v as bool),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ChatList200ResponseDataToJson(ChatList200ResponseData instance) => <String, dynamic>{
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'hasMore': instance.hasMore,
  'nextCursor': ?instance.nextCursor,
};
