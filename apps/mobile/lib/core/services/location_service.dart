import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static const tag = 'LocationService';

  Coordinate? currentCoordinate;

  Future<bool> checkEnable() async {
    logger.d('[$tag] | checkEnable called');
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      logger.d('[$tag] | Location service enabled: $enabled');
      return enabled;
    } catch (e, st) {
      logger.e(
        '[$tag] | checkEnable failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  Future<bool> checkPermission() async {
    logger.d('[$tag] | checkPermission called');
    try {
      final permission = await Geolocator.checkPermission();
      final allowed =
          permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
      logger.d(
        '[$tag] | Location permission allowed: $allowed',
      );
      return allowed;
    } catch (e, st) {
      logger.e(
        '[$tag] | checkPermission failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  Future<bool> requestPermission() async {
    logger.d('[$tag] | requestPermission called');
    try {
      var permission = await Geolocator.checkPermission();
      logger.d('[$tag] | Initial permission: $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        logger.d('[$tag] | Permission after request: $permission');
      }

      if (permission == LocationPermission.deniedForever) {
        logger.w(
          '[$tag] | Permission denied forever, opening settings',
        );
        await Geolocator.openAppSettings();
        return false;
      }

      final result =
          permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
      logger.d('[$tag] | requestPermission result: $result');
      return result;
    } catch (e, st) {
      logger.e(
        '[$tag] | requestPermission failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  Future<bool> enable() async {
    logger.d('[$tag] | enable called');
    try {
      if (!await checkPermission()) await requestPermission();
      final opened = await Geolocator.openLocationSettings();
      logger.d('[$tag] | Location settings opened: $opened');
      return opened;
    } catch (e, st) {
      logger.e(
        '[$tag] | enable failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  Future<void> ensureInitialized() async {
    logger.d('[$tag] | ensureInitialized called');
    try {
      if (!await checkPermission()) await requestPermission();
      if (!await checkEnable()) await enable();
    } catch (e, st) {
      logger.e(
        '[$tag] | ensureInitialized failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<Coordinate?> getMyLocation({
    LocationAccuracy accuracy = LocationAccuracy.low,
    bool fromCache = true,
    Duration? timeout,
    bool forceLocationManager = false,
  }) async {
    logger.d(
      '[$tag] | getMyLocation called (fromCache: $fromCache,accuracy: $accuracy)',
    );
    try {
      if (!await checkPermission()) {
        logger.w('[$tag] | No permission for location');
        return null;
      }
      if (!await checkEnable()) {
        logger.w('[$tag] | Location service not enabled');
        return null;
      }

      if (fromCache) {
        if (currentCoordinate != null) {
          logger.d('[$tag] | Returning cached coordinate');
          return currentCoordinate;
        }

        final future = Geolocator.getLastKnownPosition(
          forceAndroidLocationManager: forceLocationManager,
        );
        final lastPosition = timeout != null
            ? await future.timeout(timeout, onTimeout: () => null)
            : await future;
        if (lastPosition != null) {
          logger.d('[$tag] | Using last known position');
          return currentCoordinate = Coordinate(
            y: lastPosition.latitude,
            x: lastPosition.longitude,
          );
        }
      }

      var settings = LocationSettings(accuracy: accuracy, timeLimit: timeout);

      if (Platform.isAndroid) {
        settings = AndroidSettings(
          accuracy: accuracy,
          timeLimit: timeout,
          forceLocationManager: forceLocationManager,
        );
      }

      logger.d('[$tag] | Getting current position');
      final position = await Geolocator.getCurrentPosition(
        locationSettings: settings,
      );

      logger.d(
        '[$tag] | Location obtained: (${position.latitude}, ${position.longitude})',
      );
      return currentCoordinate = Coordinate(
        y: position.latitude,
        x: position.longitude,
      );
    } catch (e, st) {
      logger.e(
        '[$tag] | getMyLocation failed',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  Stream<Coordinate> getLocationStream({
    LocationAccuracy accuracy = LocationAccuracy.low,
    Duration interval = const Duration(seconds: 5),
    bool forceLocationManager = false,
  }) {
    logger.d(
      '[$tag] | getLocationStream called (accuracy: $accuracy)',
    );
    try {
      var settings = LocationSettings(
        accuracy: accuracy,
      );

      if (Platform.isAndroid) {
        settings = AndroidSettings(
          accuracy: accuracy,
          intervalDuration: interval,
          forceLocationManager: forceLocationManager,
        );
      }

      return Geolocator.getPositionStream(
        locationSettings: settings,
      ).map((position) {
        final coord = Coordinate(
          y: position.latitude,
          x: position.longitude,
        );
        currentCoordinate = coord;
        return coord;
      });
    } catch (e) {
      logger.e(
        '[$tag] | getLocationStream failed',
        error: e,
      );
      return const Stream.empty();
    }
  }

  Future<Placemark?> getPlacemark({
    required double lat,
    required double lng,
  }) async {
    logger.d('[$tag] | getPlacemark called for ($lat, $lng)');
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      final result = placemarks.isEmpty ? null : placemarks.first;
      logger.d(
        '[$tag] | Placemark result: ${result?.locality ?? "none"}',
      );
      return result;
    } catch (e, st) {
      logger.e(
        '[$tag] | getPlacemark failed',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }
}
