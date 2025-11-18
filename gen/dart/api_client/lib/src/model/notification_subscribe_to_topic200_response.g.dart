// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_subscribe_to_topic200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSubscribeToTopic200ResponseCWProxy {
  NotificationSubscribeToTopic200Response message(String message);

  NotificationSubscribeToTopic200Response data(
    NotificationSubscribeToTopic200ResponseData data,
  );

  NotificationSubscribeToTopic200Response pagination(
    PaginationResult? pagination,
  );

  NotificationSubscribeToTopic200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSubscribeToTopic200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSubscribeToTopic200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSubscribeToTopic200Response call({
    String message,
    NotificationSubscribeToTopic200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationSubscribeToTopic200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationSubscribeToTopic200Response.copyWith.fieldName(...)`
class _$NotificationSubscribeToTopic200ResponseCWProxyImpl
    implements _$NotificationSubscribeToTopic200ResponseCWProxy {
  const _$NotificationSubscribeToTopic200ResponseCWProxyImpl(this._value);

  final NotificationSubscribeToTopic200Response _value;

  @override
  NotificationSubscribeToTopic200Response message(String message) =>
      this(message: message);

  @override
  NotificationSubscribeToTopic200Response data(
    NotificationSubscribeToTopic200ResponseData data,
  ) => this(data: data);

  @override
  NotificationSubscribeToTopic200Response pagination(
    PaginationResult? pagination,
  ) => this(pagination: pagination);

  @override
  NotificationSubscribeToTopic200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSubscribeToTopic200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSubscribeToTopic200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSubscribeToTopic200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationSubscribeToTopic200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as NotificationSubscribeToTopic200ResponseData,
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

extension $NotificationSubscribeToTopic200ResponseCopyWith
    on NotificationSubscribeToTopic200Response {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationSubscribeToTopic200Response.copyWith(...)` or like so:`instanceOfNotificationSubscribeToTopic200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSubscribeToTopic200ResponseCWProxy get copyWith =>
      _$NotificationSubscribeToTopic200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSubscribeToTopic200Response
_$NotificationSubscribeToTopic200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationSubscribeToTopic200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = NotificationSubscribeToTopic200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => NotificationSubscribeToTopic200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
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

Map<String, dynamic> _$NotificationSubscribeToTopic200ResponseToJson(
  NotificationSubscribeToTopic200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
