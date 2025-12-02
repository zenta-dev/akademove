import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserLocationCubit extends BaseCubit<UserLocationState> {
  UserLocationCubit({required LocationService locationService})
    : _locationService = locationService,
      super(UserLocationState());

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

        final loc = await _locationService.getMyLocation(
          accuracy: accuracy,
          fromCache: fromCache,
          forceLocationManager: forceLocationManager,
        );

        emit(state.toSuccess(coordinate: loc));
        if (loc != null) {
          final placemark = await _locationService.getPlacemark(
            lat: loc.y.toDouble(),
            lng: loc.x.toDouble(),
          );
          emit(state.toSuccess(coordinate: loc, placemark: placemark));
          return loc;
        }

        emit(state.toSuccess(coordinate: loc));
        return loc;
      } catch (e) {
        emit(state.toSuccess());
        return null;
      }
    }
  });
}
