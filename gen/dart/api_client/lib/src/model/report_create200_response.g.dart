// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCreate200ResponseCWProxy {
  ReportCreate200Response message(String? message);

  ReportCreate200Response data(Report data);

  ReportCreate200Response pagination(PaginationResult? pagination);

  ReportCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReportCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportCreate200Response call({
    String? message,
    Report data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportCreate200Response.copyWith(...)` or call `instanceOfReportCreate200Response.copyWith.fieldName(value)` for a single field.
class _$ReportCreate200ResponseCWProxyImpl
    implements _$ReportCreate200ResponseCWProxy {
  const _$ReportCreate200ResponseCWProxyImpl(this._value);

  final ReportCreate200Response _value;

  @override
  ReportCreate200Response message(String? message) => call(message: message);

  @override
  ReportCreate200Response data(Report data) => call(data: data);

  @override
  ReportCreate200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ReportCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReportCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReportCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Report,
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

extension $ReportCreate200ResponseCopyWith on ReportCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportCreate200Response.copyWith(...)` or `instanceOfReportCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportCreate200ResponseCWProxy get copyWith =>
      _$ReportCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCreate200Response _$ReportCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReportCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ReportCreate200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => Report.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ReportCreate200ResponseToJson(
  ReportCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
