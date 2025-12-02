// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleCreate200ResponseCWProxy {
  DriverScheduleCreate200Response message(String message);

  DriverScheduleCreate200Response data(DriverSchedule data);

  DriverScheduleCreate200Response pagination(PaginationResult? pagination);

  DriverScheduleCreate200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleCreate200Response call({
    String message,
    DriverSchedule data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverScheduleCreate200Response.copyWith(...)` or call `instanceOfDriverScheduleCreate200Response.copyWith.fieldName(value)` for a single field.
class _$DriverScheduleCreate200ResponseCWProxyImpl
    implements _$DriverScheduleCreate200ResponseCWProxy {
  const _$DriverScheduleCreate200ResponseCWProxyImpl(this._value);

  final DriverScheduleCreate200Response _value;

  @override
  DriverScheduleCreate200Response message(String message) =>
      call(message: message);

  @override
  DriverScheduleCreate200Response data(DriverSchedule data) => call(data: data);

  @override
  DriverScheduleCreate200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverScheduleCreate200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverScheduleCreate200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverScheduleCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverScheduleCreate200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverSchedule,
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

extension $DriverScheduleCreate200ResponseCopyWith
    on DriverScheduleCreate200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverScheduleCreate200Response.copyWith(...)` or `instanceOfDriverScheduleCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverScheduleCreate200ResponseCWProxy get copyWith =>
      _$DriverScheduleCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverScheduleCreate200Response _$DriverScheduleCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverScheduleCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverScheduleCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => DriverSchedule.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverScheduleCreate200ResponseToJson(
  DriverScheduleCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
