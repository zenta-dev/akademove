//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/pagination_result.dart';
import 'package:api_client/src/model/coupon_get_eligible_coupons200_response_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_get_eligible_coupons200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponGetEligibleCoupons200Response {
  /// Returns a new [CouponGetEligibleCoupons200Response] instance.
  const CouponGetEligibleCoupons200Response({
    required this.message,
    required this.data,
     this.pagination,
     this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;
  
  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final CouponGetEligibleCoupons200ResponseData data;
  
  @JsonKey(name: r'pagination', required: false, includeIfNull: false)
  final PaginationResult? pagination;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is CouponGetEligibleCoupons200Response &&
    other.message == message &&
    other.data == data &&
    other.pagination == pagination &&
    other.totalPages == totalPages;

  @override
  int get hashCode =>
      message.hashCode +
      data.hashCode +
      pagination.hashCode +
      totalPages.hashCode;

  factory CouponGetEligibleCoupons200Response.fromJson(Map<String, dynamic> json) => _$CouponGetEligibleCoupons200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponGetEligibleCoupons200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

