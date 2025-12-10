import 'package:akademove/core/_export.dart';
import 'package:akademove/features/coupon/data/repositories/coupon_repository.dart';
import 'package:akademove/features/coupon/presentation/states/coupon_state.dart';
import 'package:api_client/api_client.dart';

class CouponCubit extends BaseCubit<CouponState> {
  CouponCubit({required CouponRepository couponRepository})
    : _couponRepository = couponRepository,
      super(const CouponState());

  final CouponRepository _couponRepository;

  /// Load eligible coupons for an order and auto-select the best one
  Future<void> loadEligibleCoupons({
    required OrderType serviceType,
    required num totalAmount,
    String? merchantId,
  }) async => await taskManager.execute('CC-lEC1', () async {
    try {
      emit(state.copyWith(eligibleCoupons: const OperationResult.loading()));
      final res = await _couponRepository.getEligibleCoupons(
        serviceType: serviceType,
        totalAmount: totalAmount,
        merchantId: merchantId,
      );
      emit(
        state.copyWith(
          eligibleCoupons: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[CouponCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(eligibleCoupons: OperationResult.failed(e)));
    }
  });

  /// Manually select a specific coupon from the eligible list
  void selectCoupon(Coupon? coupon) {
    final currentData = state.eligibleCoupons.value;
    if (currentData == null) return;

    // Recalculate discount for the selected coupon
    final selectedDiscountAmount = _calculateDiscount(
      coupon: coupon,
      totalAmount: currentData.bestDiscountAmount,
    );

    emit(
      state.copyWith(
        eligibleCoupons: OperationResult.success(
          EligibleCouponsResult(
            coupons: currentData.coupons,
            bestCoupon: coupon,
            bestDiscountAmount: selectedDiscountAmount,
          ),
        ),
      ),
    );
  }

  /// Clear selected coupon
  void clearCoupon() {
    final currentData = state.eligibleCoupons.value;
    if (currentData == null) return;

    emit(
      state.copyWith(
        eligibleCoupons: OperationResult.success(
          EligibleCouponsResult(
            coupons: currentData.coupons,
            bestCoupon: null,
            bestDiscountAmount: 0,
          ),
        ),
      ),
    );
  }

  /// Validate a specific coupon code (for manual entry)
  Future<BaseResponse<CouponValidationResult>> validateCoupon({
    required String code,
    required num orderAmount,
    OrderType? serviceType,
    String? merchantId,
  }) async {
    try {
      return await _couponRepository.validateCoupon(
        code: code,
        orderAmount: orderAmount,
        serviceType: serviceType,
        merchantId: merchantId,
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CouponCubit] - Validation error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// Helper to calculate discount amount for a coupon
  num _calculateDiscount({Coupon? coupon, required num totalAmount}) {
    if (coupon == null) return 0;

    final discountPercentage = coupon.discountPercentage;
    final discountAmount = coupon.discountAmount;
    final maxDiscountAmount = coupon.rules.general?.maxDiscountAmount;

    num discount = 0;

    if (discountPercentage != null) {
      discount = (totalAmount * discountPercentage) / 100;
      if (maxDiscountAmount != null && discount > maxDiscountAmount) {
        discount = maxDiscountAmount;
      }
    } else if (discountAmount != null) {
      discount = discountAmount;
    }

    return discount;
  }
}
