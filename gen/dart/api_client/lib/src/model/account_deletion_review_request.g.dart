// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_review_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionReviewRequestCWProxy {
  AccountDeletionReviewRequest status(
    AccountDeletionReviewRequestStatusEnum status,
  );

  AccountDeletionReviewRequest reviewNotes(String? reviewNotes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionReviewRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionReviewRequest call({
    AccountDeletionReviewRequestStatusEnum status,
    String? reviewNotes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAccountDeletionReviewRequest.copyWith(...)` or call `instanceOfAccountDeletionReviewRequest.copyWith.fieldName(value)` for a single field.
class _$AccountDeletionReviewRequestCWProxyImpl
    implements _$AccountDeletionReviewRequestCWProxy {
  const _$AccountDeletionReviewRequestCWProxyImpl(this._value);

  final AccountDeletionReviewRequest _value;

  @override
  AccountDeletionReviewRequest status(
    AccountDeletionReviewRequestStatusEnum status,
  ) => call(status: status);

  @override
  AccountDeletionReviewRequest reviewNotes(String? reviewNotes) =>
      call(reviewNotes: reviewNotes);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AccountDeletionReviewRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AccountDeletionReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AccountDeletionReviewRequest call({
    Object? status = const $CopyWithPlaceholder(),
    Object? reviewNotes = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionReviewRequest(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AccountDeletionReviewRequestStatusEnum,
      reviewNotes: reviewNotes == const $CopyWithPlaceholder()
          ? _value.reviewNotes
          // ignore: cast_nullable_to_non_nullable
          : reviewNotes as String?,
    );
  }
}

extension $AccountDeletionReviewRequestCopyWith
    on AccountDeletionReviewRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAccountDeletionReviewRequest.copyWith(...)` or `instanceOfAccountDeletionReviewRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionReviewRequestCWProxy get copyWith =>
      _$AccountDeletionReviewRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionReviewRequest _$AccountDeletionReviewRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccountDeletionReviewRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['status']);
  final val = AccountDeletionReviewRequest(
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$AccountDeletionReviewRequestStatusEnumEnumMap, v),
    ),
    reviewNotes: $checkedConvert('reviewNotes', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AccountDeletionReviewRequestToJson(
  AccountDeletionReviewRequest instance,
) => <String, dynamic>{
  'status': _$AccountDeletionReviewRequestStatusEnumEnumMap[instance.status]!,
  'reviewNotes': ?instance.reviewNotes,
};

const _$AccountDeletionReviewRequestStatusEnumEnumMap = {
  AccountDeletionReviewRequestStatusEnum.REVIEWING: 'REVIEWING',
  AccountDeletionReviewRequestStatusEnum.APPROVED: 'APPROVED',
  AccountDeletionReviewRequestStatusEnum.REJECTED: 'REJECTED',
  AccountDeletionReviewRequestStatusEnum.COMPLETED: 'COMPLETED',
};
