import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart' as api show Coordinate;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService extends BaseService {
  Future<bool> enable();
  Future<bool> requestPermission();
  Future<api.Coordinate?> getMyLocation();
  Future<Placemark?> getPlacemark(double lat, double lng);

  bool get isEnabled;
  bool get isAllowed;
  api.Coordinate? get currentCoordinate;
  Placemark? get placemark;
}

class ILocationService implements LocationService {
  bool _isEnabled = false;
  bool _isAllowed = false;
  api.Coordinate? _currentCoordinate;
  Placemark? _currentPlacemark;

  @override
  bool get isEnabled => _isEnabled;

  @override
  bool get isAllowed => _isAllowed;

  @override
  api.Coordinate? get currentCoordinate => _currentCoordinate;

  @override
  Placemark? get placemark => _currentPlacemark;

  @override
  Future<void> setup() async {
    try {
      _isEnabled = await Geolocator.isLocationServiceEnabled();
      _isAllowed = await _checkPermission();

      if (_isAllowed && _isEnabled) {
        await _fetchAndCacheLocation();
      }
    } catch (_) {}
  }

  @override
  void teardown() {
    _isEnabled = false;
    _isAllowed = false;
    _currentCoordinate = null;
    _currentPlacemark = null;
  }

  @override
  Future<bool> enable() async {
    try {
      if (await Geolocator.isLocationServiceEnabled()) {
        return _isEnabled = true;
      }

      final opened = await Geolocator.openLocationSettings();
      _isEnabled = opened;
      if (_isAllowed && _isEnabled) {
        await _fetchAndCacheLocation();
      }
      return _isEnabled;
    } catch (_) {
      return _isEnabled = false;
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return _isAllowed = false;
      }

      return _isAllowed =
          permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (_) {
      return _isAllowed = false;
    }
  }

  @override
  Future<api.Coordinate?> getMyLocation() async {
    try {
      if (!await requestPermission()) return null;
      if (!await _ensureServiceEnabled()) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(),
      );

      return _currentCoordinate = api.Coordinate(
        y: position.latitude,
        x: position.longitude,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Placemark?> getPlacemark(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      return placemarks.isEmpty ? null : placemarks.first;
    } catch (_) {
      return null;
    }
  }

  Future<bool> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _ensureServiceEnabled() async {
    if (await Geolocator.isLocationServiceEnabled()) return true;
    return enable();
  }

  Future<void> _fetchAndCacheLocation() async {
    final coord = await getMyLocation();
    if (coord != null) {
      _currentPlacemark = await getPlacemark(
        coord.y.toDouble(),
        coord.x.toDouble(),
      );
    }
  }
}
