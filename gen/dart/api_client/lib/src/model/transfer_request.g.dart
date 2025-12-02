// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransferRequestCWProxy {
  TransferRequest amount(num amount);

  TransferRequest walletId(String walletId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransferRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransferRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  TransferRequest call({num amount, String walletId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransferRequest.copyWith(...)` or call `instanceOfTransferRequest.copyWith.fieldName(value)` for a single field.
class _$TransferRequestCWProxyImpl implements _$TransferRequestCWProxy {
  const _$TransferRequestCWProxyImpl(this._value);

  final TransferRequest _value;

  @override
  TransferRequest amount(num amount) => call(amount: amount);

  @override
  TransferRequest walletId(String walletId) => call(walletId: walletId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransferRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransferRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  TransferRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? walletId = const $CopyWithPlaceholder(),
  }) {
    return TransferRequest(
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      walletId: walletId == const $CopyWithPlaceholder() || walletId == null
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String,
    );
  }
}

extension $TransferRequestCopyWith on TransferRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransferRequest.copyWith(...)` or `instanceOfTransferRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransferRequestCWProxy get copyWith => _$TransferRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TransferRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount', 'walletId']);
      final val = TransferRequest(
        amount: $checkedConvert('amount', (v) => v as num),
        walletId: $checkedConvert('walletId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TransferRequestToJson(TransferRequest instance) =>
    <String, dynamic>{'amount': instance.amount, 'walletId': instance.walletId};
