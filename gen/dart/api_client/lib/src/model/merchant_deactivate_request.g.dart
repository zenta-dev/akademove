// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_deactivate_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantDeactivateRequestCWProxy {
  MerchantDeactivateRequest reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantDeactivateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantDeactivateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantDeactivateRequest call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantDeactivateRequest.copyWith(...)` or call `instanceOfMerchantDeactivateRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantDeactivateRequestCWProxyImpl
    implements _$MerchantDeactivateRequestCWProxy {
  const _$MerchantDeactivateRequestCWProxyImpl(this._value);

  final MerchantDeactivateRequest _value;

  @override
  MerchantDeactivateRequest reason(String reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantDeactivateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantDeactivateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantDeactivateRequest call({
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return MerchantDeactivateRequest(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $MerchantDeactivateRequestCopyWith on MerchantDeactivateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantDeactivateRequest.copyWith(...)` or `instanceOfMerchantDeactivateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantDeactivateRequestCWProxy get copyWith =>
      _$MerchantDeactivateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantDeactivateRequest _$MerchantDeactivateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantDeactivateRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['reason']);
  final val = MerchantDeactivateRequest(
    reason: $checkedConvert('reason', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$MerchantDeactivateRequestToJson(
  MerchantDeactivateRequest instance,
) => <String, dynamic>{'reason': instance.reason};
