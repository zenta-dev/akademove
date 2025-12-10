// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransferResponseCWProxy {
  TransferResponse transactionId(String transactionId);

  TransferResponse amount(num amount);

  TransferResponse status(TransactionStatus status);

  TransferResponse recipientName(String recipientName);

  TransferResponse recipientUserId(String recipientUserId);

  TransferResponse note(String? note);

  TransferResponse createdAt(DateTime createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransferResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransferResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  TransferResponse call({
    String transactionId,
    num amount,
    TransactionStatus status,
    String recipientName,
    String recipientUserId,
    String? note,
    DateTime createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransferResponse.copyWith(...)` or call `instanceOfTransferResponse.copyWith.fieldName(value)` for a single field.
class _$TransferResponseCWProxyImpl implements _$TransferResponseCWProxy {
  const _$TransferResponseCWProxyImpl(this._value);

  final TransferResponse _value;

  @override
  TransferResponse transactionId(String transactionId) =>
      call(transactionId: transactionId);

  @override
  TransferResponse amount(num amount) => call(amount: amount);

  @override
  TransferResponse status(TransactionStatus status) => call(status: status);

  @override
  TransferResponse recipientName(String recipientName) =>
      call(recipientName: recipientName);

  @override
  TransferResponse recipientUserId(String recipientUserId) =>
      call(recipientUserId: recipientUserId);

  @override
  TransferResponse note(String? note) => call(note: note);

  @override
  TransferResponse createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransferResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransferResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  TransferResponse call({
    Object? transactionId = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? recipientName = const $CopyWithPlaceholder(),
    Object? recipientUserId = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return TransferResponse(
      transactionId:
          transactionId == const $CopyWithPlaceholder() || transactionId == null
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TransactionStatus,
      recipientName:
          recipientName == const $CopyWithPlaceholder() || recipientName == null
          ? _value.recipientName
          // ignore: cast_nullable_to_non_nullable
          : recipientName as String,
      recipientUserId:
          recipientUserId == const $CopyWithPlaceholder() ||
              recipientUserId == null
          ? _value.recipientUserId
          // ignore: cast_nullable_to_non_nullable
          : recipientUserId as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $TransferResponseCopyWith on TransferResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransferResponse.copyWith(...)` or `instanceOfTransferResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransferResponseCWProxy get copyWith => _$TransferResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferResponse _$TransferResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TransferResponse', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'transactionId',
          'amount',
          'status',
          'recipientName',
          'recipientUserId',
          'createdAt',
        ],
      );
      final val = TransferResponse(
        transactionId: $checkedConvert('transactionId', (v) => v as String),
        amount: $checkedConvert('amount', (v) => v as num),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$TransactionStatusEnumMap, v),
        ),
        recipientName: $checkedConvert('recipientName', (v) => v as String),
        recipientUserId: $checkedConvert('recipientUserId', (v) => v as String),
        note: $checkedConvert('note', (v) => v as String?),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TransferResponseToJson(TransferResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'amount': instance.amount,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'recipientName': instance.recipientName,
      'recipientUserId': instance.recipientUserId,
      'note': ?instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.SUCCESS: 'SUCCESS',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.CANCELLED: 'CANCELLED',
  TransactionStatus.EXPIRED: 'EXPIRED',
  TransactionStatus.REFUNDED: 'REFUNDED',
};
