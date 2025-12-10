import 'package:akademove/core/_export.dart';
import 'package:akademove/features/coupon/data/repositories/coupon_repository.dart';
import 'package:equatable/equatable.dart';

class CouponState extends Equatable {
  const CouponState({this.eligibleCoupons = const OperationResult.idle()});

  final OperationResult<EligibleCouponsResult> eligibleCoupons;

  @override
  List<Object> get props => [eligibleCoupons];

  CouponState copyWith({
    OperationResult<EligibleCouponsResult>? eligibleCoupons,
  }) {
    return CouponState(
      eligibleCoupons: eligibleCoupons ?? this.eligibleCoupons,
    );
  }

  @override
  bool get stringify => true;
}
