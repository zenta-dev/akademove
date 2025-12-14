import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A card widget that displays the driver's current location on a map
/// with the address displayed below.
///
/// Features:
/// - Static Google Map showing current position
/// - Auto-updating address via reverse geocoding
/// - Camera auto-follows driver position
/// - Optimized for performance (no unnecessary re-renders)
///
/// Usage:
/// ```dart
/// DriverLocationCard(coordinate: currentLocation)
/// ```
class DriverLocationCard extends StatefulWidget {
  const DriverLocationCard({required this.coordinate, super.key});

  /// The current GPS coordinate of the driver.
  final Coordinate coordinate;

  @override
  State<DriverLocationCard> createState() => _DriverLocationCardState();
}

class _DriverLocationCardState extends State<DriverLocationCard> {
  GoogleMapController? _mapController;

  @override
  void didUpdateWidget(DriverLocationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animate camera to new position when location changes
    if (widget.coordinate.x != oldWidget.coordinate.x ||
        widget.coordinate.y != oldWidget.coordinate.y) {
      _animateCameraToLocation();
    }
  }

  void _animateCameraToLocation() {
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(widget.coordinate.y.toDouble(), widget.coordinate.x.toDouble()),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.coordinate.y.toDouble();
    final lng = widget.coordinate.x.toDouble();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title
          Row(
            children: [
              Icon(
                LucideIcons.mapPin,
                size: 20.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.current_location,
                      style: context.typography.h4.copyWith(fontSize: 16.sp),
                    ),
                    Text(
                      context.l10n.current_location_desc,
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Map container with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 160.h,
              width: double.infinity,
              child: MapWrapperWidget(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 16,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("driver_location"),
                    position: LatLng(lat, lng),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen,
                    ),
                    anchor: const Offset(0.5, 0.5),
                  ),
                },
                // Disable all interactions for a static display
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Address display with navigation icon
          Container(
            padding: EdgeInsets.all(12.dg),
            decoration: BoxDecoration(
              color: context.colorScheme.muted,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.navigation,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: AddressText(
                    coordinate: widget.coordinate,
                    style: context.typography.small.copyWith(
                      color: context.colorScheme.foreground,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
