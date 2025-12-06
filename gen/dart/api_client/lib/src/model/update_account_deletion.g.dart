// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_deletion.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateAccountDeletionCWProxy {
  UpdateAccountDeletion fullName(String? fullName);

  UpdateAccountDeletion email(String? email);

  UpdateAccountDeletion phone(String? phone);

  UpdateAccountDeletion accountType(AccountType? accountType);

  UpdateAccountDeletion reason(AccountDeletionReason? reason);

  UpdateAccountDeletion additionalInfo(String? additionalInfo);

  UpdateAccountDeletion status(AccountDeletionStatus? status);

  UpdateAccountDeletion userId(String? userId);

  UpdateAccountDeletion reviewedById(String? reviewedById);

  UpdateAccountDeletion reviewNotes(String? reviewNotes);

  UpdateAccountDeletion reviewedAt(DateTime? reviewedAt);

  UpdateAccountDeletion completedAt(DateTime? completedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateAccountDeletion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateAccountDeletion(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateAccountDeletion call({
    String? fullName,
    String? email,
    String? phone,
    AccountType? accountType,
    AccountDeletionReason? reason,
    String? additionalInfo,
    AccountDeletionStatus? status,
    String? userId,
    String? reviewedById,
    String? reviewNotes,
    DateTime? reviewedAt,
    DateTime? completedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateAccountDeletion.copyWith(...)` or call `instanceOfUpdateAccountDeletion.copyWith.fieldName(value)` for a single field.
class _$UpdateAccountDeletionCWProxyImpl
    implements _$UpdateAccountDeletionCWProxy {
  const _$UpdateAccountDeletionCWProxyImpl(this._value);

  final UpdateAccountDeletion _value;

  @override
  UpdateAccountDeletion fullName(String? fullName) => call(fullName: fullName);

  @override
  UpdateAccountDeletion email(String? email) => call(email: email);

  @override
  UpdateAccountDeletion phone(String? phone) => call(phone: phone);

  @override
  UpdateAccountDeletion accountType(AccountType? accountType) =>
      call(accountType: accountType);

  @override
  UpdateAccountDeletion reason(AccountDeletionReason? reason) =>
      call(reason: reason);

  @override
  UpdateAccountDeletion additionalInfo(String? additionalInfo) =>
      call(additionalInfo: additionalInfo);

  @override
  UpdateAccountDeletion status(AccountDeletionStatus? status) =>
      call(status: status);

  @override
  UpdateAccountDeletion userId(String? userId) => call(userId: userId);

  @override
  UpdateAccountDeletion reviewedById(String? reviewedById) =>
      call(reviewedById: reviewedById);

  @override
  UpdateAccountDeletion reviewNotes(String? reviewNotes) =>
      call(reviewNotes: reviewNotes);

  @override
  UpdateAccountDeletion reviewedAt(DateTime? reviewedAt) =>
      call(reviewedAt: reviewedAt);

  @override
  UpdateAccountDeletion completedAt(DateTime? completedAt) =>
      call(completedAt: completedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateAccountDeletion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateAccountDeletion(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateAccountDeletion call({
    Object? fullName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? accountType = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? additionalInfo = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? reviewedById = const $CopyWithPlaceholder(),
    Object? reviewNotes = const $CopyWithPlaceholder(),
    Object? reviewedAt = const $CopyWithPlaceholder(),
    Object? completedAt = const $CopyWithPlaceholder(),
  }) {
    return UpdateAccountDeletion(
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      accountType: accountType == const $CopyWithPlaceholder()
          ? _value.accountType
          // ignore: cast_nullable_to_non_nullable
          : accountType as AccountType?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as AccountDeletionReason?,
      additionalInfo: additionalInfo == const $CopyWithPlaceholder()
          ? _value.additionalInfo
          // ignore: cast_nullable_to_non_nullable
          : additionalInfo as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AccountDeletionStatus?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      reviewedById: reviewedById == const $CopyWithPlaceholder()
          ? _value.reviewedById
          // ignore: cast_nullable_to_non_nullable
          : reviewedById as String?,
      reviewNotes: reviewNotes == const $CopyWithPlaceholder()
          ? _value.reviewNotes
          // ignore: cast_nullable_to_non_nullable
          : reviewNotes as String?,
      reviewedAt: reviewedAt == const $CopyWithPlaceholder()
          ? _value.reviewedAt
          // ignore: cast_nullable_to_non_nullable
          : reviewedAt as DateTime?,
      completedAt: completedAt == const $CopyWithPlaceholder()
          ? _value.completedAt
          // ignore: cast_nullable_to_non_nullable
          : completedAt as DateTime?,
    );
  }
}

extension $UpdateAccountDeletionCopyWith on UpdateAccountDeletion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateAccountDeletion.copyWith(...)` or `instanceOfUpdateAccountDeletion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateAccountDeletionCWProxy get copyWith =>
      _$UpdateAccountDeletionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountDeletion _$UpdateAccountDeletionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateAccountDeletion', json, ($checkedConvert) {
  final val = UpdateAccountDeletion(
    fullName: $checkedConvert('fullName', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    phone: $checkedConvert('phone', (v) => v as String?),
    accountType: $checkedConvert(
      'accountType',
      (v) => $enumDecodeNullable(_$AccountTypeEnumMap, v),
    ),
    reason: $checkedConvert(
      'reason',
      (v) => $enumDecodeNullable(_$AccountDeletionReasonEnumMap, v),
    ),
    additionalInfo: $checkedConvert('additionalInfo', (v) => v as String?),
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$AccountDeletionStatusEnumMap, v),
    ),
    userId: $checkedConvert('userId', (v) => v as String?),
    reviewedById: $checkedConvert('reviewedById', (v) => v as String?),
    reviewNotes: $checkedConvert('reviewNotes', (v) => v as String?),
    reviewedAt: $checkedConvert(
      'reviewedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    completedAt: $checkedConvert(
      'completedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$UpdateAccountDeletionToJson(
  UpdateAccountDeletion instance,
) => <String, dynamic>{
  'fullName': ?instance.fullName,
  'email': ?instance.email,
  'phone': ?instance.phone,
  'accountType': ?_$AccountTypeEnumMap[instance.accountType],
  'reason': ?_$AccountDeletionReasonEnumMap[instance.reason],
  'additionalInfo': ?instance.additionalInfo,
  'status': ?_$AccountDeletionStatusEnumMap[instance.status],
  'userId': ?instance.userId,
  'reviewedById': ?instance.reviewedById,
  'reviewNotes': ?instance.reviewNotes,
  'reviewedAt': ?instance.reviewedAt?.toIso8601String(),
  'completedAt': ?instance.completedAt?.toIso8601String(),
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

const _$AccountDeletionStatusEnumMap = {
  AccountDeletionStatus.PENDING: 'PENDING',
  AccountDeletionStatus.REVIEWING: 'REVIEWING',
  AccountDeletionStatus.APPROVED: 'APPROVED',
  AccountDeletionStatus.REJECTED: 'REJECTED',
  AccountDeletionStatus.COMPLETED: 'COMPLETED',
};
