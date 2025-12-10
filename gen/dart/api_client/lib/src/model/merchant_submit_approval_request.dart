//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_submit_approval_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantSubmitApprovalRequest {
  /// Returns a new [MerchantSubmitApprovalRequest] instance.
  const MerchantSubmitApprovalRequest({
     this.reviewNotes,
  });
  @JsonKey(name: r'reviewNotes', required: false, includeIfNull: false)
  final String? reviewNotes;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantSubmitApprovalRequest &&
    other.reviewNotes == reviewNotes;

  @override
  int get hashCode =>
      reviewNotes.hashCode;

  factory MerchantSubmitApprovalRequest.fromJson(Map<String, dynamic> json) => _$MerchantSubmitApprovalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantSubmitApprovalRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

