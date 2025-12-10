//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_deletion_reason.dart';
import 'package:api_client/src/model/account_deletion_status.dart';
import 'package:api_client/src/model/account_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_account_deletion.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateAccountDeletion {
  /// Returns a new [UpdateAccountDeletion] instance.
  const UpdateAccountDeletion({
    this.fullName,
    this.email,
    this.phone,
    this.accountType,
    this.reason,
    this.additionalInfo,
    this.status,
    this.userId,
    this.reviewedById,
    this.reviewNotes,
    this.reviewedAt,
    this.completedAt,
  });
  @JsonKey(name: r'fullName', required: false, includeIfNull: false)
  final String? fullName;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  @JsonKey(name: r'accountType', required: false, includeIfNull: false)
  final AccountType? accountType;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final AccountDeletionReason? reason;

  @JsonKey(name: r'additionalInfo', required: false, includeIfNull: false)
  final String? additionalInfo;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final AccountDeletionStatus? status;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'reviewedById', required: false, includeIfNull: false)
  final String? reviewedById;

  @JsonKey(name: r'reviewNotes', required: false, includeIfNull: false)
  final String? reviewNotes;

  @JsonKey(name: r'reviewedAt', required: false, includeIfNull: false)
  final DateTime? reviewedAt;

  @JsonKey(name: r'completedAt', required: false, includeIfNull: false)
  final DateTime? completedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateAccountDeletion &&
          other.fullName == fullName &&
          other.email == email &&
          other.phone == phone &&
          other.accountType == accountType &&
          other.reason == reason &&
          other.additionalInfo == additionalInfo &&
          other.status == status &&
          other.userId == userId &&
          other.reviewedById == reviewedById &&
          other.reviewNotes == reviewNotes &&
          other.reviewedAt == reviewedAt &&
          other.completedAt == completedAt;

  @override
  int get hashCode =>
      fullName.hashCode +
      email.hashCode +
      phone.hashCode +
      accountType.hashCode +
      reason.hashCode +
      (additionalInfo == null ? 0 : additionalInfo.hashCode) +
      status.hashCode +
      userId.hashCode +
      reviewedById.hashCode +
      (reviewNotes == null ? 0 : reviewNotes.hashCode) +
      (reviewedAt == null ? 0 : reviewedAt.hashCode) +
      (completedAt == null ? 0 : completedAt.hashCode);

  factory UpdateAccountDeletion.fromJson(Map<String, dynamic> json) =>
      _$UpdateAccountDeletionFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAccountDeletionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
