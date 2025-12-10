// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_notification_job_payload_notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BatchNotificationJobPayloadNotificationCWProxy {
  BatchNotificationJobPayloadNotification title(String title);

  BatchNotificationJobPayloadNotification body(String body);

  BatchNotificationJobPayloadNotification data(Map<String, String>? data);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJobPayloadNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJobPayloadNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJobPayloadNotification call({
    String title,
    String body,
    Map<String, String>? data,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBatchNotificationJobPayloadNotification.copyWith(...)` or call `instanceOfBatchNotificationJobPayloadNotification.copyWith.fieldName(value)` for a single field.
class _$BatchNotificationJobPayloadNotificationCWProxyImpl
    implements _$BatchNotificationJobPayloadNotificationCWProxy {
  const _$BatchNotificationJobPayloadNotificationCWProxyImpl(this._value);

  final BatchNotificationJobPayloadNotification _value;

  @override
  BatchNotificationJobPayloadNotification title(String title) =>
      call(title: title);

  @override
  BatchNotificationJobPayloadNotification body(String body) => call(body: body);

  @override
  BatchNotificationJobPayloadNotification data(Map<String, String>? data) =>
      call(data: data);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJobPayloadNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJobPayloadNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJobPayloadNotification call({
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return BatchNotificationJobPayloadNotification(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Map<String, String>?,
    );
  }
}

extension $BatchNotificationJobPayloadNotificationCopyWith
    on BatchNotificationJobPayloadNotification {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBatchNotificationJobPayloadNotification.copyWith(...)` or `instanceOfBatchNotificationJobPayloadNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BatchNotificationJobPayloadNotificationCWProxy get copyWith =>
      _$BatchNotificationJobPayloadNotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchNotificationJobPayloadNotification
_$BatchNotificationJobPayloadNotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BatchNotificationJobPayloadNotification', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['title', 'body']);
      final val = BatchNotificationJobPayloadNotification(
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BatchNotificationJobPayloadNotificationToJson(
  BatchNotificationJobPayloadNotification instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'data': ?instance.data,
};
