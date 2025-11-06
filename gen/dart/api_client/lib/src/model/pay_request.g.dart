// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayRequestCWProxy {
  PayRequest amount(num amount);

  PayRequest referenceId(String? referenceId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  PayRequest call({num amount, String? referenceId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayRequest.copyWith.fieldName(...)`
class _$PayRequestCWProxyImpl implements _$PayRequestCWProxy {
  const _$PayRequestCWProxyImpl(this._value);

  final PayRequest _value;

  @override
  PayRequest amount(num amount) => this(amount: amount);

  @override
  PayRequest referenceId(String? referenceId) => this(referenceId: referenceId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  PayRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? referenceId = const $CopyWithPlaceholder(),
  }) {
    return PayRequest(
      amount: amount == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfPayRequest.copyWith(...)` or like so:`instanceOfPayRequest.copyWith.fieldName(...)`.
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
