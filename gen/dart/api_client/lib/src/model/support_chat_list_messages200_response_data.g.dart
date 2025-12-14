// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_list_messages200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatListMessages200ResponseDataCWProxy {
  SupportChatListMessages200ResponseData rows(List<SupportChatMessage> rows);

  SupportChatListMessages200ResponseData hasMore(bool hasMore);

  SupportChatListMessages200ResponseData nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatListMessages200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatListMessages200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatListMessages200ResponseData call({
    List<SupportChatMessage> rows,
    bool hasMore,
    String? nextCursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatListMessages200ResponseData.copyWith(...)` or call `instanceOfSupportChatListMessages200ResponseData.copyWith.fieldName(value)` for a single field.
class _$SupportChatListMessages200ResponseDataCWProxyImpl
    implements _$SupportChatListMessages200ResponseDataCWProxy {
  const _$SupportChatListMessages200ResponseDataCWProxyImpl(this._value);

  final SupportChatListMessages200ResponseData _value;

  @override
  SupportChatListMessages200ResponseData rows(List<SupportChatMessage> rows) =>
      call(rows: rows);

  @override
  SupportChatListMessages200ResponseData hasMore(bool hasMore) =>
      call(hasMore: hasMore);

  @override
  SupportChatListMessages200ResponseData nextCursor(String? nextCursor) =>
      call(nextCursor: nextCursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatListMessages200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatListMessages200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatListMessages200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
    Object? hasMore = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return SupportChatListMessages200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<SupportChatMessage>,
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

extension $SupportChatListMessages200ResponseDataCopyWith
    on SupportChatListMessages200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatListMessages200ResponseData.copyWith(...)` or `instanceOfSupportChatListMessages200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatListMessages200ResponseDataCWProxy get copyWith =>
      _$SupportChatListMessages200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatListMessages200ResponseData
_$SupportChatListMessages200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatListMessages200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['rows', 'hasMore']);
      final val = SupportChatListMessages200ResponseData(
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>)
              .map(
                (e) => SupportChatMessage.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        hasMore: $checkedConvert('hasMore', (v) => v as bool),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatListMessages200ResponseDataToJson(
  SupportChatListMessages200ResponseData instance,
) => <String, dynamic>{
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'hasMore': instance.hasMore,
  'nextCursor': ?instance.nextCursor,
};
