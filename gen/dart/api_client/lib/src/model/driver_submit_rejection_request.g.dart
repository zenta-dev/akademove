// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_submit_rejection_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverSubmitRejectionRequestCWProxy {
  DriverSubmitRejectionRequest reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSubmitRejectionRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSubmitRejectionRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSubmitRejectionRequest call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverSubmitRejectionRequest.copyWith(...)` or call `instanceOfDriverSubmitRejectionRequest.copyWith.fieldName(value)` for a single field.
class _$DriverSubmitRejectionRequestCWProxyImpl
    implements _$DriverSubmitRejectionRequestCWProxy {
  const _$DriverSubmitRejectionRequestCWProxyImpl(this._value);

  final DriverSubmitRejectionRequest _value;

  @override
  DriverSubmitRejectionRequest reason(String reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSubmitRejectionRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSubmitRejectionRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSubmitRejectionRequest call({
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return DriverSubmitRejectionRequest(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $DriverSubmitRejectionRequestCopyWith
    on DriverSubmitRejectionRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverSubmitRejectionRequest.copyWith(...)` or `instanceOfDriverSubmitRejectionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverSubmitRejectionRequestCWProxy get copyWith =>
      _$DriverSubmitRejectionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSubmitRejectionRequest _$DriverSubmitRejectionRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverSubmitRejectionRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['reason']);
  final val = DriverSubmitRejectionRequest(
    reason: $checkedConvert('reason', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$DriverSubmitRejectionRequestToJson(
  DriverSubmitRejectionRequest instance,
) => <String, dynamic>{'reason': instance.reason};
