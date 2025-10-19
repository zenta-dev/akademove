//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_create_request_rules.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_update_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponUpdateRequest {
  /// Returns a new [CouponUpdateRequest] instance.
  CouponUpdateRequest({

     this.name,

     this.code,

     this.rules,

     this.discountAmount,

     this.discountPercentage,

     this.usageLimit,

     this.periodStart,

     this.periodEnd,

     this.isActive,
  });

  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'code',
    required: false,
    includeIfNull: false,
  )


  final String? code;



  @JsonKey(
    
    name: r'rules',
    required: false,
    includeIfNull: false,
  )


  final CouponCreateRequestRules? rules;



  @JsonKey(
    
    name: r'discountAmount',
    required: false,
    includeIfNull: false,
  )


  final num? discountAmount;



  @JsonKey(
    
    name: r'discountPercentage',
    required: false,
    includeIfNull: false,
  )


  final num? discountPercentage;



  @JsonKey(
    
    name: r'usageLimit',
    required: false,
    includeIfNull: false,
  )


  final num? usageLimit;



  @JsonKey(
    
    name: r'periodStart',
    required: false,
    includeIfNull: false,
  )


  final DateTime? periodStart;



  @JsonKey(
    
    name: r'periodEnd',
    required: false,
    includeIfNull: false,
  )


  final DateTime? periodEnd;



  @JsonKey(
    
    name: r'isActive',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CouponUpdateRequest &&
      other.name == name &&
      other.code == code &&
      other.rules == rules &&
      other.discountAmount == discountAmount &&
      other.discountPercentage == discountPercentage &&
      other.usageLimit == usageLimit &&
      other.periodStart == periodStart &&
      other.periodEnd == periodEnd &&
      other.isActive == isActive;

    @override
    int get hashCode =>
        name.hashCode +
        code.hashCode +
        rules.hashCode +
        discountAmount.hashCode +
        discountPercentage.hashCode +
        usageLimit.hashCode +
        periodStart.hashCode +
        periodEnd.hashCode +
        isActive.hashCode;

  factory CouponUpdateRequest.fromJson(Map<String, dynamic> json) => _$CouponUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CouponUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

