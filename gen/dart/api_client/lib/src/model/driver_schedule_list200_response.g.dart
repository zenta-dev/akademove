// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleList200ResponseCWProxy {
  DriverScheduleList200Response message(String? message);

  DriverScheduleList200Response data(List<DriverSchedule> data);

  DriverScheduleList200Response pagination(PaginationResult? pagination);

  DriverScheduleList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleList200Response call({
    String? message,
    List<DriverSchedule> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverScheduleList200Response.copyWith(...)` or call `instanceOfDriverScheduleList200Response.copyWith.fieldName(value)` for a single field.
class _$DriverScheduleList200ResponseCWProxyImpl
    implements _$DriverScheduleList200ResponseCWProxy {
  const _$DriverScheduleList200ResponseCWProxyImpl(this._value);

  final DriverScheduleList200Response _value;

  @override
  DriverScheduleList200Response message(String? message) =>
      call(message: message);

  @override
  DriverScheduleList200Response data(List<DriverSchedule> data) =>
      call(data: data);

  @override
  DriverScheduleList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverScheduleList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverScheduleList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<DriverSchedule>,
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

extension $DriverScheduleList200ResponseCopyWith
    on DriverScheduleList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverScheduleList200Response.copyWith(...)` or `instanceOfDriverScheduleList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverScheduleList200ResponseCWProxy get copyWith =>
      _$DriverScheduleList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverScheduleList200Response _$DriverScheduleList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverScheduleList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverScheduleList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => DriverSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$DriverScheduleList200ResponseToJson(
  DriverScheduleList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
