// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_schedule_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverScheduleCreate200ResponseCWProxy {
  DriverScheduleCreate200Response message(String message);

  DriverScheduleCreate200Response data(DriverSchedule data);

  DriverScheduleCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverScheduleCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverScheduleCreate200Response call({
    String message,
    DriverSchedule data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverScheduleCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverScheduleCreate200Response.copyWith.fieldName(...)`
class _$DriverScheduleCreate200ResponseCWProxyImpl
    implements _$DriverScheduleCreate200ResponseCWProxy {
  const _$DriverScheduleCreate200ResponseCWProxyImpl(this._value);

  final DriverScheduleCreate200Response _value;

  @override
  DriverScheduleCreate200Response message(String message) =>
      this(message: message);

  @override
  DriverScheduleCreate200Response data(DriverSchedule data) => this(data: data);

  @override
  DriverScheduleCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverScheduleCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverScheduleCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverScheduleCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverSchedule,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $DriverScheduleCreate200ResponseCopyWith
    on DriverScheduleCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfDriverScheduleCreate200Response.copyWith(...)` or like so:`instanceOfDriverScheduleCreate200Response.copyWith.fieldName(...)`.
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
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$DriverScheduleCreate200ResponseToJson(
  DriverScheduleCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
