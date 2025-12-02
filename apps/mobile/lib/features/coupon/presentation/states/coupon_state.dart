import 'package:akademove/core/_export.dart';
import 'package:akademove/features/coupon/data/repositories/coupon_repository.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'coupon_state.mapper.dart';

@MappableClass()
class CouponState extends BaseState<EligibleCouponsResult?>
    with CouponStateMappable {
  const CouponState({super.data, super.error, super.state, super.message});

  factory CouponState.initial() => const CouponState();
  factory CouponState.loading() => const CouponState(state: CubitState.loading);
  factory CouponState.success(EligibleCouponsResult data, {String? message}) =>
      CouponState(data: data, state: CubitState.success, message: message);
  factory CouponState.failure(BaseError error) =>
      CouponState(error: error, state: CubitState.failure);
}
