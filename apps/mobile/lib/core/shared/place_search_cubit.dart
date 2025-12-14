import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Shared state for place search and nearby driver functionality.
///
/// This consolidates the duplicate state from UserRideState and UserDeliveryState
/// into a single reusable cubit.
class PlaceSearchState extends Equatable {
  const PlaceSearchState({
    this.nearbyDrivers = const OperationResult.idle(),
    this.nearbyPlaces = const OperationResult.idle(),
    this.searchPlaces = const OperationResult.idle(),
    this.mapController,
  });

  final OperationResult<List<Driver>> nearbyDrivers;
  final OperationResult<PageTokenPaginationResult<List<Place>>> nearbyPlaces;
  final OperationResult<PageTokenPaginationResult<List<Place>>> searchPlaces;
  final GoogleMapController? mapController;

  @override
  List<Object?> get props => [
    nearbyDrivers,
    nearbyPlaces,
    searchPlaces,
    mapController,
  ];

  PlaceSearchState copyWith({
    OperationResult<List<Driver>>? nearbyDrivers,
    OperationResult<PageTokenPaginationResult<List<Place>>>? nearbyPlaces,
    OperationResult<PageTokenPaginationResult<List<Place>>>? searchPlaces,
    GoogleMapController? mapController,
  }) {
    return PlaceSearchState(
      nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      searchPlaces: searchPlaces ?? this.searchPlaces,
      mapController: mapController ?? this.mapController,
    );
  }

  @override
  bool get stringify => true;
}

/// Shared cubit for place search and nearby driver functionality.
///
/// @deprecated Use [OrderLocationCubit] from order feature instead.
/// This cubit is kept for backwards compatibility but should be migrated to
/// OrderLocationCubit which consolidates the functionality from UserRideCubit
/// and UserDeliveryCubit.
///
/// - Searching places by text
/// - Getting nearby places
/// - Getting nearby drivers
/// - Managing map controller
///
/// Usage:
/// ```dart
/// // In widget
/// BlocProvider(
///   create: (_) => sl<PlaceSearchCubit>(),
///   child: YourWidget(),
/// )
/// ```
class PlaceSearchCubit extends BaseCubit<PlaceSearchState> {
  PlaceSearchCubit({
    required DriverRepository driverRepository,
    required MapService mapService,
  }) : _driverRepository = driverRepository,
       _mapService = mapService,
       super(const PlaceSearchState());

  final DriverRepository _driverRepository;
  final MapService _mapService;

  String? _searchQuery;

  void reset() {
    _searchQuery = null;
    emit(const PlaceSearchState());
  }

  void clearSearchPlaces() => emit(
    state.copyWith(
      searchPlaces: OperationResult.success(
        const PageTokenPaginationResult(data: []),
      ),
    ),
  );

  void setMapController(GoogleMapController controller) {
    emit(state.copyWith(mapController: controller));
  }

  /// Get drivers nearby a location.
  Future<void> getNearbyDrivers(GetDriverNearbyQuery req) async =>
      await taskManager.execute("PSC-gND-${req.hashCode}", () async {
        try {
          emit(state.copyWith(nearbyDrivers: const OperationResult.loading()));

          final res = await _driverRepository.getDriverNearby(req);

          // Merge with existing drivers to avoid flickering
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
            '[PlaceSearchCubit] - getNearbyDrivers error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Keep previous data on error if available
          if (state.nearbyDrivers.value != null) {
            emit(
              state.copyWith(
                nearbyDrivers: OperationResult.success(
                  state.nearbyDrivers.value!,
                ),
              ),
            );
          } else {
            emit(state.copyWith(nearbyDrivers: OperationResult.failed(e)));
          }
        }
      });

  /// Get places near a coordinate.
  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async => await taskManager.execute(
    'PSC-gNP-${coord.hashCode}-$isRefresh',
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
          '[PlaceSearchCubit] - getNearbyPlaces error: ${e.message}',
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

  /// Search places by text query.
  Future<void> searchPlaces(
    String query, {
    Coordinate? coordinate,
    bool isRefresh = false,
  }) async => await taskManager.execute('PSC-sP-$query', () async {
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
        '[PlaceSearchCubit] - searchPlaces error: ${e.message}',
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

  /// Get routes between two coordinates.
  Future<List<Coordinate>> getRoutes(
    Coordinate origin,
    Coordinate destination,
  ) async {
    try {
      return await _mapService.getRoutes(origin, destination);
    } on BaseError catch (e, st) {
      logger.e(
        '[PlaceSearchCubit] - getRoutes error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }
}
