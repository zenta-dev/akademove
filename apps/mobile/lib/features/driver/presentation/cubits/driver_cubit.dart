import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverCubit extends BaseCubit<DriverState> {
  DriverCubit({
    required DriverRepository driverRepository,
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
    required ConfigurationRepository configurationRepository,
  }) : _driverRepository = driverRepository,
       _orderRepository = orderRepository,
       _configurationRepository = configurationRepository,
       super(DriverState());

  final DriverRepository _driverRepository;
  final OrderRepository _orderRepository;
  final ConfigurationRepository _configurationRepository;

  String? _driverId;
  double? _platformFeeRate;

  Future<void> init() async {
    try {
      emit(state.toLoading());

      // Get driver profile
      final driverRes = await _driverRepository.getMine();
      _driverId = driverRes.data.id;

      // Get today's stats
      final orders = await _orderRepository.list(
        const ListOrderQuery(statuses: [OrderStatus.COMPLETED]),
      );

      // Calculate today's earnings and trips
      final now = DateTime.now();
      final todayOrders = orders.data.where((order) {
        final orderDate = order.updatedAt;
        return order.status == OrderStatus.COMPLETED &&
            orderDate.year == now.year &&
            orderDate.month == now.month &&
            orderDate.day == now.day;
      }).toList();

      // Calculate driver earnings (totalPrice - platform commission)
      final todayEarnings = await _calculateDriverEarnings(todayOrders);

      emit(
        state.toSuccess(
          message: driverRes.message,
          driver: driverRes.data,
          isOnline: driverRes.data.isTakingOrder,
          todayEarnings: todayEarnings,
          todayTrips: todayOrders.length,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverCubit] - init error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> toggleOnlineStatus() async =>
      await taskManager.execute('DC-tOS1', () async {
        if (_driverId == null) return;

        try {
          final newStatus = !(state.driver?.isOnline ?? false);

          // Optimistic update
          emit(
            state.copyWith(driver: state.driver?.copyWith(isOnline: newStatus)),
          );

          final driverId = _driverId;
          if (driverId == null) {
            throw Exception('Driver ID not initialized');
          }

          final res = await _driverRepository.updateOnlineStatus(
            driverId: driverId,
            isOnline: newStatus,
          );

          emit(
            state.toSuccess(
              message: newStatus ? 'You are now online' : 'You are now offline',
              driver: res.data,
              isOnline: res.data.isOnline,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverCubit] - toggleOnlineStatus error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Revert optimistic update to previous status
          final previousStatus = state.driver?.isOnline;
          if (previousStatus != null) {
            emit(
              state.copyWith(
                driver: state.driver?.copyWith(isOnline: !previousStatus),
              ),
            );
          }
          emit(state.toFailure(e));
        }
      });

  Future<void> refreshProfile() async =>
      await taskManager.execute('DC-rP1', () async {
        try {
          final res = await _driverRepository.getMine();
          _driverId = res.data.id;

          emit(
            state.toSuccess(driver: res.data, isOnline: res.data.isTakingOrder),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverCubit] - refreshProfile error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> refreshStats() async =>
      await taskManager.execute('DC-rS1', () async {
        try {
          final orders = await _orderRepository.list(
            const ListOrderQuery(statuses: [OrderStatus.COMPLETED]),
          );

          final now = DateTime.now();
          final todayOrders = orders.data.where((order) {
            final orderDate = order.updatedAt;
            return order.status == OrderStatus.COMPLETED &&
                orderDate.year == now.year &&
                orderDate.month == now.month &&
                orderDate.day == now.day;
          }).toList();

          // Calculate driver earnings (totalPrice - platform commission)
          final todayEarnings = await _calculateDriverEarnings(todayOrders);

          emit(
            state.toSuccess(
              todayEarnings: todayEarnings,
              todayTrips: todayOrders.length,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverCubit] - refreshStats error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Don't emit error for stats refresh failure
        }
      });

  /// Calculate total driver earnings from orders after platform commission.
  /// NOTE: Platform fee rate MUST come from database configuration.
  /// Fallback values are forbidden per business requirements.
  Future<num> _calculateDriverEarnings(List<Order> orders) async {
    if (orders.isEmpty) return 0;

    // Fetch platform fee rate from configuration if not already cached
    if (_platformFeeRate == null) {
      try {
        // Fetch ride pricing configuration (contains platformFeeRate)
        final configRes = await _configurationRepository.get(
          'ride-service-pricing',
        );
        final pricingConfig = configRes.data.value;

        // Parse the pricing configuration JSON
        if (pricingConfig is Map<String, Object?>) {
          final platformFeeRate = pricingConfig['platformFeeRate'];
          if (platformFeeRate is num) {
            _platformFeeRate = platformFeeRate.toDouble();
          } else {
            logger.e(
              '[DriverCubit] platformFeeRate not found in configuration',
            );
            // Return 0 earnings to indicate error rather than showing wrong data
            return 0;
          }
        }
      } catch (e) {
        logger.e(
          '[DriverCubit] Failed to fetch platform fee rate from database',
          error: e,
        );
        // Return 0 earnings to indicate error rather than showing wrong data
        return 0;
      }
    }

    // platformFeeRate should now be available from database
    if (_platformFeeRate == null) {
      logger.e('[DriverCubit] Platform fee rate not available');
      return 0;
    }

    final driverShare = 1.0 - _platformFeeRate!;

    return orders.fold<num>(
      0,
      (sum, order) => sum + (order.totalPrice * driverShare),
    );
  }

  void reset() => emit(DriverState());
}
