// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_submit_approval_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantSubmitApprovalRequestCWProxy {
  MerchantSubmitApprovalRequest reviewNotes(String? reviewNotes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSubmitApprovalRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSubmitApprovalRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSubmitApprovalRequest call({String? reviewNotes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantSubmitApprovalRequest.copyWith(...)` or call `instanceOfMerchantSubmitApprovalRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantSubmitApprovalRequestCWProxyImpl
    implements _$MerchantSubmitApprovalRequestCWProxy {
  const _$MerchantSubmitApprovalRequestCWProxyImpl(this._value);

  final MerchantSubmitApprovalRequest _value;

  @override
  MerchantSubmitApprovalRequest reviewNotes(String? reviewNotes) =>
      call(reviewNotes: reviewNotes);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSubmitApprovalRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSubmitApprovalRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSubmitApprovalRequest call({
    Object? reviewNotes = const $CopyWithPlaceholder(),
  }) {
    return MerchantSubmitApprovalRequest(
      reviewNotes: reviewNotes == const $CopyWithPlaceholder()
          ? _value.reviewNotes
          // ignore: cast_nullable_to_non_nullable
          : reviewNotes as String?,
    );
  }
}

extension $MerchantSubmitApprovalRequestCopyWith
    on MerchantSubmitApprovalRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantSubmitApprovalRequest.copyWith(...)` or `instanceOfMerchantSubmitApprovalRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantSubmitApprovalRequestCWProxy get copyWith =>
      _$MerchantSubmitApprovalRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSubmitApprovalRequest _$MerchantSubmitApprovalRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantSubmitApprovalRequest', json, ($checkedConvert) {
  final val = MerchantSubmitApprovalRequest(
    reviewNotes: $checkedConvert('reviewNotes', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$MerchantSubmitApprovalRequestToJson(
  MerchantSubmitApprovalRequest instance,
) => <String, dynamic>{'reviewNotes': ?instance.reviewNotes};
