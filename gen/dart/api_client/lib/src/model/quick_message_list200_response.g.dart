// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageList200ResponseCWProxy {
  QuickMessageList200Response message(String message);

  QuickMessageList200Response data(QuickMessageList200ResponseData data);

  QuickMessageList200Response pagination(PaginationResult? pagination);

  QuickMessageList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageList200Response call({
    String message,
    QuickMessageList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageList200Response.copyWith(...)` or call `instanceOfQuickMessageList200Response.copyWith.fieldName(value)` for a single field.
class _$QuickMessageList200ResponseCWProxyImpl
    implements _$QuickMessageList200ResponseCWProxy {
  const _$QuickMessageList200ResponseCWProxyImpl(this._value);

  final QuickMessageList200Response _value;

  @override
  QuickMessageList200Response message(String message) => call(message: message);

  @override
  QuickMessageList200Response data(QuickMessageList200ResponseData data) =>
      call(data: data);

  @override
  QuickMessageList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  QuickMessageList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as QuickMessageList200ResponseData,
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

extension $QuickMessageList200ResponseCopyWith on QuickMessageList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageList200Response.copyWith(...)` or `instanceOfQuickMessageList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageList200ResponseCWProxy get copyWith =>
      _$QuickMessageList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageList200Response _$QuickMessageList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = QuickMessageList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) =>
          QuickMessageList200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$QuickMessageList200ResponseToJson(
  QuickMessageList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
