//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'account_deletion_review_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletionReviewRequest {
  /// Returns a new [AccountDeletionReviewRequest] instance.
  const AccountDeletionReviewRequest({required this.status, this.reviewNotes});
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AccountDeletionReviewRequestStatusEnum status;

  @JsonKey(name: r'reviewNotes', required: false, includeIfNull: false)
  final String? reviewNotes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDeletionReviewRequest &&
          other.status == status &&
          other.reviewNotes == reviewNotes;

  @override
  int get hashCode =>
      status.hashCode + (reviewNotes == null ? 0 : reviewNotes.hashCode);

  factory AccountDeletionReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountDeletionReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDeletionReviewRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum AccountDeletionReviewRequestStatusEnum {
  @JsonValue(r'REVIEWING')
  REVIEWING(r'REVIEWING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED');

  const AccountDeletionReviewRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
