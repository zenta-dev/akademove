//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_get_review200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantGetReview200ResponseData {
  /// Returns a new [MerchantGetReview200ResponseData] instance.
  const MerchantGetReview200ResponseData({
    required this.id,
    required this.merchantId,
    required this.status,
    required this.businessDocumentStatus,
    required this.businessDocumentReason,
    required this.reviewedBy,
    required this.reviewedAt,
    required this.reviewNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final MerchantGetReview200ResponseDataStatusEnum status;

  @JsonKey(
    name: r'businessDocumentStatus',
    required: true,
    includeIfNull: false,
  )
  final MerchantGetReview200ResponseDataBusinessDocumentStatusEnum
  businessDocumentStatus;

  @JsonKey(name: r'businessDocumentReason', required: true, includeIfNull: true)
  final String? businessDocumentReason;

  @JsonKey(name: r'reviewedBy', required: true, includeIfNull: true)
  final String? reviewedBy;

  @JsonKey(name: r'reviewedAt', required: true, includeIfNull: true)
  final DateTime? reviewedAt;

  @JsonKey(name: r'reviewNotes', required: true, includeIfNull: true)
  final String? reviewNotes;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantGetReview200ResponseData &&
          other.id == id &&
          other.merchantId == merchantId &&
          other.status == status &&
          other.businessDocumentStatus == businessDocumentStatus &&
          other.businessDocumentReason == businessDocumentReason &&
          other.reviewedBy == reviewedBy &&
          other.reviewedAt == reviewedAt &&
          other.reviewNotes == reviewNotes &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      merchantId.hashCode +
      status.hashCode +
      businessDocumentStatus.hashCode +
      (businessDocumentReason == null ? 0 : businessDocumentReason.hashCode) +
      (reviewedBy == null ? 0 : reviewedBy.hashCode) +
      (reviewedAt == null ? 0 : reviewedAt.hashCode) +
      (reviewNotes == null ? 0 : reviewNotes.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory MerchantGetReview200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantGetReview200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantGetReview200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum MerchantGetReview200ResponseDataStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const MerchantGetReview200ResponseDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum MerchantGetReview200ResponseDataBusinessDocumentStatusEnum {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const MerchantGetReview200ResponseDataBusinessDocumentStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
