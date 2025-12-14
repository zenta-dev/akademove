part of '_export.dart';

class UserCouponState extends Equatable {
  const UserCouponState({
    this.eligibleCoupons = const OperationResult.idle(),
    this.availableCoupons = const OperationResult.idle(),
  });

  final OperationResult<EligibleCouponsResult> eligibleCoupons;
  final OperationResult<List<Coupon>> availableCoupons;

  @override
  List<Object> get props => [eligibleCoupons, availableCoupons];

  UserCouponState copyWith({
    OperationResult<EligibleCouponsResult>? eligibleCoupons,
    OperationResult<List<Coupon>>? availableCoupons,
  }) {
    return UserCouponState(
      eligibleCoupons: eligibleCoupons ?? this.eligibleCoupons,
      availableCoupons: availableCoupons ?? this.availableCoupons,
    );
  }

  @override
  bool get stringify => true;
}
