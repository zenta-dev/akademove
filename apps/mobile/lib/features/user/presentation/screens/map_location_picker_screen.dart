import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Screen for selecting a location by interacting with a map.
/// The user can drag the map to select a location, with a fixed pin
/// marker in the center of the screen.
class MapLocationPickerScreen extends StatefulWidget {
  const MapLocationPickerScreen({
    required this.locationType,
    this.initialLocation,
    super.key,
  });

  /// Whether this picker is for pickup or dropoff location
  final LocationType locationType;

  /// Initial location to center the map on (optional)
  final Coordinate? initialLocation;

  @override
  State<MapLocationPickerScreen> createState() =>
      _MapLocationPickerScreenState();
}

class _MapLocationPickerScreenState extends State<MapLocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;
  String? _selectedAddress;
  String? _selectedName;
  bool _isLoadingAddress = false;
  bool _isCameraMoving = false;

  late final LocationService _locationService;
  late final MapService _mapService;

  @override
  void initState() {
    super.initState();
    _locationService = sl<LocationService>();
    _mapService = sl<MapService>();
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    final initial = widget.initialLocation;
    if (initial != null) {
      setState(() {
        _selectedPosition = LatLng(initial.y.toDouble(), initial.x.toDouble());
      });
    } else {
      // Try to get user's current location
      final userLocation = context.read<UserLocationCubit>().state.coordinate;
      if (userLocation != null) {
        setState(() {
          _selectedPosition = LatLng(
            userLocation.y.toDouble(),
            userLocation.x.toDouble(),
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    // Move to initial position if available
    final position = _selectedPosition;
    if (position != null) {
      await controller.animateCamera(CameraUpdate.newLatLngZoom(position, 17));
      // Fetch address for initial position
      await _fetchAddressForPosition(position);
    } else {
      // Try to get current location if no initial position
      final coordinate = await _locationService.getMyLocation();
      if (coordinate != null && mounted) {
        final pos = LatLng(coordinate.y.toDouble(), coordinate.x.toDouble());
        setState(() => _selectedPosition = pos);
        await controller.animateCamera(CameraUpdate.newLatLngZoom(pos, 17));
        await _fetchAddressForPosition(pos);
      }
    }
  }

  void _onCameraMoveStarted() {
    setState(() {
      _isCameraMoving = true;
      _isLoadingAddress = true;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _selectedPosition = position.target;
    });
  }

  Future<void> _onCameraIdle() async {
    setState(() => _isCameraMoving = false);
    final position = _selectedPosition;
    if (position != null) {
      await _fetchAddressForPosition(position);
    }
  }

  Future<void> _fetchAddressForPosition(LatLng position) async {
    setState(() => _isLoadingAddress = true);

    try {
      // First try using the MapService for reverse geocoding
      final place = await _mapService.reverseGeocode(
        Coordinate(x: position.longitude, y: position.latitude),
      );
      if (mounted) {
        setState(() {
          _selectedAddress = place.vicinity;
          _selectedName = place.name;
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      logger.w('MapService reverseGeocode failed, falling back to geocoding');
      // Fallback to device geocoding
      try {
        final placemark = await _locationService.getPlacemark(
          lat: position.latitude,
          lng: position.longitude,
        );

        if (mounted) {
          if (placemark != null) {
            final parts = <String>[
              if (placemark.street?.isNotEmpty ?? false) placemark.street!,
              if (placemark.subLocality?.isNotEmpty ?? false)
                placemark.subLocality!,
              if (placemark.locality?.isNotEmpty ?? false) placemark.locality!,
            ];
            setState(() {
              _selectedAddress = parts.isNotEmpty
                  ? parts.join(', ')
                  : 'Selected location';
              _selectedName = placemark.name ?? 'Selected location';
              _isLoadingAddress = false;
            });
          } else {
            setState(() {
              _selectedAddress =
                  '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
              _selectedName = 'Selected location';
              _isLoadingAddress = false;
            });
          }
        }
      } catch (e) {
        logger.e('Fallback geocoding also failed', error: e);
        if (mounted) {
          setState(() {
            _selectedAddress =
                '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
            _selectedName = 'Selected location';
            _isLoadingAddress = false;
          });
        }
      }
    }
  }

  Future<void> _goToCurrentLocation() async {
    final coordinate = await _locationService.getMyLocation(fromCache: false);
    if (coordinate != null && _mapController != null && mounted) {
      final position = LatLng(coordinate.y.toDouble(), coordinate.x.toDouble());
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(position, 17),
      );
    }
  }

  void _confirmSelection() {
    final position = _selectedPosition;
    if (position == null) return;

    final place = Place(
      name: _selectedName ?? 'Selected location',
      vicinity: _selectedAddress ?? 'Selected location',
      lat: position.latitude,
      lng: position.longitude,
      icon: '',
    );

    context.pop(place);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.locationType.isPickup
        ? context.l10n.title_select_pickup_location
        : context.l10n.title_select_dropoff_location;

    return Scaffold(
      headers: [DefaultAppBar(title: title)],
      child: Stack(
        children: [
          // Map
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: MapConstants.defaultCameraPosition,
              style: context.isDarkMode ? MapConstants.darkStyle : null,
              onMapCreated: _onMapCreated,
              onCameraMoveStarted: _onCameraMoveStarted,
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraIdle,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: true,
              mapToolbarEnabled: false,
            ),
          ),

          // Center pin marker
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              transform: Matrix4.translationValues(
                0,
                _isCameraMoving ? -10 : 0,
                0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 48.sp,
                    color: widget.locationType.isPickup
                        ? Colors.green
                        : context.colorScheme.destructive,
                  ),
                  // Shadow/dot below the pin
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: _isCameraMoving ? 4.w : 8.w,
                    height: _isCameraMoving ? 2.h : 4.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.dg),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Current location button
          Positioned(
            right: 16.w,
            bottom: 180.h,
            child: Card(
              padding: EdgeInsets.zero,
              child: IconButton(
                icon: Icon(LucideIcons.locateFixed, size: 24.sp),
                onPressed: _goToCurrentLocation,
                variance: const ButtonStyle.ghost(),
              ),
            ),
          ),

          // Bottom panel with address and confirm button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.card,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.dg),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.dg),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag indicator
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: context.colorScheme.muted,
                          borderRadius: BorderRadius.circular(2.dg),
                        ),
                      ),
                    ),

                    // Location info
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.dg),
                          decoration: BoxDecoration(
                            color: widget.locationType.isPickup
                                ? Colors.green.withValues(alpha: 0.1)
                                : context.colorScheme.destructive.withValues(
                                    alpha: 0.1,
                                  ),
                            borderRadius: BorderRadius.circular(8.dg),
                          ),
                          child: Icon(
                            LucideIcons.mapPin,
                            size: 20.sp,
                            color: widget.locationType.isPickup
                                ? Colors.green
                                : context.colorScheme.destructive,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _isLoadingAddress
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.muted,
                                        borderRadius: BorderRadius.circular(
                                          4.dg,
                                        ),
                                      ),
                                    ).asSkeleton(),
                                    SizedBox(height: 4.h),
                                    Container(
                                      width: 200.w,
                                      height: 14.h,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.muted,
                                        borderRadius: BorderRadius.circular(
                                          4.dg,
                                        ),
                                      ),
                                    ).asSkeleton(),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedName ?? 'Drag map to select',
                                      style: context.typography.semiBold
                                          .copyWith(fontSize: 14.sp),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      _selectedAddress ?? 'Move the map around',
                                      style: context.typography.small.copyWith(
                                        fontSize: 12.sp,
                                        color:
                                            context.colorScheme.mutedForeground,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Confirm button
                    SizedBox(
                      width: double.infinity,
                      child: Button.primary(
                        enabled:
                            _selectedPosition != null && !_isLoadingAddress,
                        onPressed: _confirmSelection,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.check, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(context.l10n.button_confirm_location),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
