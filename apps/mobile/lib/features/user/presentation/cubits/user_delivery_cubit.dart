import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserDeliveryCubit extends BaseCubit<UserDeliveryState> {
  UserDeliveryCubit({
    required DriverRepository driverRepository,
    required MapService mapService,
  }) : _driverRepository = driverRepository,
       _mapService = mapService,
       super(const UserDeliveryState());

  final DriverRepository _driverRepository;
  final MapService _mapService;

  String? _selectedCouponCode;

  String? get selectedCouponCode => _selectedCouponCode;

  void reset() {
    _selectedCouponCode = null;
    emit(const UserDeliveryState());
  }

  void clearSearchPlaces() => emit(
    state.copyWith(
      searchPlaces: OperationResult.success(
        const PageTokenPaginationResult(data: []),
      ),
    ),
  );

  void setSelectedCoupon(String? couponCode) {
    _selectedCouponCode = couponCode;
  }

  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async => await taskManager.execute('UDC-gNP-${coord.hashCode}', () async {
    try {
      if (isRefresh && state.nearbyPlaces.value?.token == null) {
        emit(state.copyWith(nearbyPlaces: const OperationResult.loading()));
      }

      final res = await _mapService.nearbyLocation(
        coord,
        nextPageToken: isRefresh ? null : state.nearbyPlaces.value?.token,
      );

      final mergedList = isRefresh
          ? res.data
          : [...state.nearbyPlaces.value?.data ?? <Place>[], ...res.data];

      emit(
        state.copyWith(
          nearbyPlaces: OperationResult.success(
            PageTokenPaginationResult(data: mergedList, token: res.token),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(nearbyPlaces: OperationResult.failed(e)));
    }
  });

  String? _searchQuery;
  Future<void> searchPlaces(
    String query, {
    Coordinate? coordinate,
    bool isRefresh = false,
  }) async => await taskManager.execute('UDC-sP-$query', () async {
    try {
      if (isRefresh && state.searchPlaces.value?.token == null) {
        emit(state.copyWith(searchPlaces: const OperationResult.loading()));
      }

      if (isRefresh) _searchQuery = query;

      final res = await _mapService.searchPlace(
        query,
        coordinate: coordinate,
        nextPageToken: isRefresh ? null : state.searchPlaces.value?.token,
      );

      final List<Place> mergedList = (_searchQuery == query && !isRefresh)
          ? [...state.searchPlaces.value?.data ?? [], ...res.data]
          : res.data;

      emit(
        state.copyWith(
          searchPlaces: OperationResult.success(
            PageTokenPaginationResult<List<Place>>(
              data: mergedList,
              token: res.token,
            ),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(searchPlaces: OperationResult.failed(e)));
    }
  });

  Future<void> getNearbyDrivers(GetDriverNearbyQuery req) async =>
      await taskManager.execute('UDC-gND-${req.hashCode}', () async {
        try {
          emit(state.copyWith(nearbyDrivers: const OperationResult.loading()));

          final res = await _driverRepository.getDriverNearby(req);

          final mergedList = {
            for (final item in state.nearbyDrivers.value ?? <Driver>[])
              item.id: item,
            for (final item in res.data) item.id: item,
          }.values.toList();

          emit(
            state.copyWith(
              nearbyDrivers: OperationResult.success(
                mergedList,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserDeliveryCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(nearbyDrivers: OperationResult.failed(e)));
        }
      });

  Future<List<Coordinate>> getRoutes(
    Coordinate origin,
    Coordinate destination,
  ) async {
    try {
      return await _mapService.getRoutes(origin, destination);
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - getRoutes error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }
}
