// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_delete200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationDelete200ResponseDataCWProxy {
  NotificationDelete200ResponseData ok(bool ok);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationDelete200ResponseData call({bool ok});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationDelete200ResponseData.copyWith(...)` or call `instanceOfNotificationDelete200ResponseData.copyWith.fieldName(value)` for a single field.
class _$NotificationDelete200ResponseDataCWProxyImpl
    implements _$NotificationDelete200ResponseDataCWProxy {
  const _$NotificationDelete200ResponseDataCWProxyImpl(this._value);

  final NotificationDelete200ResponseData _value;

  @override
  NotificationDelete200ResponseData ok(bool ok) => call(ok: ok);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationDelete200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
  }) {
    return NotificationDelete200ResponseData(
      ok: ok == const $CopyWithPlaceholder() || ok == null
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
    );
  }
}

extension $NotificationDelete200ResponseDataCopyWith
    on NotificationDelete200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationDelete200ResponseData.copyWith(...)` or `instanceOfNotificationDelete200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationDelete200ResponseDataCWProxy get copyWith =>
      _$NotificationDelete200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDelete200ResponseData _$NotificationDelete200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('NotificationDelete200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['ok']);
  final val = NotificationDelete200ResponseData(
    ok: $checkedConvert('ok', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$NotificationDelete200ResponseDataToJson(
  NotificationDelete200ResponseData instance,
) => <String, dynamic>{'ok': instance.ok};
