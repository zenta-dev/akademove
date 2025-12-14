// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_create_ticket201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatCreateTicket201ResponseCWProxy {
  SupportChatCreateTicket201Response message(String message);

  SupportChatCreateTicket201Response data(SupportTicket data);

  SupportChatCreateTicket201Response pagination(PaginationResult? pagination);

  SupportChatCreateTicket201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatCreateTicket201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatCreateTicket201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatCreateTicket201Response call({
    String message,
    SupportTicket data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatCreateTicket201Response.copyWith(...)` or call `instanceOfSupportChatCreateTicket201Response.copyWith.fieldName(value)` for a single field.
class _$SupportChatCreateTicket201ResponseCWProxyImpl
    implements _$SupportChatCreateTicket201ResponseCWProxy {
  const _$SupportChatCreateTicket201ResponseCWProxyImpl(this._value);

  final SupportChatCreateTicket201Response _value;

  @override
  SupportChatCreateTicket201Response message(String message) =>
      call(message: message);

  @override
  SupportChatCreateTicket201Response data(SupportTicket data) =>
      call(data: data);

  @override
  SupportChatCreateTicket201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  SupportChatCreateTicket201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatCreateTicket201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatCreateTicket201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatCreateTicket201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return SupportChatCreateTicket201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SupportTicket,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $SupportChatCreateTicket201ResponseCopyWith
    on SupportChatCreateTicket201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatCreateTicket201Response.copyWith(...)` or `instanceOfSupportChatCreateTicket201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatCreateTicket201ResponseCWProxy get copyWith =>
      _$SupportChatCreateTicket201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatCreateTicket201Response _$SupportChatCreateTicket201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportChatCreateTicket201Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = SupportChatCreateTicket201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => SupportTicket.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$SupportChatCreateTicket201ResponseToJson(
  SupportChatCreateTicket201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
