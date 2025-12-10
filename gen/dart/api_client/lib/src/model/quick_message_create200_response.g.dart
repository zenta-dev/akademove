// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageCreate200ResponseCWProxy {
  QuickMessageCreate200Response message(String? message);

  QuickMessageCreate200Response data(QuickMessageTemplate data);

  QuickMessageCreate200Response pagination(PaginationResult? pagination);

  QuickMessageCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageCreate200Response call({
    String? message,
    QuickMessageTemplate data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageCreate200Response.copyWith(...)` or call `instanceOfQuickMessageCreate200Response.copyWith.fieldName(value)` for a single field.
class _$QuickMessageCreate200ResponseCWProxyImpl
    implements _$QuickMessageCreate200ResponseCWProxy {
  const _$QuickMessageCreate200ResponseCWProxyImpl(this._value);

  final QuickMessageCreate200Response _value;

  @override
  QuickMessageCreate200Response message(String? message) =>
      call(message: message);

  @override
  QuickMessageCreate200Response data(QuickMessageTemplate data) =>
      call(data: data);

  @override
  QuickMessageCreate200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  QuickMessageCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as QuickMessageTemplate,
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

extension $QuickMessageCreate200ResponseCopyWith
    on QuickMessageCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageCreate200Response.copyWith(...)` or `instanceOfQuickMessageCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageCreate200ResponseCWProxy get copyWith =>
      _$QuickMessageCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageCreate200Response _$QuickMessageCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = QuickMessageCreate200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => QuickMessageTemplate.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$QuickMessageCreate200ResponseToJson(
  QuickMessageCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
