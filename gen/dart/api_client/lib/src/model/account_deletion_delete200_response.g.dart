// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_delete200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionDelete200ResponseCWProxy {
  AccountDeletionDelete200Response message(String? message);

  AccountDeletionDelete200Response data(
    AccountDeletionDelete200ResponseData data,
  );

  AccountDeletionDelete200Response pagination(PaginationResult? pagination);

  AccountDeletionDelete200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionDelete200Response call({
    String? message,
    AccountDeletionDelete200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionDelete200Response.copyWith(...)` or call `instanceOfAccountDeletionDelete200Response.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionDelete200ResponseCWProxyImpl
    implements _$AccountDeletionDelete200ResponseCWProxy {
  const _$AccountDeletionDelete200ResponseCWProxyImpl(this._value);

  final AccountDeletionDelete200Response _value;

  @override
  AccountDeletionDelete200Response message(String? message) =>
      call(message: message);

  @override
  AccountDeletionDelete200Response data(
    AccountDeletionDelete200ResponseData data,
  ) => call(data: data);

  @override
  AccountDeletionDelete200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AccountDeletionDelete200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionDelete200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionDelete200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AccountDeletionDelete200ResponseData,
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

extension $AccountDeletionDelete200ResponseCopyWith
    on AccountDeletionDelete200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionDelete200Response.copyWith(...)` or `instanceOfAccountDeletionDelete200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionDelete200ResponseCWProxy get copyWith =>
      _$AccountDeletionDelete200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionDelete200Response _$AccountDeletionDelete200ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('AccountDeletionDelete200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = AccountDeletionDelete200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => AccountDeletionDelete200ResponseData.fromJson(
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

Map<String, dynamic> _$AccountDeletionDelete200ResponseToJson(
  AccountDeletionDelete200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
