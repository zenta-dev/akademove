import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserCouponCubit extends BaseCubit<UserCouponState> {
  UserCouponCubit({required CouponRepository couponRepository})
    : _couponRepository = couponRepository,
      super(const UserCouponState());

  final CouponRepository _couponRepository;

  /// Load all eligible coupons for an order and auto-select the best one
  /// Returns ALL eligible coupons without any limit
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
  /// Calls server to validate and get accurate discount amount
  Future<void> selectCoupon(Coupon? coupon) async {
    final currentData = state.eligibleCoupons.value;
    if (currentData == null) return;

    // If clearing coupon, just reset discount
    if (coupon == null) {
      emit(
        state.copyWith(
          eligibleCoupons: OperationResult.success(
            currentData.copyWith(bestCoupon: null, bestDiscountAmount: 0),
          ),
        ),
      );
      return;
    }

    // Call server to validate and get accurate discount
    try {
      final res = await _couponRepository.validateCoupon(
        code: coupon.code,
        orderAmount: currentData.orderAmount,
      );

      final validationResult = res.data;

      if (validationResult.valid) {
        emit(
          state.copyWith(
            eligibleCoupons: OperationResult.success(
              currentData.copyWith(
                bestCoupon: coupon,
                bestDiscountAmount: validationResult.discountAmount,
              ),
            ),
          ),
        );
      } else {
        // Coupon not valid - log and keep current state
        logger.w(
          '[CouponCubit] - Coupon validation failed: ${validationResult.reason}',
        );
      }
    } on BaseError catch (e, st) {
      logger.e(
        '[CouponCubit] - Failed to validate coupon: ${e.message}',
        error: e,
        stackTrace: st,
      );
      // On error, fallback to local calculation
      final fallbackDiscount = _calculateDiscount(
        coupon: coupon,
        totalAmount: currentData.orderAmount,
      );
      emit(
        state.copyWith(
          eligibleCoupons: OperationResult.success(
            currentData.copyWith(
              bestCoupon: coupon,
              bestDiscountAmount: fallbackDiscount,
            ),
          ),
        ),
      );
    }
  }

  /// Clear selected coupon
  void clearCoupon() {
    final currentData = state.eligibleCoupons.value;
    if (currentData == null) return;

    emit(
      state.copyWith(
        eligibleCoupons: OperationResult.success(
          currentData.copyWith(bestCoupon: null, bestDiscountAmount: 0),
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
