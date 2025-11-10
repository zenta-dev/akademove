// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionList200ResponseCWProxy {
  TransactionList200Response message(String message);

  TransactionList200Response data(List<Transaction> data);

  TransactionList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionList200Response call({
    String message,
    List<Transaction> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionList200Response.copyWith.fieldName(...)`
class _$TransactionList200ResponseCWProxyImpl
    implements _$TransactionList200ResponseCWProxy {
  const _$TransactionList200ResponseCWProxyImpl(this._value);

  final TransactionList200Response _value;

  @override
  TransactionList200Response message(String message) => this(message: message);

  @override
  TransactionList200Response data(List<Transaction> data) => this(data: data);

  @override
  TransactionList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return TransactionList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Transaction>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $TransactionList200ResponseCopyWith on TransactionList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionList200Response.copyWith(...)` or like so:`instanceOfTransactionList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionList200ResponseCWProxy get copyWith =>
      _$TransactionList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionList200Response _$TransactionList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('TransactionList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = TransactionList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$TransactionList200ResponseToJson(
  TransactionList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
