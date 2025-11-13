// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveToken200ResponseDataCWProxy {
  NotificationSaveToken200ResponseData ok(bool ok);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveToken200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveToken200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveToken200ResponseData call({bool ok});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationSaveToken200ResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationSaveToken200ResponseData.copyWith.fieldName(...)`
class _$NotificationSaveToken200ResponseDataCWProxyImpl
    implements _$NotificationSaveToken200ResponseDataCWProxy {
  const _$NotificationSaveToken200ResponseDataCWProxyImpl(this._value);

  final NotificationSaveToken200ResponseData _value;

  @override
  NotificationSaveToken200ResponseData ok(bool ok) => this(ok: ok);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveToken200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveToken200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveToken200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveToken200ResponseData(
      ok: ok == const $CopyWithPlaceholder()
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
    );
  }
}

extension $NotificationSaveToken200ResponseDataCopyWith
    on NotificationSaveToken200ResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationSaveToken200ResponseData.copyWith(...)` or like so:`instanceOfNotificationSaveToken200ResponseData.copyWith.fieldName(...)`.
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
