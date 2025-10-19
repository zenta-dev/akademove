//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_create_request_rules_user.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponCreateRequestRulesUser {
  /// Returns a new [CouponCreateRequestRulesUser] instance.
  CouponCreateRequestRulesUser({

     this.newUserOnly,
  });

  @JsonKey(
    
    name: r'newUserOnly',
    required: false,
    includeIfNull: false,
  )


  final bool? newUserOnly;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CouponCreateRequestRulesUser &&
      other.newUserOnly == newUserOnly;

    @override
    int get hashCode =>
        newUserOnly.hashCode;

  factory CouponCreateRequestRulesUser.fromJson(Map<String, dynamic> json) => _$CouponCreateRequestRulesUserFromJson(json);

  Map<String, dynamic> toJson() => _$CouponCreateRequestRulesUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

