//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_update_document_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantUpdateDocumentStatusRequest {
  /// Returns a new [MerchantUpdateDocumentStatusRequest] instance.
  const MerchantUpdateDocumentStatusRequest({
    required this.document,
    required this.status,
    this.reason,
  });
  @JsonKey(name: r'document', required: true, includeIfNull: false)
  final MerchantUpdateDocumentStatusRequestDocumentEnum document;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final MerchantUpdateDocumentStatusRequestStatusEnum status;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantUpdateDocumentStatusRequest &&
          other.document == document &&
          other.status == status &&
          other.reason == reason;

  @override
  int get hashCode => document.hashCode + status.hashCode + reason.hashCode;

  factory MerchantUpdateDocumentStatusRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantUpdateDocumentStatusRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantUpdateDocumentStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum MerchantUpdateDocumentStatusRequestDocumentEnum {
  @JsonValue(r'businessDocument')
  businessDocument(r'businessDocument');

  const MerchantUpdateDocumentStatusRequestDocumentEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum MerchantUpdateDocumentStatusRequestStatusEnum {
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const MerchantUpdateDocumentStatusRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
