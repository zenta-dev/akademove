// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_get_saved_bank_account200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletGetSavedBankAccount200ResponseCWProxy {
  DriverWalletGetSavedBankAccount200Response message(String message);

  DriverWalletGetSavedBankAccount200Response data(SavedBankAccount data);

  DriverWalletGetSavedBankAccount200Response pagination(
    PaginationResult? pagination,
  );

  DriverWalletGetSavedBankAccount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetSavedBankAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetSavedBankAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetSavedBankAccount200Response call({
    String message,
    SavedBankAccount data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletGetSavedBankAccount200Response.copyWith(...)` or call `instanceOfDriverWalletGetSavedBankAccount200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletGetSavedBankAccount200ResponseCWProxyImpl
    implements _$DriverWalletGetSavedBankAccount200ResponseCWProxy {
  const _$DriverWalletGetSavedBankAccount200ResponseCWProxyImpl(this._value);

  final DriverWalletGetSavedBankAccount200Response _value;

  @override
  DriverWalletGetSavedBankAccount200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletGetSavedBankAccount200Response data(SavedBankAccount data) =>
      call(data: data);

  @override
  DriverWalletGetSavedBankAccount200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverWalletGetSavedBankAccount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetSavedBankAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetSavedBankAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetSavedBankAccount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletGetSavedBankAccount200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SavedBankAccount,
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

extension $DriverWalletGetSavedBankAccount200ResponseCopyWith
    on DriverWalletGetSavedBankAccount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletGetSavedBankAccount200Response.copyWith(...)` or `instanceOfDriverWalletGetSavedBankAccount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletGetSavedBankAccount200ResponseCWProxy get copyWith =>
      _$DriverWalletGetSavedBankAccount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletGetSavedBankAccount200Response
_$DriverWalletGetSavedBankAccount200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverWalletGetSavedBankAccount200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverWalletGetSavedBankAccount200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => SavedBankAccount.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverWalletGetSavedBankAccount200ResponseToJson(
  DriverWalletGetSavedBankAccount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
