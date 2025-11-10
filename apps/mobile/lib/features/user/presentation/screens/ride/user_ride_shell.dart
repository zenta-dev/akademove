import 'package:akademove/core/widgets/map_wrapper_widget.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RideMapShell extends StatefulWidget {
  const RideMapShell({required this.child, super.key});
  final Widget child;

  @override
  State<RideMapShell> createState() => _RideMapShellState();
}

class _RideMapShellState extends State<RideMapShell> {
  late final MapWrapperWidget _map;

  @override
  void initState() {
    super.initState();
    _map = MapWrapperWidget(
      onMapCreated: (controller) {
        context.read<UserRideCubit>().setMapController(controller);
      },
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _map, // Persistent map instance
        Positioned.fill(child: widget.child), // Ride step overlay
      ],
    );
  }
}
