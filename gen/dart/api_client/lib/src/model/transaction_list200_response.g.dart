// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionList200ResponseCWProxy {
  TransactionList200Response message(String? message);

  TransactionList200Response data(List<Transaction> data);

  TransactionList200Response pagination(PaginationResult? pagination);

  TransactionList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionList200Response call({
    String? message,
    List<Transaction> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransactionList200Response.copyWith(...)` or call `instanceOfTransactionList200Response.copyWith.fieldName(value)` for a single field.
class _$TransactionList200ResponseCWProxyImpl
    implements _$TransactionList200ResponseCWProxy {
  const _$TransactionList200ResponseCWProxyImpl(this._value);

  final TransactionList200Response _value;

  @override
  TransactionList200Response message(String? message) => call(message: message);

  @override
  TransactionList200Response data(List<Transaction> data) => call(data: data);

  @override
  TransactionList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  TransactionList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return TransactionList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Transaction>,
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

extension $TransactionList200ResponseCopyWith on TransactionList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransactionList200Response.copyWith(...)` or `instanceOfTransactionList200Response.copyWith.fieldName(...)`.
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
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$TransactionList200ResponseToJson(
  TransactionList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
