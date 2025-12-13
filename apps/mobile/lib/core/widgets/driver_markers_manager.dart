import "dart:async";
import "dart:ui" show Offset;

import "package:akademove/core/_export.dart";
import "package:akademove/gen/assets.gen.dart";
import "package:api_client/api_client.dart";
import "package:flutter/widgets.dart" show ImageConfiguration, Size;
import "package:google_maps_flutter/google_maps_flutter.dart";

/// A manager class for efficiently handling multiple driver markers on Google Maps.
///
/// This class prevents unnecessary re-renders by:
/// - Tracking each driver's marker individually by driver ID
/// - Only updating markers whose locations actually changed
/// - Using smooth animations for location transitions
/// - Maintaining marker identity to prevent full re-renders
///
/// Usage:
/// ```dart
/// final manager = DriverMarkersManager(
///   onMarkersUpdated: (markers) {
///     // Update your markers set - only changed markers will be different
///     locationCubit.setDriverMarkers(markers.toList());
///   },
/// );
///
/// // When driver list updates:
/// manager.updateDrivers(driversList);
///
/// // Don't forget to dispose:
/// manager.dispose();
/// ```
class DriverMarkersManager {
  DriverMarkersManager({
    required this.onMarkersUpdated,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationSteps = 30,
    this.positionThreshold = 0.00001,
  });

  /// Callback when markers are updated (called with the complete set of markers)
  final void Function(Set<Marker> markers) onMarkersUpdated;

  /// Duration of the animation when driver moves
  final Duration animationDuration;

  /// Number of steps in the animation
  final int animationSteps;

  /// Threshold for position change to trigger animation
  final double positionThreshold;

  /// Current driver icon
  BitmapDescriptor? _driverIcon;

  /// Whether the marker icon has been loaded
  bool _iconLoaded = false;

  /// Map of driver ID to their marker data
  final Map<String, _DriverMarkerData> _driverMarkers = {};

  /// Active animation timers by driver ID
  final Map<String, Timer> _animationTimers = {};

  /// Load the custom driver icon
  Future<void> loadDriverIcon() async {
    if (_iconLoaded) return;

    try {
      _driverIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(64, 64)),
        Assets.images.motorcycleAbove.path,
      );
      _iconLoaded = true;
    } catch (e) {
      logger.e("[DriverMarkersManager] Error loading driver icon: $e");
      _driverIcon = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      );
      _iconLoaded = true;
    }
  }

  /// Update drivers - only updates markers for drivers whose location actually changed
  ///
  /// [drivers] - The current list of nearby drivers
  /// [animate] - Whether to animate location changes (default: true)
  void updateDrivers(List<Driver> drivers, {bool animate = true}) {
    final currentDriverIds = <String>{};
    var hasChanges = false;

    for (final driver in drivers) {
      final location = driver.currentLocation;
      if (location == null) continue;

      final driverId = driver.id;
      currentDriverIds.add(driverId);

      final existingData = _driverMarkers[driverId];
      final newPosition = LatLng(location.y.toDouble(), location.x.toDouble());

      // Check if this driver's position actually changed
      if (existingData != null) {
        if (_isPositionClose(existingData.currentPosition, newPosition)) {
          // Position hasn't changed significantly - skip this driver
          continue;
        }
      }

      hasChanges = true;

      // Create or update driver marker data
      if (existingData == null) {
        // New driver - create marker immediately
        _driverMarkers[driverId] = _DriverMarkerData(
          driverId: driverId,
          currentPosition: newPosition,
          driver: driver,
        );
      } else if (animate) {
        // Existing driver with new position - animate
        _animateDriverToPosition(driverId, existingData, newPosition, driver);
      } else {
        // Existing driver - update immediately without animation
        _driverMarkers[driverId] = existingData.copyWith(
          currentPosition: newPosition,
          driver: driver,
        );
      }
    }

    // Remove markers for drivers that are no longer in the list
    final driversToRemove = _driverMarkers.keys
        .where((id) => !currentDriverIds.contains(id))
        .toList();

    for (final driverId in driversToRemove) {
      _animationTimers[driverId]?.cancel();
      _animationTimers.remove(driverId);
      _driverMarkers.remove(driverId);
      hasChanges = true;
    }

    // Only emit update if something actually changed
    if (hasChanges) {
      _emitMarkers();
    }
  }

  /// Update a single driver's location (for real-time WebSocket updates)
  ///
  /// [driverId] - The driver's ID
  /// [location] - The new location
  /// [driver] - Optional driver info for marker info window
  /// [animate] - Whether to animate the transition
  void updateSingleDriver(
    String driverId,
    Coordinate location, {
    Driver? driver,
    bool animate = true,
  }) {
    final newPosition = LatLng(location.y.toDouble(), location.x.toDouble());

    final existingData = _driverMarkers[driverId];

    // Check if position actually changed
    if (existingData != null &&
        _isPositionClose(existingData.currentPosition, newPosition)) {
      return; // No change needed
    }

    if (existingData == null) {
      // New driver
      _driverMarkers[driverId] = _DriverMarkerData(
        driverId: driverId,
        currentPosition: newPosition,
        driver: driver,
      );
      _emitMarkers();
    } else if (animate) {
      // Animate to new position
      _animateDriverToPosition(driverId, existingData, newPosition, driver);
    } else {
      // Update immediately
      _driverMarkers[driverId] = existingData.copyWith(
        currentPosition: newPosition,
        driver: driver ?? existingData.driver,
      );
      _emitMarkers();
    }
  }

  /// Check if two positions are close enough to skip update
  bool _isPositionClose(LatLng pos1, LatLng pos2) {
    return (pos1.latitude - pos2.latitude).abs() < positionThreshold &&
        (pos1.longitude - pos2.longitude).abs() < positionThreshold;
  }

  /// Animate a driver marker to a new position
  void _animateDriverToPosition(
    String driverId,
    _DriverMarkerData data,
    LatLng targetPosition,
    Driver? driver,
  ) {
    // Cancel any ongoing animation for this driver
    _animationTimers[driverId]?.cancel();

    final startPosition = data.currentPosition;
    var currentStep = 0;

    final stepDuration = Duration(
      milliseconds: animationDuration.inMilliseconds ~/ animationSteps,
    );

    _animationTimers[driverId] = Timer.periodic(stepDuration, (timer) {
      currentStep++;

      if (currentStep >= animationSteps) {
        // Animation complete
        timer.cancel();
        _animationTimers.remove(driverId);
        _driverMarkers[driverId] = data.copyWith(
          currentPosition: targetPosition,
          previousPosition: startPosition,
          driver: driver ?? data.driver,
        );
        _emitMarkers();
        return;
      }

      // Calculate interpolated position using easeInOut curve
      final t = _easeInOut(currentStep / animationSteps);
      final interpolatedPosition = LatLng(
        _lerp(startPosition.latitude, targetPosition.latitude, t),
        _lerp(startPosition.longitude, targetPosition.longitude, t),
      );

      _driverMarkers[driverId] = data.copyWith(
        currentPosition: interpolatedPosition,
        previousPosition: startPosition,
        targetPosition: targetPosition,
        driver: driver ?? data.driver,
      );

      _emitMarkers();
    });
  }

  /// Linear interpolation
  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  /// Ease in-out curve
  double _easeInOut(double t) {
    return t < 0.5 ? 2 * t * t : 1 - (-2 * t + 2) * (-2 * t + 2) / 2;
  }

  /// Calculate bearing angle for marker rotation
  double _calculateBearing(LatLng? start, LatLng? end) {
    if (start == null || end == null || start == end) {
      return 0;
    }

    final lat1 = start.latitude * 3.141592653589793 / 180;
    final lat2 = end.latitude * 3.141592653589793 / 180;
    final dLon = (end.longitude - start.longitude) * 3.141592653589793 / 180;

    final y = _sin(dLon) * _cos(lat2);
    final x = _cos(lat1) * _sin(lat2) - _sin(lat1) * _cos(lat2) * _cos(dLon);

    final bearing = _atan2(y, x) * 180 / 3.141592653589793;
    return (bearing + 360) % 360;
  }

  // Math helpers to avoid importing dart:math
  double _sin(double x) => _taylorSin(x);
  double _cos(double x) => _taylorSin(x + 3.141592653589793 / 2);
  double _atan2(double y, double x) {
    if (x > 0) return _atan(y / x);
    if (x < 0 && y >= 0) return _atan(y / x) + 3.141592653589793;
    if (x < 0 && y < 0) return _atan(y / x) - 3.141592653589793;
    if (x == 0 && y > 0) return 3.141592653589793 / 2;
    if (x == 0 && y < 0) return -3.141592653589793 / 2;
    return 0;
  }

  double _atan(double x) {
    // Simple atan approximation for small angles
    if (x.abs() < 1) {
      return x - (x * x * x) / 3 + (x * x * x * x * x) / 5;
    }
    return (x > 0 ? 1 : -1) * (3.141592653589793 / 2 - _atan(1 / x));
  }

  double _taylorSin(double x) {
    // Normalize x to [-pi, pi]
    while (x > 3.141592653589793) {
      x -= 2 * 3.141592653589793;
    }
    while (x < -3.141592653589793) {
      x += 2 * 3.141592653589793;
    }
    // Taylor series for sin
    final x2 = x * x;
    return x * (1 - x2 / 6 * (1 - x2 / 20 * (1 - x2 / 42)));
  }

  /// Emit the current set of markers
  void _emitMarkers() {
    final markers = _driverMarkers.values.map((data) {
      final rotation = _calculateBearing(
        data.previousPosition,
        data.targetPosition ?? data.currentPosition,
      );

      return Marker(
        markerId: MarkerId("driver_${data.driverId}"),
        position: data.currentPosition,
        icon:
            _driverIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        anchor: const Offset(0.5, 0.5),
        rotation: rotation,
        flat: true,
        infoWindow: InfoWindow(
          title: data.driver?.user?.name ?? "Driver",
          snippet: data.driver != null && data.driver!.rating != 0
              ? "Rating: ${data.driver!.rating.toStringAsFixed(1)}"
              : null,
        ),
      );
    }).toSet();

    onMarkersUpdated(markers);
  }

  /// Get current marker count
  int get markerCount => _driverMarkers.length;

  /// Check if a specific driver has a marker
  bool hasDriver(String driverId) => _driverMarkers.containsKey(driverId);

  /// Clear all markers
  void clear() {
    for (final timer in _animationTimers.values) {
      timer.cancel();
    }
    _animationTimers.clear();
    _driverMarkers.clear();
    onMarkersUpdated({});
  }

  /// Dispose of resources
  void dispose() {
    for (final timer in _animationTimers.values) {
      timer.cancel();
    }
    _animationTimers.clear();
    _driverMarkers.clear();
  }
}

/// Internal data class for tracking driver marker state
class _DriverMarkerData {
  _DriverMarkerData({
    required this.driverId,
    required this.currentPosition,
    this.previousPosition,
    this.targetPosition,
    this.driver,
  });

  final String driverId;
  final LatLng currentPosition;
  final LatLng? previousPosition;
  final LatLng? targetPosition;
  final Driver? driver;

  _DriverMarkerData copyWith({
    LatLng? currentPosition,
    LatLng? previousPosition,
    LatLng? targetPosition,
    Driver? driver,
  }) {
    return _DriverMarkerData(
      driverId: driverId,
      currentPosition: currentPosition ?? this.currentPosition,
      previousPosition: previousPosition ?? this.previousPosition,
      targetPosition: targetPosition,
      driver: driver ?? this.driver,
    );
  }
}
