// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportList200ResponseCWProxy {
  ReportList200Response message(String message);

  ReportList200Response data(List<Report> data);

  ReportList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportList200Response call({
    String message,
    List<Report> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReportList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReportList200Response.copyWith.fieldName(...)`
class _$ReportList200ResponseCWProxyImpl
    implements _$ReportList200ResponseCWProxy {
  const _$ReportList200ResponseCWProxyImpl(this._value);

  final ReportList200Response _value;

  @override
  ReportList200Response message(String message) => this(message: message);

  @override
  ReportList200Response data(List<Report> data) => this(data: data);

  @override
  ReportList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReportList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Report>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $ReportList200ResponseCopyWith on ReportList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfReportList200Response.copyWith(...)` or like so:`instanceOfReportList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportList200ResponseCWProxy get copyWith =>
      _$ReportList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportList200Response _$ReportList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReportList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ReportList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ReportList200ResponseToJson(
  ReportList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
