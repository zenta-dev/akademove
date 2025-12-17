import "dart:async";
import "dart:math" as math;
import "dart:ui" show Offset;

import "package:akademove/core/_export.dart";
import "package:akademove/gen/assets.gen.dart";
import "package:api_client/api_client.dart";
import "package:flutter/widgets.dart" show ImageConfiguration, Size;
import "package:google_maps_flutter/google_maps_flutter.dart";

/// A helper class for managing animated driver markers on Google Maps.
///
/// This class provides smooth animation of driver markers as their location
/// updates in real-time, creating a more fluid user experience when tracking
/// drivers during active orders.
///
/// Usage:
/// ```dart
/// final animatedMarker = AnimatedDriverMarker(
///   onMarkerUpdated: (marker) {
///     // Update your markers set and rebuild the map
///     setState(() {
///       markers = {...markers.where((m) => m.markerId.value != 'driver'), marker};
///     });
///   },
/// );
///
/// // When driver location updates:
/// animatedMarker.updateDriverLocation(newLocation);
///
/// // Don't forget to dispose:
/// animatedMarker.dispose();
/// ```
class AnimatedDriverMarker {
  AnimatedDriverMarker({
    required this.onMarkerUpdated,
    this.markerId = "driver",
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationSteps = 30,
  });

  /// Callback when marker position is updated (called multiple times during animation)
  final void Function(Marker marker) onMarkerUpdated;

  /// Unique identifier for the driver marker
  final String markerId;

  /// Duration of the animation when driver moves
  final Duration animationDuration;

  /// Number of steps in the animation (higher = smoother but more updates)
  final int animationSteps;

  /// Current driver icon
  BitmapDescriptor? _driverIcon;

  /// Get the driver icon (for external use when creating markers)
  BitmapDescriptor? get driverIcon => _driverIcon;

  /// Current position of the marker
  LatLng? _currentPosition;

  /// Target position for animation
  LatLng? _targetPosition;

  /// Animation timer
  Timer? _animationTimer;

  /// Current animation step
  int _currentStep = 0;

  /// Starting position for current animation
  LatLng? _animationStartPosition;

  /// Driver info for marker info window
  Driver? _driverInfo;

  /// Whether the marker icon has been loaded
  bool _iconLoaded = false;

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
      logger.e("[AnimatedDriverMarker] Error loading driver icon: $e");
      // Use default blue marker as fallback
      _driverIcon = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      );
      _iconLoaded = true;
    }
  }

  /// Update the driver's location with smooth animation
  ///
  /// [coordinate] - The new driver coordinate from the server
  /// [driver] - Optional driver info for the info window
  /// [animate] - Whether to animate to the new position (default: true)
  void updateDriverLocation(
    Coordinate coordinate, {
    Driver? driver,
    bool animate = true,
  }) {
    final newPosition = LatLng(
      coordinate.y.toDouble(),
      coordinate.x.toDouble(),
    );

    _driverInfo = driver;

    // If no current position, just set it immediately
    if (_currentPosition == null || !animate) {
      _currentPosition = newPosition;
      _emitMarker();
      return;
    }

    // If position hasn't changed significantly, skip animation
    if (_isPositionClose(_currentPosition!, newPosition)) {
      return;
    }

    // Start animation to new position
    _animateToPosition(newPosition);
  }

  /// Check if two positions are close enough to skip animation
  bool _isPositionClose(
    LatLng pos1,
    LatLng pos2, {
    double threshold = 0.00001,
  }) {
    return (pos1.latitude - pos2.latitude).abs() < threshold &&
        (pos1.longitude - pos2.longitude).abs() < threshold;
  }

  /// Animate the marker to a new position
  void _animateToPosition(LatLng newPosition) {
    // Cancel any ongoing animation
    _animationTimer?.cancel();

    // Store animation start and target
    _animationStartPosition = _currentPosition;
    _targetPosition = newPosition;
    _currentStep = 0;

    // Calculate step duration
    final stepDuration = Duration(
      milliseconds: animationDuration.inMilliseconds ~/ animationSteps,
    );

    // Start animation timer
    _animationTimer = Timer.periodic(stepDuration, (timer) {
      _currentStep++;

      if (_currentStep >= animationSteps) {
        // Animation complete
        timer.cancel();
        _currentPosition = _targetPosition;
        _emitMarker();
        return;
      }

      // Calculate interpolated position using easeInOut curve
      final t = _easeInOut(_currentStep / animationSteps);

      final startPos = _animationStartPosition;
      final targetPos = _targetPosition;

      if (startPos != null && targetPos != null) {
        _currentPosition = LatLng(
          _lerp(startPos.latitude, targetPos.latitude, t),
          _lerp(startPos.longitude, targetPos.longitude, t),
        );
        _emitMarker();
      }
    });
  }

  /// Linear interpolation between two values
  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  /// Ease in-out curve for smoother animation
  double _easeInOut(double t) {
    return t < 0.5 ? 2 * t * t : 1 - math.pow(-2 * t + 2, 2) / 2;
  }

  /// Emit the current marker state
  void _emitMarker() {
    final position = _currentPosition;
    if (position == null) return;

    final driver = _driverInfo;

    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon:
          _driverIcon ??
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      anchor: const Offset(0.5, 0.5),
      rotation: _calculateBearing(),
      flat: true, // Flat marker rotates with the map
      infoWindow: InfoWindow(
        title: driver?.user?.name ?? "Driver",
        snippet: driver != null && driver.rating != 0
            ? "Rating: ${driver.rating.toStringAsFixed(1)}"
            : null,
      ),
    );

    onMarkerUpdated(marker);
  }

  /// Calculate bearing angle for marker rotation
  /// This makes the driver icon point in the direction of movement
  double _calculateBearing() {
    final start = _animationStartPosition ?? _currentPosition;
    final end = _targetPosition ?? _currentPosition;

    if (start == null || end == null || start == end) {
      return 0;
    }

    // Calculate bearing from start to end position
    final lat1 = start.latitude * math.pi / 180;
    final lat2 = end.latitude * math.pi / 180;
    final dLon = (end.longitude - start.longitude) * math.pi / 180;

    final y = math.sin(dLon) * math.cos(lat2);
    final x =
        math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  /// Get the current marker position
  LatLng? get currentPosition => _currentPosition;

  /// Check if the marker has a position set
  bool get hasPosition => _currentPosition != null;

  /// Dispose of resources
  void dispose() {
    _animationTimer?.cancel();
    _animationTimer = null;
  }
}

/// Extension to easily create a driver marker from a Driver object
extension DriverMarkerExtension on Driver {
  /// Creates an animated marker update from this driver's current location
  void updateAnimatedMarker(AnimatedDriverMarker animatedMarker) {
    final location = currentLocation;
    if (location != null) {
      animatedMarker.updateDriverLocation(location, driver: this);
    }
  }
}
