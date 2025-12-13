part of '_export.dart';

class UserCouponState extends Equatable {
  const UserCouponState({this.eligibleCoupons = const OperationResult.idle()});

  final OperationResult<EligibleCouponsResult> eligibleCoupons;

  @override
  List<Object> get props => [eligibleCoupons];

  UserCouponState copyWith({
    OperationResult<EligibleCouponsResult>? eligibleCoupons,
  }) {
    return UserCouponState(
      eligibleCoupons: eligibleCoupons ?? this.eligibleCoupons,
    );
  }

  @override
  bool get stringify => true;
}
