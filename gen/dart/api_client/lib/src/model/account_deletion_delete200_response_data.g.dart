// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_delete200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionDelete200ResponseDataCWProxy {
  AccountDeletionDelete200ResponseData success(bool success);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionDelete200ResponseData call({bool success});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionDelete200ResponseData.copyWith(...)` or call `instanceOfAccountDeletionDelete200ResponseData.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionDelete200ResponseDataCWProxyImpl
    implements _$AccountDeletionDelete200ResponseDataCWProxy {
  const _$AccountDeletionDelete200ResponseDataCWProxyImpl(this._value);

  final AccountDeletionDelete200ResponseData _value;

  @override
  AccountDeletionDelete200ResponseData success(bool success) =>
      call(success: success);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionDelete200ResponseData call({
    Object? success = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionDelete200ResponseData(
      success: success == const $CopyWithPlaceholder() || success == null
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool,
    );
  }
}

extension $AccountDeletionDelete200ResponseDataCopyWith
    on AccountDeletionDelete200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionDelete200ResponseData.copyWith(...)` or `instanceOfAccountDeletionDelete200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionDelete200ResponseDataCWProxy get copyWith =>
      _$AccountDeletionDelete200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionDelete200ResponseData
_$AccountDeletionDelete200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AccountDeletionDelete200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['success']);
      final val = AccountDeletionDelete200ResponseData(
        success: $checkedConvert('success', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$AccountDeletionDelete200ResponseDataToJson(
  AccountDeletionDelete200ResponseData instance,
) => <String, dynamic>{'success': instance.success};
