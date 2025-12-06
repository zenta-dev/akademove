// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionList200ResponseCWProxy {
  AccountDeletionList200Response message(String message);

  AccountDeletionList200Response data(AccountDeletionList200ResponseData data);

  AccountDeletionList200Response pagination(PaginationResult? pagination);

  AccountDeletionList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200Response call({
    String message,
    AccountDeletionList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionList200Response.copyWith(...)` or call `instanceOfAccountDeletionList200Response.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionList200ResponseCWProxyImpl
    implements _$AccountDeletionList200ResponseCWProxy {
  const _$AccountDeletionList200ResponseCWProxyImpl(this._value);

  final AccountDeletionList200Response _value;

  @override
  AccountDeletionList200Response message(String message) =>
      call(message: message);

  @override
  AccountDeletionList200Response data(
    AccountDeletionList200ResponseData data,
  ) => call(data: data);

  @override
  AccountDeletionList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AccountDeletionList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AccountDeletionList200ResponseData,
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

extension $AccountDeletionList200ResponseCopyWith
    on AccountDeletionList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionList200Response.copyWith(...)` or `instanceOfAccountDeletionList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionList200ResponseCWProxy get copyWith =>
      _$AccountDeletionList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionList200Response _$AccountDeletionList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccountDeletionList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AccountDeletionList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => AccountDeletionList200ResponseData.fromJson(
        v as Map<String, dynamic>,
      ),
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

Map<String, dynamic> _$AccountDeletionList200ResponseToJson(
  AccountDeletionList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
