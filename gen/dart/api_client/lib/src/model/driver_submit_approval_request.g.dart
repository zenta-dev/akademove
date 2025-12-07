// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_submit_approval_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverSubmitApprovalRequestCWProxy {
  DriverSubmitApprovalRequest reviewNotes(String? reviewNotes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSubmitApprovalRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSubmitApprovalRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSubmitApprovalRequest call({String? reviewNotes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverSubmitApprovalRequest.copyWith(...)` or call `instanceOfDriverSubmitApprovalRequest.copyWith.fieldName(value)` for a single field.
class _$DriverSubmitApprovalRequestCWProxyImpl
    implements _$DriverSubmitApprovalRequestCWProxy {
  const _$DriverSubmitApprovalRequestCWProxyImpl(this._value);

  final DriverSubmitApprovalRequest _value;

  @override
  DriverSubmitApprovalRequest reviewNotes(String? reviewNotes) =>
      call(reviewNotes: reviewNotes);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverSubmitApprovalRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverSubmitApprovalRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverSubmitApprovalRequest call({
    Object? reviewNotes = const $CopyWithPlaceholder(),
  }) {
    return DriverSubmitApprovalRequest(
      reviewNotes: reviewNotes == const $CopyWithPlaceholder()
          ? _value.reviewNotes
          // ignore: cast_nullable_to_non_nullable
          : reviewNotes as String?,
    );
  }
}

extension $DriverSubmitApprovalRequestCopyWith on DriverSubmitApprovalRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverSubmitApprovalRequest.copyWith(...)` or `instanceOfDriverSubmitApprovalRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverSubmitApprovalRequestCWProxy get copyWith =>
      _$DriverSubmitApprovalRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSubmitApprovalRequest _$DriverSubmitApprovalRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverSubmitApprovalRequest', json, ($checkedConvert) {
  final val = DriverSubmitApprovalRequest(
    reviewNotes: $checkedConvert('reviewNotes', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DriverSubmitApprovalRequestToJson(
  DriverSubmitApprovalRequest instance,
) => <String, dynamic>{'reviewNotes': ?instance.reviewNotes};
