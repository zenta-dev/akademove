// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ScheduleCreate200ResponseCWProxy {
  ScheduleCreate200Response message(String message);

  ScheduleCreate200Response data(Schedule data);

  ScheduleCreate200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleCreate200Response call({
    String message,
    Schedule data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfScheduleCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfScheduleCreate200Response.copyWith.fieldName(...)`
class _$ScheduleCreate200ResponseCWProxyImpl
    implements _$ScheduleCreate200ResponseCWProxy {
  const _$ScheduleCreate200ResponseCWProxyImpl(this._value);

  final ScheduleCreate200Response _value;

  @override
  ScheduleCreate200Response message(String message) => this(message: message);

  @override
  ScheduleCreate200Response data(Schedule data) => this(data: data);

  @override
  ScheduleCreate200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ScheduleCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Schedule,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $ScheduleCreate200ResponseCopyWith on ScheduleCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfScheduleCreate200Response.copyWith(...)` or like so:`instanceOfScheduleCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ScheduleCreate200ResponseCWProxy get copyWith =>
      _$ScheduleCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleCreate200Response _$ScheduleCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ScheduleCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ScheduleCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Schedule.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$ScheduleCreate200ResponseToJson(
  ScheduleCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
