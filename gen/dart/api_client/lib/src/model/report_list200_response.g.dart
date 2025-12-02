// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportList200ResponseCWProxy {
  ReportList200Response message(String message);

  ReportList200Response data(List<Report> data);

  ReportList200Response pagination(PaginationResult? pagination);

  ReportList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReportList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportList200Response call({String message, List<Report> data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportList200Response.copyWith(...)` or call `instanceOfReportList200Response.copyWith.fieldName(value)` for a single field.
class _$ReportList200ResponseCWProxyImpl implements _$ReportList200ResponseCWProxy {
  const _$ReportList200ResponseCWProxyImpl(this._value);

  final ReportList200Response _value;

  @override
  ReportList200Response message(String message) => call(message: message);

  @override
  ReportList200Response data(List<Report> data) => call(data: data);

  @override
  ReportList200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  ReportList200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReportList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReportList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Report>,
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

extension $ReportList200ResponseCopyWith on ReportList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportList200Response.copyWith(...)` or `instanceOfReportList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportList200ResponseCWProxy get copyWith => _$ReportList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportList200Response _$ReportList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportList200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = ReportList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>).map((e) => Report.fromJson(e as Map<String, dynamic>)).toList(),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ReportList200ResponseToJson(ReportList200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
