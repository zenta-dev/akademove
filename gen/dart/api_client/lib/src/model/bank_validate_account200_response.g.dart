// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_validate_account200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankValidateAccount200ResponseCWProxy {
  BankValidateAccount200Response message(String message);

  BankValidateAccount200Response data(BankValidationResponse data);

  BankValidateAccount200Response pagination(PaginationResult? pagination);

  BankValidateAccount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidateAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidateAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidateAccount200Response call({
    String message,
    BankValidationResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBankValidateAccount200Response.copyWith(...)` or call `instanceOfBankValidateAccount200Response.copyWith.fieldName(value)` for a single field.
class _$BankValidateAccount200ResponseCWProxyImpl
    implements _$BankValidateAccount200ResponseCWProxy {
  const _$BankValidateAccount200ResponseCWProxyImpl(this._value);

  final BankValidateAccount200Response _value;

  @override
  BankValidateAccount200Response message(String message) =>
      call(message: message);

  @override
  BankValidateAccount200Response data(BankValidationResponse data) =>
      call(data: data);

  @override
  BankValidateAccount200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BankValidateAccount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidateAccount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidateAccount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidateAccount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BankValidateAccount200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BankValidationResponse,
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

extension $BankValidateAccount200ResponseCopyWith
    on BankValidateAccount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBankValidateAccount200Response.copyWith(...)` or `instanceOfBankValidateAccount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankValidateAccount200ResponseCWProxy get copyWith =>
      _$BankValidateAccount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankValidateAccount200Response _$BankValidateAccount200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BankValidateAccount200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BankValidateAccount200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BankValidationResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$BankValidateAccount200ResponseToJson(
  BankValidateAccount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
