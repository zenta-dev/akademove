// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TopUpRequestCWProxy {
  TopUpRequest amount(num amount);

  TopUpRequest provider(PaymentProvider provider);

  TopUpRequest method(TopUpRequestMethodEnum method);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TopUpRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TopUpRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  TopUpRequest call({
    num amount,
    PaymentProvider provider,
    TopUpRequestMethodEnum method,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTopUpRequest.copyWith(...)` or call `instanceOfTopUpRequest.copyWith.fieldName(value)` for a single field.
class _$TopUpRequestCWProxyImpl implements _$TopUpRequestCWProxy {
  const _$TopUpRequestCWProxyImpl(this._value);

  final TopUpRequest _value;

  @override
  TopUpRequest amount(num amount) => call(amount: amount);

  @override
  TopUpRequest provider(PaymentProvider provider) => call(provider: provider);

  @override
  TopUpRequest method(TopUpRequestMethodEnum method) => call(method: method);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TopUpRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TopUpRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  TopUpRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
  }) {
    return TopUpRequest(
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider,
      method: method == const $CopyWithPlaceholder() || method == null
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as TopUpRequestMethodEnum,
    );
  }
}

extension $TopUpRequestCopyWith on TopUpRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTopUpRequest.copyWith(...)` or `instanceOfTopUpRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TopUpRequestCWProxy get copyWith => _$TopUpRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpRequest _$TopUpRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TopUpRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount', 'provider', 'method']);
      final val = TopUpRequest(
        amount: $checkedConvert('amount', (v) => v as num),
        provider: $checkedConvert(
          'provider',
          (v) => $enumDecode(_$PaymentProviderEnumMap, v),
        ),
        method: $checkedConvert(
          'method',
          (v) => $enumDecode(_$TopUpRequestMethodEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TopUpRequestToJson(TopUpRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'provider': _$PaymentProviderEnumMap[instance.provider]!,
      'method': _$TopUpRequestMethodEnumEnumMap[instance.method]!,
    };

const _$PaymentProviderEnumMap = {
  PaymentProvider.MIDTRANS: 'MIDTRANS',
  PaymentProvider.MANUAL: 'MANUAL',
};

const _$TopUpRequestMethodEnumEnumMap = {
  TopUpRequestMethodEnum.QRIS: 'QRIS',
  TopUpRequestMethodEnum.VA: 'VA',
  TopUpRequestMethodEnum.BANK_TRANSFER: 'BANK_TRANSFER',
};
