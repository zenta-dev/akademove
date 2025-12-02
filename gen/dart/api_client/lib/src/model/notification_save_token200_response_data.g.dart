// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveToken200ResponseDataCWProxy {
  NotificationSaveToken200ResponseData ok(bool ok);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveToken200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveToken200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveToken200ResponseData call({bool ok});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationSaveToken200ResponseData.copyWith(...)` or call `instanceOfNotificationSaveToken200ResponseData.copyWith.fieldName(value)` for a single field.
class _$NotificationSaveToken200ResponseDataCWProxyImpl
    implements _$NotificationSaveToken200ResponseDataCWProxy {
  const _$NotificationSaveToken200ResponseDataCWProxyImpl(this._value);

  final NotificationSaveToken200ResponseData _value;

  @override
  NotificationSaveToken200ResponseData ok(bool ok) => call(ok: ok);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveToken200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveToken200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveToken200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveToken200ResponseData(
      ok: ok == const $CopyWithPlaceholder() || ok == null
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
    );
  }
}

extension $NotificationSaveToken200ResponseDataCopyWith
    on NotificationSaveToken200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationSaveToken200ResponseData.copyWith(...)` or `instanceOfNotificationSaveToken200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSaveToken200ResponseDataCWProxy get copyWith =>
      _$NotificationSaveToken200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSaveToken200ResponseData
_$NotificationSaveToken200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationSaveToken200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['ok']);
      final val = NotificationSaveToken200ResponseData(
        ok: $checkedConvert('ok', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$NotificationSaveToken200ResponseDataToJson(
  NotificationSaveToken200ResponseData instance,
) => <String, dynamic>{'ok': instance.ok};
