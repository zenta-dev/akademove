// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_suspend_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverSuspendRequestCWProxy {
  DriverSuspendRequest reason(String reason);

  DriverSuspendRequest suspendUntil(DateTime? suspendUntil);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSuspendRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSuspendRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSuspendRequest call({String reason, DateTime? suspendUntil});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverSuspendRequest.copyWith(...)` or call `instanceOfDriverSuspendRequest.copyWith.fieldName(value)` for a single field.
class _$DriverSuspendRequestCWProxyImpl
    implements _$DriverSuspendRequestCWProxy {
  const _$DriverSuspendRequestCWProxyImpl(this._value);

  final DriverSuspendRequest _value;

  @override
  DriverSuspendRequest reason(String reason) => call(reason: reason);

  @override
  DriverSuspendRequest suspendUntil(DateTime? suspendUntil) =>
      call(suspendUntil: suspendUntil);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSuspendRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSuspendRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSuspendRequest call({
    Object? reason = const $CopyWithPlaceholder(),
    Object? suspendUntil = const $CopyWithPlaceholder(),
  }) {
    return DriverSuspendRequest(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      suspendUntil: suspendUntil == const $CopyWithPlaceholder()
          ? _value.suspendUntil
          // ignore: cast_nullable_to_non_nullable
          : suspendUntil as DateTime?,
    );
  }
}

extension $DriverSuspendRequestCopyWith on DriverSuspendRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverSuspendRequest.copyWith(...)` or `instanceOfDriverSuspendRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverSuspendRequestCWProxy get copyWith =>
      _$DriverSuspendRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSuspendRequest _$DriverSuspendRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverSuspendRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['reason']);
  final val = DriverSuspendRequest(
    reason: $checkedConvert('reason', (v) => v as String),
    suspendUntil: $checkedConvert(
      'suspendUntil',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$DriverSuspendRequestToJson(
  DriverSuspendRequest instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'suspendUntil': ?instance.suspendUntil?.toIso8601String(),
};
