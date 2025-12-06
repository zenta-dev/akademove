// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionList200ResponseDataCWProxy {
  AccountDeletionList200ResponseData rows(List<AccountDeletion> rows);

  AccountDeletionList200ResponseData pagination(
    AccountDeletionList200ResponseDataPagination? pagination,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200ResponseData call({
    List<AccountDeletion> rows,
    AccountDeletionList200ResponseDataPagination? pagination,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionList200ResponseData.copyWith(...)` or call `instanceOfAccountDeletionList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionList200ResponseDataCWProxyImpl
    implements _$AccountDeletionList200ResponseDataCWProxy {
  const _$AccountDeletionList200ResponseDataCWProxyImpl(this._value);

  final AccountDeletionList200ResponseData _value;

  @override
  AccountDeletionList200ResponseData rows(List<AccountDeletion> rows) =>
      call(rows: rows);

  @override
  AccountDeletionList200ResponseData pagination(
    AccountDeletionList200ResponseDataPagination? pagination,
  ) => call(pagination: pagination);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<AccountDeletion>,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as AccountDeletionList200ResponseDataPagination?,
    );
  }
}

extension $AccountDeletionList200ResponseDataCopyWith
    on AccountDeletionList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionList200ResponseData.copyWith(...)` or `instanceOfAccountDeletionList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionList200ResponseDataCWProxy get copyWith =>
      _$AccountDeletionList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionList200ResponseData _$AccountDeletionList200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccountDeletionList200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['rows']);
  final val = AccountDeletionList200ResponseData(
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>)
          .map((e) => AccountDeletion.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : AccountDeletionList200ResponseDataPagination.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$AccountDeletionList200ResponseDataToJson(
  AccountDeletionList200ResponseData instance,
) => <String, dynamic>{
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
};
