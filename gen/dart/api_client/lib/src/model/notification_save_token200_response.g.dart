// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveToken200ResponseCWProxy {
  NotificationSaveToken200Response message(String message);

  NotificationSaveToken200Response data(
    NotificationSaveToken200ResponseData data,
  );

  NotificationSaveToken200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveToken200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveToken200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveToken200Response call({
    String message,
    NotificationSaveToken200ResponseData data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationSaveToken200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationSaveToken200Response.copyWith.fieldName(...)`
class _$NotificationSaveToken200ResponseCWProxyImpl
    implements _$NotificationSaveToken200ResponseCWProxy {
  const _$NotificationSaveToken200ResponseCWProxyImpl(this._value);

  final NotificationSaveToken200Response _value;

  @override
  NotificationSaveToken200Response message(String message) =>
      this(message: message);

  @override
  NotificationSaveToken200Response data(
    NotificationSaveToken200ResponseData data,
  ) => this(data: data);

  @override
  NotificationSaveToken200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveToken200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveToken200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveToken200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveToken200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as NotificationSaveToken200ResponseData,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $NotificationSaveToken200ResponseCopyWith
    on NotificationSaveToken200Response {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationSaveToken200Response.copyWith(...)` or like so:`instanceOfNotificationSaveToken200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSaveToken200ResponseCWProxy get copyWith =>
      _$NotificationSaveToken200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSaveToken200Response _$NotificationSaveToken200ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('NotificationSaveToken200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = NotificationSaveToken200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => NotificationSaveToken200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$NotificationSaveToken200ResponseToJson(
  NotificationSaveToken200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
