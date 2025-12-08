// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_online_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateOnlineStatusRequestCWProxy {
  DriverUpdateOnlineStatusRequest isOnline(bool isOnline);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateOnlineStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateOnlineStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateOnlineStatusRequest call({bool isOnline});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverUpdateOnlineStatusRequest.copyWith(...)` or call `instanceOfDriverUpdateOnlineStatusRequest.copyWith.fieldName(value)` for a single field.
class _$DriverUpdateOnlineStatusRequestCWProxyImpl
    implements _$DriverUpdateOnlineStatusRequestCWProxy {
  const _$DriverUpdateOnlineStatusRequestCWProxyImpl(this._value);

  final DriverUpdateOnlineStatusRequest _value;

  @override
  DriverUpdateOnlineStatusRequest isOnline(bool isOnline) =>
      call(isOnline: isOnline);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateOnlineStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateOnlineStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateOnlineStatusRequest call({
    Object? isOnline = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateOnlineStatusRequest(
      isOnline: isOnline == const $CopyWithPlaceholder() || isOnline == null
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool,
    );
  }
}

extension $DriverUpdateOnlineStatusRequestCopyWith
    on DriverUpdateOnlineStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverUpdateOnlineStatusRequest.copyWith(...)` or `instanceOfDriverUpdateOnlineStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateOnlineStatusRequestCWProxy get copyWith =>
      _$DriverUpdateOnlineStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateOnlineStatusRequest _$DriverUpdateOnlineStatusRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverUpdateOnlineStatusRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['isOnline']);
  final val = DriverUpdateOnlineStatusRequest(
    isOnline: $checkedConvert('isOnline', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$DriverUpdateOnlineStatusRequestToJson(
  DriverUpdateOnlineStatusRequest instance,
) => <String, dynamic>{'isOnline': instance.isOnline};
