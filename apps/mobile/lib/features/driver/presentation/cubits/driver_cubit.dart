import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverCubit extends BaseCubit<DriverState> {
  DriverCubit({
    required DriverRepository driverRepository,
    required OrderRepository orderRepository,
    required ConfigurationRepository configurationRepository,
    required WebSocketService webSocketService,
  }) : _driverRepository = driverRepository,
       _orderRepository = orderRepository,
       _configurationRepository = configurationRepository,
       // WebSocketService parameter kept for future use but not stored
       super(DriverState());

  final DriverRepository _driverRepository;
  final OrderRepository _orderRepository;
  // ignore: unused_field
  final ConfigurationRepository _configurationRepository;

  String? _driverId;
  double? _platformFeeRate; // Cached platform fee rate

  Future<void> init() async {
    try {
      // Try to load from cache first for instant UI
      final cachedDriver = AppCaches.driver.get('my-profile');
      if (cachedDriver != null && cachedDriver is Driver) {
        emit(
          state.toSuccess(
            driver: cachedDriver,
            isOnline: cachedDriver.isTakingOrder,
          ),
        );
      }

      emit(state.toLoading());

      // Get driver profile
      final driverRes = await _driverRepository.getMine();
      _driverId = driverRes.data.id;

      // Cache driver profile for 5 minutes
      AppCaches.driver.put(
        'my-profile',
        driverRes.data,
        duration: const Duration(minutes: 5),
      );

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

  Future<void> toggleOnlineStatus() async {
    if (_driverId == null) return;

    try {
      final newStatus = !(state.isOnline ?? false);

      // Optimistic update
      emit(state.copyWith(isOnline: newStatus));

      final driverId = _driverId;
      if (driverId == null) {
        throw Exception('Driver ID not initialized');
      }

      final res = await _driverRepository.updateOnlineStatus(
        driverId: driverId,
        isOnline: newStatus,
      );

      // Update cache with new status
      AppCaches.driver.put(
        'my-profile',
        res.data,
        duration: const Duration(minutes: 5),
      );

      emit(
        state.toSuccess(
          message: newStatus ? 'You are now online' : 'You are now offline',
          driver: res.data,
          isOnline: res.data.isTakingOrder,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverCubit] - toggleOnlineStatus error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      // Revert optimistic update to previous status
      final previousStatus = state.isOnline;
      if (previousStatus != null) {
        emit(state.copyWith(isOnline: !previousStatus));
      }
      emit(state.toFailure(e));
    }
  }

  Future<void> refreshProfile() async {
    try {
      final res = await _driverRepository.getMine();
      _driverId = res.data.id;

      // Update cache
      AppCaches.driver.put(
        'my-profile',
        res.data,
        duration: const Duration(minutes: 5),
      );

      emit(state.toSuccess(driver: res.data, isOnline: res.data.isTakingOrder));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverCubit] - refreshProfile error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> refreshStats() async {
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
  }

  /// Calculate total driver earnings from orders after platform commission
  /// Fetches commission rate from configuration (with fallback to 15%)
  Future<num> _calculateDriverEarnings(List<Order> orders) async {
    if (orders.isEmpty) return 0;

    // TODO: Implement platform fee rate fetching when ConfigurationRepository method is available
    // For now, use a default driver share of 85% (15% platform fee)
    _platformFeeRate ??= 0.15;

    final platformFeeRate = _platformFeeRate ?? 0.15;
    final driverShare = 1.0 - platformFeeRate;

    return orders.fold<num>(
      0,
      (sum, order) => sum + (order.totalPrice * driverShare),
    );
  }

  void reset() => emit(DriverState());
}
