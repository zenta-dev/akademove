// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionGet200ResponseCWProxy {
  TransactionGet200Response message(String message);

  TransactionGet200Response data(Transaction data);

  TransactionGet200Response pagination(PaginationResult? pagination);

  TransactionGet200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionGet200Response call({
    String message,
    Transaction data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionGet200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionGet200Response.copyWith.fieldName(...)`
class _$TransactionGet200ResponseCWProxyImpl
    implements _$TransactionGet200ResponseCWProxy {
  const _$TransactionGet200ResponseCWProxyImpl(this._value);

  final TransactionGet200Response _value;

  @override
  TransactionGet200Response message(String message) => this(message: message);

  @override
  TransactionGet200Response data(Transaction data) => this(data: data);

  @override
  TransactionGet200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  TransactionGet200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return TransactionGet200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Transaction,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $TransactionGet200ResponseCopyWith on TransactionGet200Response {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionGet200Response.copyWith(...)` or like so:`instanceOfTransactionGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionGet200ResponseCWProxy get copyWith =>
      _$TransactionGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionGet200Response _$TransactionGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('TransactionGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = TransactionGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Transaction.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$TransactionGet200ResponseToJson(
  TransactionGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
