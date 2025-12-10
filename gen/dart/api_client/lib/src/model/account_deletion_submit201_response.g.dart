// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_submit201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionSubmit201ResponseCWProxy {
  AccountDeletionSubmit201Response message(String? message);

  AccountDeletionSubmit201Response data(AccountDeletion data);

  AccountDeletionSubmit201Response pagination(PaginationResult? pagination);

  AccountDeletionSubmit201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionSubmit201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionSubmit201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionSubmit201Response call({
    String? message,
    AccountDeletion data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionSubmit201Response.copyWith(...)` or call `instanceOfAccountDeletionSubmit201Response.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionSubmit201ResponseCWProxyImpl
    implements _$AccountDeletionSubmit201ResponseCWProxy {
  const _$AccountDeletionSubmit201ResponseCWProxyImpl(this._value);

  final AccountDeletionSubmit201Response _value;

  @override
  AccountDeletionSubmit201Response message(String? message) =>
      call(message: message);

  @override
  AccountDeletionSubmit201Response data(AccountDeletion data) =>
      call(data: data);

  @override
  AccountDeletionSubmit201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AccountDeletionSubmit201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionSubmit201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionSubmit201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionSubmit201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionSubmit201Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AccountDeletion,
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

extension $AccountDeletionSubmit201ResponseCopyWith
    on AccountDeletionSubmit201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionSubmit201Response.copyWith(...)` or `instanceOfAccountDeletionSubmit201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionSubmit201ResponseCWProxy get copyWith =>
      _$AccountDeletionSubmit201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionSubmit201Response _$AccountDeletionSubmit201ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('AccountDeletionSubmit201Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = AccountDeletionSubmit201Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => AccountDeletion.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$AccountDeletionSubmit201ResponseToJson(
  AccountDeletionSubmit201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
