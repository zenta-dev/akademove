import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserRideCubit extends BaseCubit<UserRideState> {
  UserRideCubit({
    required DriverRepository driverRepository,
    required MapService mapService,
  }) : _driverRepository = driverRepository,
       _mapService = mapService,
       super(const UserRideState());

  final DriverRepository _driverRepository;
  final MapService _mapService;

  void reset() => emit(const UserRideState());

  void clearSearchPlaces() => emit(
    state.copyWith(
      searchPlaces: OperationResult.success(
        PageTokenPaginationResult(data: []),
      ),
    ),
  );

  void setMapController(GoogleMapController controller) {
    emit(state.copyWith(mapController: controller));
  }

  Future<void> getNearbyDrivers(
    GetDriverNearbyQuery req,
  ) async => await taskManager.execute("URC-gND-${req.hashCode}", () async {
    try {
      emit(state.copyWith(nearbyDrivers: const OperationResult.loading()));

      final res = await _driverRepository.getDriverNearby(req);

      final currentList = state.nearbyDrivers.value ?? [];
      final mergedList = {
        for (final item in currentList) item.id: item,
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
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      // Keep previous data on error if available, or emit failure
      if (state.nearbyDrivers.value != null) {
        // Just keep success state with old data? Or maybe not emit anything?
        // If we emit failed, UI might show error screen.
        // Let's emit success with old data to avoid disrupting map
        emit(
          state.copyWith(
            nearbyDrivers: OperationResult.success(state.nearbyDrivers.value!),
          ),
        );
      } else {
        emit(state.copyWith(nearbyDrivers: OperationResult.failed(e)));
      }
    }
  });

  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async => await taskManager.execute(
    'URC-gNP-${coord.hashCode}-$isRefresh',
    () async {
      try {
        final currentToken = state.nearbyPlaces.value?.token;
        if (isRefresh && currentToken == null) {
          emit(state.copyWith(nearbyPlaces: const OperationResult.loading()));
        }

        final res = await _mapService.nearbyLocation(
          coord,
          nextPageToken: isRefresh ? null : currentToken,
        );

        final currentData = state.nearbyPlaces.value?.data ?? [];
        final mergedList = isRefresh ? res.data : [...currentData, ...res.data];

        emit(
          state.copyWith(
            nearbyPlaces: OperationResult.success(
              PageTokenPaginationResult(data: mergedList, token: res.token),
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserRideCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        if (state.nearbyPlaces.value != null) {
          emit(
            state.copyWith(
              nearbyPlaces: OperationResult.success(state.nearbyPlaces.value!),
            ),
          );
        } else {
          emit(state.copyWith(nearbyPlaces: OperationResult.failed(e)));
        }
      }
    },
  );

  String? _searchQuery;
  Future<void> searchPlaces(
    String query, {
    Coordinate? coordinate,
    bool isRefresh = false,
  }) async => await taskManager.execute('URC-sP-$query', () async {
    try {
      final isNewQuery = _searchQuery != query;
      final currentToken = state.searchPlaces.value?.token;

      if (isNewQuery || (isRefresh && currentToken == null)) {
        emit(state.copyWith(searchPlaces: const OperationResult.loading()));
      }

      final res = await _mapService.searchPlace(
        query,
        coordinate: coordinate,
        nextPageToken: (isRefresh || isNewQuery) ? null : currentToken,
      );

      final currentData = state.searchPlaces.value?.data ?? [];
      final mergedList = (isRefresh || isNewQuery)
          ? res.data
          : [...currentData, ...res.data];

      _searchQuery = query;

      emit(
        state.copyWith(
          searchPlaces: OperationResult.success(
            PageTokenPaginationResult(data: mergedList, token: res.token),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      if (state.searchPlaces.value != null) {
        emit(
          state.copyWith(
            searchPlaces: OperationResult.success(state.searchPlaces.value!),
          ),
        );
      } else {
        emit(state.copyWith(searchPlaces: OperationResult.failed(e)));
      }
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
        '[UserRideCubit] - getRoutes error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }
}
