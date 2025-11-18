// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCreate200ResponseCWProxy {
  ReportCreate200Response message(String message);

  ReportCreate200Response data(Report data);

  ReportCreate200Response pagination(PaginationResult? pagination);

  ReportCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportCreate200Response call({
    String message,
    Report data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReportCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReportCreate200Response.copyWith.fieldName(...)`
class _$ReportCreate200ResponseCWProxyImpl
    implements _$ReportCreate200ResponseCWProxy {
  const _$ReportCreate200ResponseCWProxyImpl(this._value);

  final ReportCreate200Response _value;

  @override
  ReportCreate200Response message(String message) => this(message: message);

  @override
  ReportCreate200Response data(Report data) => this(data: data);

  @override
  ReportCreate200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  ReportCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
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
          : message as String,
      data: data == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfReportCreate200Response.copyWith(...)` or like so:`instanceOfReportCreate200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String),
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
