// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ScheduleList200ResponseCWProxy {
  ScheduleList200Response message(String message);

  ScheduleList200Response data(List<Schedule> data);

  ScheduleList200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleList200Response call({
    String message,
    List<Schedule> data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfScheduleList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfScheduleList200Response.copyWith.fieldName(...)`
class _$ScheduleList200ResponseCWProxyImpl
    implements _$ScheduleList200ResponseCWProxy {
  const _$ScheduleList200ResponseCWProxyImpl(this._value);

  final ScheduleList200Response _value;

  @override
  ScheduleList200Response message(String message) => this(message: message);

  @override
  ScheduleList200Response data(List<Schedule> data) => this(data: data);

  @override
  ScheduleList200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ScheduleList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ScheduleList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ScheduleList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ScheduleList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Schedule>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $ScheduleList200ResponseCopyWith on ScheduleList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfScheduleList200Response.copyWith(...)` or like so:`instanceOfScheduleList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ScheduleList200ResponseCWProxy get copyWith =>
      _$ScheduleList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleList200Response _$ScheduleList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ScheduleList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ScheduleList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$ScheduleList200ResponseToJson(
  ScheduleList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
