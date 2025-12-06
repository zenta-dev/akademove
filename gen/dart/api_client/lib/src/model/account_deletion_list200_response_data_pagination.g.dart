// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_list200_response_data_pagination.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionList200ResponseDataPaginationCWProxy {
  AccountDeletionList200ResponseDataPagination totalPages(int totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200ResponseDataPagination(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200ResponseDataPagination(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200ResponseDataPagination call({int totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionList200ResponseDataPagination.copyWith(...)` or call `instanceOfAccountDeletionList200ResponseDataPagination.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionList200ResponseDataPaginationCWProxyImpl
    implements _$AccountDeletionList200ResponseDataPaginationCWProxy {
  const _$AccountDeletionList200ResponseDataPaginationCWProxyImpl(this._value);

  final AccountDeletionList200ResponseDataPagination _value;

  @override
  AccountDeletionList200ResponseDataPagination totalPages(int totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200ResponseDataPagination(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200ResponseDataPagination(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200ResponseDataPagination call({
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionList200ResponseDataPagination(
      totalPages:
          totalPages == const $CopyWithPlaceholder() || totalPages == null
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int,
    );
  }
}

extension $AccountDeletionList200ResponseDataPaginationCopyWith
    on AccountDeletionList200ResponseDataPagination {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionList200ResponseDataPagination.copyWith(...)` or `instanceOfAccountDeletionList200ResponseDataPagination.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionList200ResponseDataPaginationCWProxy get copyWith =>
      _$AccountDeletionList200ResponseDataPaginationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionList200ResponseDataPagination
_$AccountDeletionList200ResponseDataPaginationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccountDeletionList200ResponseDataPagination', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['totalPages']);
  final val = AccountDeletionList200ResponseDataPagination(
    totalPages: $checkedConvert('totalPages', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$AccountDeletionList200ResponseDataPaginationToJson(
  AccountDeletionList200ResponseDataPagination instance,
) => <String, dynamic>{'totalPages': instance.totalPages};
