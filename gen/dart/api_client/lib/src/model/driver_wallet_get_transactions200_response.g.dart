// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_get_transactions200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletGetTransactions200ResponseCWProxy {
  DriverWalletGetTransactions200Response message(String message);

  DriverWalletGetTransactions200Response data(List<Transaction> data);

  DriverWalletGetTransactions200Response pagination(
    PaginationResult? pagination,
  );

  DriverWalletGetTransactions200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetTransactions200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetTransactions200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetTransactions200Response call({
    String message,
    List<Transaction> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletGetTransactions200Response.copyWith(...)` or call `instanceOfDriverWalletGetTransactions200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletGetTransactions200ResponseCWProxyImpl
    implements _$DriverWalletGetTransactions200ResponseCWProxy {
  const _$DriverWalletGetTransactions200ResponseCWProxyImpl(this._value);

  final DriverWalletGetTransactions200Response _value;

  @override
  DriverWalletGetTransactions200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletGetTransactions200Response data(List<Transaction> data) =>
      call(data: data);

  @override
  DriverWalletGetTransactions200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverWalletGetTransactions200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetTransactions200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetTransactions200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetTransactions200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletGetTransactions200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
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

extension $DriverWalletGetTransactions200ResponseCopyWith
    on DriverWalletGetTransactions200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletGetTransactions200Response.copyWith(...)` or `instanceOfDriverWalletGetTransactions200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletGetTransactions200ResponseCWProxy get copyWith =>
      _$DriverWalletGetTransactions200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletGetTransactions200Response
_$DriverWalletGetTransactions200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverWalletGetTransactions200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverWalletGetTransactions200Response(
        message: $checkedConvert('message', (v) => v as String),
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

Map<String, dynamic> _$DriverWalletGetTransactions200ResponseToJson(
  DriverWalletGetTransactions200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
