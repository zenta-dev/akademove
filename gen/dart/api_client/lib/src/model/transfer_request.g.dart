// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransferRequestCWProxy {
  TransferRequest amount(num amount);

  TransferRequest walletId(String walletId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransferRequest call({num amount, String walletId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransferRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransferRequest.copyWith.fieldName(...)`
class _$TransferRequestCWProxyImpl implements _$TransferRequestCWProxy {
  const _$TransferRequestCWProxyImpl(this._value);

  final TransferRequest _value;

  @override
  TransferRequest amount(num amount) => this(amount: amount);

  @override
  TransferRequest walletId(String walletId) => this(walletId: walletId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransferRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? walletId = const $CopyWithPlaceholder(),
  }) {
    return TransferRequest(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      walletId: walletId == const $CopyWithPlaceholder()
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String,
    );
  }
}

extension $TransferRequestCopyWith on TransferRequest {
  /// Returns a callable class that can be used as follows: `instanceOfTransferRequest.copyWith(...)` or like so:`instanceOfTransferRequest.copyWith.fieldName(...)`.
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
