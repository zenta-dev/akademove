import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRideCubit extends BaseCubit<UserRideState> {
  UserRideCubit({
    required DriverRepository driverRepository,
    required MapService mapService,
    required LocationService locationService,
  }) : _driverRepository = driverRepository,
       _mapService = mapService,
       _locationService = locationService,
       super(UserRideState());

  final DriverRepository _driverRepository;
  final MapService _mapService;
  final LocationService _locationService;

  void reset() => emit(UserRideState());

  void clearSearchPlaces() => emit(
    state.toSuccess(searchPlaces: const PageTokenPaginationResult(data: [])),
  );

  void setMapController(GoogleMapController controller) {
    emit(state.setMapController(controller));
  }

  Future<void> getNearbyDrivers(GetDriverNearbyQuery req) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _driverRepository.getDriverNearby(req);

      final mergedList = {
        for (final item in state.nearbyDrivers) item.id: item,
        for (final item in res.data) item.id: item,
      }.values.toList();

      state.unAssignOperation(methodName);
      emit(state.toSuccess(nearbyDrivers: mergedList, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toSuccess(nearbyDrivers: state.nearbyDrivers));
    }
  }

  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      if (isRefresh && state.nearbyPlaces.token == null) {
        emit(state.toLoading());
      }

      final res = await _mapService.nearbyLocation(
        coord,
        nextPageToken: isRefresh ? null : state.nearbyPlaces.token,
      );

      final mergedList = isRefresh
          ? res.data
          : [
              ...state.nearbyPlaces.data,
              ...res.data,
            ];

      state.unAssignOperation(methodName);
      emit(
        state.toSuccess(
          nearbyPlaces: PageTokenPaginationResult(
            data: mergedList,
            token: res.token,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toSuccess(nearbyPlaces: state.nearbyPlaces));
    }
  }

  String? _searchQuery;
  Future<void> searchPlaces(String query, {bool isRefresh = false}) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      final isNewQuery = _searchQuery != query;
      if (isNewQuery || (isRefresh && state.searchPlaces.token == null)) {
        emit(state.toLoading());
      }

      final res = await _mapService.searchPlace(
        query,
        coordinate: state.coordinate,
        nextPageToken: (isRefresh || isNewQuery)
            ? null
            : state.searchPlaces.token,
      );

      final mergedList = (isRefresh || isNewQuery)
          ? res.data
          : [
              ...state.searchPlaces.data,
              ...res.data,
            ];

      _searchQuery = query;

      state.unAssignOperation(methodName);
      emit(
        state.toSuccess(
          searchPlaces: PageTokenPaginationResult(
            data: mergedList,
            token: res.token,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(
        state.toSuccess(searchPlaces: state.searchPlaces),
      );
    }
  }

  Future<Coordinate?> getMyLocation(
    BuildContext context, {
    LocationAccuracy accuracy = LocationAccuracy.best,
  }) async {
    try {
      await _locationService.ensureInitialized();

      final loc = await _locationService.getMyLocation(accuracy: accuracy);
      if (loc != null) {
        final placemark = await _locationService.getPlacemark(
          lat: loc.y.toDouble(),
          lng: loc.x.toDouble(),
        );
        emit(state.toSuccess(coordinate: loc, placemark: placemark));
        await getNearbyPlaces(loc);
        return loc;
      }

      emit(state.toSuccess(coordinate: loc));
      return loc;
    } catch (e) {
      emit(state.toSuccess());
      return null;
    }
  }
}
