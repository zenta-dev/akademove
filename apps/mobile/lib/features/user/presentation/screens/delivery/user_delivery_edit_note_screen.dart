import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryEditDetailScreen extends StatefulWidget {
  const UserDeliveryEditDetailScreen({
    super.key,
    required this.initialNote,
    required this.place,
    required this.isPickup,
  });
  final OrderNote initialNote;
  final Place place;
  final bool isPickup;

  @override
  State<UserDeliveryEditDetailScreen> createState() =>
      _UserDeliveryEditDetailScreenState();
}

class _UserDeliveryEditDetailScreenState
    extends State<UserDeliveryEditDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late TextEditingController _phoneController;

  OrderNote _note = OrderNote();
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _note = widget.initialNote;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _fitMapToBounds() async {
    final orderState = context.read<UserOrderCubit>().state;
    final pickup = orderState.pickupLocation;
    final dropoff = orderState.dropoffLocation;

    if (pickup == null || dropoff == null || _mapController == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        pickup.lat < dropoff.lat ? pickup.lat : dropoff.lat,
        pickup.lng < dropoff.lng ? pickup.lng : dropoff.lng,
      ),
      northeast: LatLng(
        pickup.lat > dropoff.lat ? pickup.lat : dropoff.lat,
        pickup.lng > dropoff.lng ? pickup.lng : dropoff.lng,
      ),
    );

    await _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: Text(
            context.l10n.edit_detail,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(_note),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: BlocBuilder<UserMapCubit, UserMapState>(
                builder: (context, state) {
                  if (state.routeCoordinates.isLoading) {
                    return Container(
                      width: double.infinity,
                      height: 150.h,
                      color: context.colorScheme.mutedForeground,
                    ).asSkeleton(enabled: true);
                  }
                  return MapWrapperWidget(
                    onMapCreated: (controller) async {
                      _mapController = controller;
                      setState(() {});
                      await _fitMapToBounds();
                    },
                    markers: state.markers,
                    polylines: state.polylines,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
