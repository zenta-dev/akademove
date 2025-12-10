// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_reject_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverRejectRequestCWProxy {
  DriverRejectRequest reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverRejectRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverRejectRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverRejectRequest call({String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverRejectRequest.copyWith(...)` or call `instanceOfDriverRejectRequest.copyWith.fieldName(value)` for a single field.
class _$DriverRejectRequestCWProxyImpl implements _$DriverRejectRequestCWProxy {
  const _$DriverRejectRequestCWProxyImpl(this._value);

  final DriverRejectRequest _value;

  @override
  DriverRejectRequest reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverRejectRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverRejectRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverRejectRequest call({Object? reason = const $CopyWithPlaceholder()}) {
    return DriverRejectRequest(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $DriverRejectRequestCopyWith on DriverRejectRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverRejectRequest.copyWith(...)` or `instanceOfDriverRejectRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverRejectRequestCWProxy get copyWith =>
      _$DriverRejectRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverRejectRequest _$DriverRejectRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverRejectRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = DriverRejectRequest(
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DriverRejectRequestToJson(
  DriverRejectRequest instance,
) => <String, dynamic>{'reason': instance.reason};
