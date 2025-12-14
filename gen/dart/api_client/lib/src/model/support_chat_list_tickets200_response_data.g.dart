// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_list_tickets200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatListTickets200ResponseDataCWProxy {
  SupportChatListTickets200ResponseData rows(List<SupportTicket> rows);

  SupportChatListTickets200ResponseData hasMore(bool hasMore);

  SupportChatListTickets200ResponseData nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatListTickets200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatListTickets200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatListTickets200ResponseData call({
    List<SupportTicket> rows,
    bool hasMore,
    String? nextCursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatListTickets200ResponseData.copyWith(...)` or call `instanceOfSupportChatListTickets200ResponseData.copyWith.fieldName(value)` for a single field.
class _$SupportChatListTickets200ResponseDataCWProxyImpl
    implements _$SupportChatListTickets200ResponseDataCWProxy {
  const _$SupportChatListTickets200ResponseDataCWProxyImpl(this._value);

  final SupportChatListTickets200ResponseData _value;

  @override
  SupportChatListTickets200ResponseData rows(List<SupportTicket> rows) =>
      call(rows: rows);

  @override
  SupportChatListTickets200ResponseData hasMore(bool hasMore) =>
      call(hasMore: hasMore);

  @override
  SupportChatListTickets200ResponseData nextCursor(String? nextCursor) =>
      call(nextCursor: nextCursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatListTickets200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatListTickets200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatListTickets200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
    Object? hasMore = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return SupportChatListTickets200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<SupportTicket>,
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

extension $SupportChatListTickets200ResponseDataCopyWith
    on SupportChatListTickets200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatListTickets200ResponseData.copyWith(...)` or `instanceOfSupportChatListTickets200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatListTickets200ResponseDataCWProxy get copyWith =>
      _$SupportChatListTickets200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatListTickets200ResponseData
_$SupportChatListTickets200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatListTickets200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['rows', 'hasMore']);
      final val = SupportChatListTickets200ResponseData(
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>)
              .map((e) => SupportTicket.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        hasMore: $checkedConvert('hasMore', (v) => v as bool),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatListTickets200ResponseDataToJson(
  SupportChatListTickets200ResponseData instance,
) => <String, dynamic>{
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'hasMore': instance.hasMore,
  'nextCursor': ?instance.nextCursor,
};
