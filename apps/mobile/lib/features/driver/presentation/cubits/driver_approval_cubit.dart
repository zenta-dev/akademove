import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class DriverApprovalCubit extends BaseCubit<DriverApprovalState> {
  DriverApprovalCubit({required this.driverRepository})
    : super(const DriverApprovalState());

  final DriverRepository driverRepository;

  void reset() => emit(const DriverApprovalState());

  /// Load driver profile and approval review status
  Future<void> load() async => await taskManager.execute('DAC-L1', () async {
    try {
      emit(
        state.copyWith(
          driver: const OperationResult.loading(),
          approvalReview: const OperationResult.loading(),
        ),
      );

      // Fetch driver profile
      final driverRes = await driverRepository.getMine();
      final driver = driverRes.data;

      emit(
        state.copyWith(
          driver: OperationResult.success(driver, message: driverRes.message),
        ),
      );

      // Fetch approval review
      final reviewRes = await driverRepository.getApprovalReview(driver.id);

      emit(
        state.copyWith(
          approvalReview: OperationResult.success(
            reviewRes.data,
            message: reviewRes.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('Failed to load approval status', error: e, stackTrace: st);
      emit(
        state.copyWith(
          driver: OperationResult.failed(e),
          approvalReview: OperationResult.failed(e),
        ),
      );
    }
  });

  /// Refresh driver profile only
  Future<void> refreshDriver() async =>
      await taskManager.execute('DAC-RD1', () async {
        try {
          emit(state.copyWith(driver: const OperationResult.loading()));

          final res = await driverRepository.getMine();

          emit(
            state.copyWith(
              driver: OperationResult.success(res.data, message: res.message),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to refresh driver', error: e, stackTrace: st);
          emit(state.copyWith(driver: OperationResult.failed(e)));
        }
      });

  /// Refresh approval review only
  Future<void> refreshApprovalReview() async => await taskManager.execute(
    'DAC-RAR1',
    () async {
      try {
        final driverId = state.driver.data?.value.id;
        if (driverId == null) {
          emit(
            state.copyWith(
              approvalReview: OperationResult.failed(
                ServiceError('Driver ID not available'),
              ),
            ),
          );
          return;
        }

        emit(state.copyWith(approvalReview: const OperationResult.loading()));

        final res = await driverRepository.getApprovalReview(driverId);

        emit(
          state.copyWith(
            approvalReview: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e('Failed to refresh approval review', error: e, stackTrace: st);
        emit(state.copyWith(approvalReview: OperationResult.failed(e)));
      }
    },
  );
}
