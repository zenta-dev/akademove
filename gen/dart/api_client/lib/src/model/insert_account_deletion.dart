//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_deletion_reason.dart';
import 'package:api_client/src/model/account_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_account_deletion.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertAccountDeletion {
  /// Returns a new [InsertAccountDeletion] instance.
  const InsertAccountDeletion({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.reason,
    this.additionalInfo,
    this.userId,
  });
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

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertAccountDeletion &&
          other.fullName == fullName &&
          other.email == email &&
          other.phone == phone &&
          other.accountType == accountType &&
          other.reason == reason &&
          other.additionalInfo == additionalInfo &&
          other.userId == userId;

  @override
  int get hashCode =>
      fullName.hashCode +
      email.hashCode +
      phone.hashCode +
      accountType.hashCode +
      reason.hashCode +
      additionalInfo.hashCode +
      userId.hashCode;

  factory InsertAccountDeletion.fromJson(Map<String, dynamic> json) =>
      _$InsertAccountDeletionFromJson(json);

  Map<String, dynamic> toJson() => _$InsertAccountDeletionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
