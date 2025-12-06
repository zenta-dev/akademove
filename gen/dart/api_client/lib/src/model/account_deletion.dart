//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_deletion_reason.dart';
import 'package:api_client/src/model/account_deletion_status.dart';
import 'package:api_client/src/model/account_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'account_deletion.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletion {
  /// Returns a new [AccountDeletion] instance.
  const AccountDeletion({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.reason,
    this.additionalInfo,
    required this.status,
    this.userId,
    this.reviewedById,
    this.reviewNotes,
    required this.createdAt,
    required this.updatedAt,
    this.reviewedAt,
    this.completedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'accountType', required: true, includeIfNull: false)
  final AccountType accountType;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final AccountDeletionReason reason;

  @JsonKey(name: r'additionalInfo', required: false, includeIfNull: false)
  final String? additionalInfo;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AccountDeletionStatus status;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'reviewedById', required: false, includeIfNull: false)
  final String? reviewedById;

  @JsonKey(name: r'reviewNotes', required: false, includeIfNull: false)
  final String? reviewNotes;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @JsonKey(name: r'reviewedAt', required: false, includeIfNull: false)
  final DateTime? reviewedAt;

  @JsonKey(name: r'completedAt', required: false, includeIfNull: false)
  final DateTime? completedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDeletion &&
          other.id == id &&
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
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.reviewedAt == reviewedAt &&
          other.completedAt == completedAt;

  @override
  int get hashCode =>
      id.hashCode +
      fullName.hashCode +
      email.hashCode +
      phone.hashCode +
      accountType.hashCode +
      reason.hashCode +
      additionalInfo.hashCode +
      status.hashCode +
      userId.hashCode +
      reviewedById.hashCode +
      reviewNotes.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode +
      reviewedAt.hashCode +
      completedAt.hashCode;

  factory AccountDeletion.fromJson(Map<String, dynamic> json) =>
      _$AccountDeletionFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDeletionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
