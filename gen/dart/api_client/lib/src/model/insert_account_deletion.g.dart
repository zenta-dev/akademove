// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_account_deletion.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertAccountDeletionCWProxy {
  InsertAccountDeletion fullName(String fullName);

  InsertAccountDeletion email(String email);

  InsertAccountDeletion phone(String phone);

  InsertAccountDeletion accountType(AccountType accountType);

  InsertAccountDeletion reason(AccountDeletionReason reason);

  InsertAccountDeletion additionalInfo(String? additionalInfo);

  InsertAccountDeletion userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertAccountDeletion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertAccountDeletion(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertAccountDeletion call({
    String fullName,
    String email,
    String phone,
    AccountType accountType,
    AccountDeletionReason reason,
    String? additionalInfo,
    String? userId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertAccountDeletion.copyWith(...)` or call `instanceOfInsertAccountDeletion.copyWith.fieldName(value)` for a single field.
class _$InsertAccountDeletionCWProxyImpl
    implements _$InsertAccountDeletionCWProxy {
  const _$InsertAccountDeletionCWProxyImpl(this._value);

  final InsertAccountDeletion _value;

  @override
  InsertAccountDeletion fullName(String fullName) => call(fullName: fullName);

  @override
  InsertAccountDeletion email(String email) => call(email: email);

  @override
  InsertAccountDeletion phone(String phone) => call(phone: phone);

  @override
  InsertAccountDeletion accountType(AccountType accountType) =>
      call(accountType: accountType);

  @override
  InsertAccountDeletion reason(AccountDeletionReason reason) =>
      call(reason: reason);

  @override
  InsertAccountDeletion additionalInfo(String? additionalInfo) =>
      call(additionalInfo: additionalInfo);

  @override
  InsertAccountDeletion userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertAccountDeletion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertAccountDeletion(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertAccountDeletion call({
    Object? fullName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? accountType = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? additionalInfo = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return InsertAccountDeletion(
      fullName: fullName == const $CopyWithPlaceholder() || fullName == null
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      accountType:
          accountType == const $CopyWithPlaceholder() || accountType == null
          ? _value.accountType
          // ignore: cast_nullable_to_non_nullable
          : accountType as AccountType,
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as AccountDeletionReason,
      additionalInfo: additionalInfo == const $CopyWithPlaceholder()
          ? _value.additionalInfo
          // ignore: cast_nullable_to_non_nullable
          : additionalInfo as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $InsertAccountDeletionCopyWith on InsertAccountDeletion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertAccountDeletion.copyWith(...)` or `instanceOfInsertAccountDeletion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertAccountDeletionCWProxy get copyWith =>
      _$InsertAccountDeletionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertAccountDeletion _$InsertAccountDeletionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertAccountDeletion', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['fullName', 'email', 'phone', 'accountType', 'reason'],
  );
  final val = InsertAccountDeletion(
    fullName: $checkedConvert('fullName', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    accountType: $checkedConvert(
      'accountType',
      (v) => $enumDecode(_$AccountTypeEnumMap, v),
    ),
    reason: $checkedConvert(
      'reason',
      (v) => $enumDecode(_$AccountDeletionReasonEnumMap, v),
    ),
    additionalInfo: $checkedConvert('additionalInfo', (v) => v as String?),
    userId: $checkedConvert('userId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$InsertAccountDeletionToJson(
  InsertAccountDeletion instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'accountType': _$AccountTypeEnumMap[instance.accountType]!,
  'reason': _$AccountDeletionReasonEnumMap[instance.reason]!,
  'additionalInfo': ?instance.additionalInfo,
  'userId': ?instance.userId,
};

const _$AccountTypeEnumMap = {
  AccountType.USER: 'USER',
  AccountType.DRIVER: 'DRIVER',
  AccountType.MERCHANT: 'MERCHANT',
};

const _$AccountDeletionReasonEnumMap = {
  AccountDeletionReason.NO_LONGER_NEEDED: 'NO_LONGER_NEEDED',
  AccountDeletionReason.PRIVACY_CONCERNS: 'PRIVACY_CONCERNS',
  AccountDeletionReason.SWITCHING_SERVICE: 'SWITCHING_SERVICE',
  AccountDeletionReason.TOO_MANY_NOTIFICATIONS: 'TOO_MANY_NOTIFICATIONS',
  AccountDeletionReason.DIFFICULT_TO_USE: 'DIFFICULT_TO_USE',
  AccountDeletionReason.POOR_EXPERIENCE: 'POOR_EXPERIENCE',
  AccountDeletionReason.OTHER: 'OTHER',
};
