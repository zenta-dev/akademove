// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayRequestCWProxy {
  PayRequest amount(num amount);

  PayRequest referenceId(String? referenceId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PayRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PayRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PayRequest call({num amount, String? referenceId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPayRequest.copyWith(...)` or call `instanceOfPayRequest.copyWith.fieldName(value)` for a single field.
class _$PayRequestCWProxyImpl implements _$PayRequestCWProxy {
  const _$PayRequestCWProxyImpl(this._value);

  final PayRequest _value;

  @override
  PayRequest amount(num amount) => call(amount: amount);

  @override
  PayRequest referenceId(String? referenceId) => call(referenceId: referenceId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PayRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PayRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PayRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? referenceId = const $CopyWithPlaceholder(),
  }) {
    return PayRequest(
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      referenceId: referenceId == const $CopyWithPlaceholder()
          ? _value.referenceId
          // ignore: cast_nullable_to_non_nullable
          : referenceId as String?,
    );
  }
}

extension $PayRequestCopyWith on PayRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPayRequest.copyWith(...)` or `instanceOfPayRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayRequestCWProxy get copyWith => _$PayRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayRequest _$PayRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PayRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount']);
      final val = PayRequest(
        amount: $checkedConvert('amount', (v) => v as num),
        referenceId: $checkedConvert('referenceId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PayRequestToJson(PayRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'referenceId': ?instance.referenceId,
    };
