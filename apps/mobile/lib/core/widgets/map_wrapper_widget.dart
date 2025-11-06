import 'package:akademove/core/_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MapWrapperWidget extends StatefulWidget {
  const MapWrapperWidget({
    super.key,
    this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.webGestureHandling,
    this.webCameraControlPosition,
    this.webCameraControlEnabled = true,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.liteModeEnabled = false,
    this.tiltGesturesEnabled = true,
    this.fortyFiveDegreeImageryEnabled = false,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.layoutDirection,
    this.padding = EdgeInsets.zero,
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.markers = const <Marker>{},
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.circles = const <Circle>{},
    this.clusterManagers = const <ClusterManager>{},
    this.heatmaps = const <Heatmap>{},
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.groundOverlays = const <GroundOverlay>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.onTap,
    this.onLongPress,
    this.cloudMapId,
  });
  final MapCreatedCallback? onMapCreated;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MapType mapType;
  final TextDirection? layoutDirection;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool liteModeEnabled;
  final bool tiltGesturesEnabled;
  final bool fortyFiveDegreeImageryEnabled;
  final EdgeInsets padding;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<Heatmap> heatmaps;
  final Set<TileOverlay> tileOverlays;
  final Set<ClusterManager> clusterManagers;
  final Set<GroundOverlay> groundOverlays;
  final VoidCallback? onCameraMoveStarted;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final ArgumentCallback<LatLng>? onTap;
  final ArgumentCallback<LatLng>? onLongPress;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool indoorViewEnabled;
  final bool trafficEnabled;
  final bool buildingsEnabled;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final WebGestureHandling? webGestureHandling;
  final WebCameraControlPosition? webCameraControlPosition;
  final bool webCameraControlEnabled;
  final String? cloudMapId;

  @override
  State<MapWrapperWidget> createState() => _MapWrapperWidgetState();
}

class _MapWrapperWidgetState extends State<MapWrapperWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GoogleMap(
      initialCameraPosition: MapConstants.defaultCameraPosition,
      style: context.isDarkMode ? MapConstants.darkStyle : null,
      onMapCreated: widget.onMapCreated,
      gestureRecognizers: widget.gestureRecognizers,
      webGestureHandling: widget.webGestureHandling,
      webCameraControlPosition: widget.webCameraControlPosition,
      webCameraControlEnabled: widget.webCameraControlEnabled,
      compassEnabled: widget.compassEnabled,
      mapToolbarEnabled: widget.mapToolbarEnabled,
      cameraTargetBounds: widget.cameraTargetBounds,
      mapType: widget.mapType,
      minMaxZoomPreference: widget.minMaxZoomPreference,
      rotateGesturesEnabled: widget.rotateGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      zoomControlsEnabled: widget.zoomControlsEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      liteModeEnabled: widget.liteModeEnabled,
      tiltGesturesEnabled: widget.tiltGesturesEnabled,
      fortyFiveDegreeImageryEnabled: widget.fortyFiveDegreeImageryEnabled,
      myLocationEnabled: widget.myLocationEnabled,
      myLocationButtonEnabled: widget.myLocationButtonEnabled,
      layoutDirection: widget.layoutDirection,
      padding: widget.padding,
      indoorViewEnabled: widget.indoorViewEnabled,
      trafficEnabled: widget.trafficEnabled,
      buildingsEnabled: widget.buildingsEnabled,
      markers: widget.markers,
      polygons: widget.polygons,
      polylines: widget.polylines,
      circles: widget.circles,
      clusterManagers: widget.clusterManagers,
      heatmaps: widget.heatmaps,
      onCameraMoveStarted: widget.onCameraMoveStarted,
      tileOverlays: widget.tileOverlays,
      groundOverlays: widget.groundOverlays,
      onCameraMove: widget.onCameraMove,
      onCameraIdle: widget.onCameraIdle,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      cloudMapId: widget.cloudMapId,
    );
  }
}
