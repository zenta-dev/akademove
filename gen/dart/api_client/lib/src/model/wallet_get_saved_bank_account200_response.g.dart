// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_get_saved_bank_account200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletGetSavedBankAccount200ResponseCWProxy {
  WalletGetSavedBankAccount200Response message(String message);

  WalletGetSavedBankAccount200Response data(SavedBankAccount data);

  WalletGetSavedBankAccount200Response pagination(PaginationResult? pagination);

  WalletGetSavedBankAccount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGetSavedBankAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGetSavedBankAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGetSavedBankAccount200Response call({
    String message,
    SavedBankAccount data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletGetSavedBankAccount200Response.copyWith(...)` or call `instanceOfWalletGetSavedBankAccount200Response.copyWith.fieldName(value)` for a single field.
class _$WalletGetSavedBankAccount200ResponseCWProxyImpl
    implements _$WalletGetSavedBankAccount200ResponseCWProxy {
  const _$WalletGetSavedBankAccount200ResponseCWProxyImpl(this._value);

  final WalletGetSavedBankAccount200Response _value;

  @override
  WalletGetSavedBankAccount200Response message(String message) =>
      call(message: message);

  @override
  WalletGetSavedBankAccount200Response data(SavedBankAccount data) =>
      call(data: data);

  @override
  WalletGetSavedBankAccount200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  WalletGetSavedBankAccount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGetSavedBankAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGetSavedBankAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGetSavedBankAccount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletGetSavedBankAccount200Response(
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

extension $WalletGetSavedBankAccount200ResponseCopyWith
    on WalletGetSavedBankAccount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletGetSavedBankAccount200Response.copyWith(...)` or `instanceOfWalletGetSavedBankAccount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletGetSavedBankAccount200ResponseCWProxy get copyWith =>
      _$WalletGetSavedBankAccount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletGetSavedBankAccount200Response
_$WalletGetSavedBankAccount200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WalletGetSavedBankAccount200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = WalletGetSavedBankAccount200Response(
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

Map<String, dynamic> _$WalletGetSavedBankAccount200ResponseToJson(
  WalletGetSavedBankAccount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
