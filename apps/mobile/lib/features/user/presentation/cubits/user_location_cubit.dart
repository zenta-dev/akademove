import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserLocationCubit extends BaseCubit<UserLocationState> {
  UserLocationCubit({required LocationService locationService})
    : _locationService = locationService,
      super(const UserLocationState());

  final LocationService _locationService;

  Future<Coordinate?> getMyLocation(
    BuildContext context, {
    LocationAccuracy accuracy = LocationAccuracy.best,
    bool fromCache = false,
    bool forceLocationManager = false,
  }) async => taskManager.execute('ULC-gML-$accuracy', () async {
    {
      try {
        await _locationService.ensureInitialized();

        // Initial loading state? Maybe not needed if we want to keep previous location while fetching.
        // But let's assume we want to show loading indicator if it takes time.
        // emit(state.copyWith(location: const OperationResult.loading()));

        final loc = await _locationService.getMyLocation(
          accuracy: accuracy,
          fromCache: fromCache,
          forceLocationManager: forceLocationManager,
        );

        if (loc == null) {
          emit(state.copyWith(location: const OperationResult.idle()));
          return null;
        }

        // First emit with coordinate only
        emit(state.copyWith(location: OperationResult.success((loc, null))));

        final placemark = await _locationService.getPlacemark(
          lat: loc.y.toDouble(),
          lng: loc.x.toDouble(),
        );

        // Second emit with coordinate and placemark
        emit(
          state.copyWith(location: OperationResult.success((loc, placemark))),
        );
        return loc;
      } catch (e) {
        // Wrap generic error in BaseError if possible, or create a generic one
        final error = e is BaseError
            ? e
            : UnknownError(e.toString(), code: ErrorCode.unknown);
        emit(state.copyWith(location: OperationResult.failed(error)));
        return null;
      }
    }
  });
}
