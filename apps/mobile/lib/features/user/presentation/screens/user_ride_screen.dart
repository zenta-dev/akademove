import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRideScreen extends StatefulWidget {
  const UserRideScreen({super.key});

  @override
  State<UserRideScreen> createState() => _UserRideScreenState();
}

class _UserRideScreenState extends State<UserRideScreen> {
  late TextEditingController pickupController;
  late TextEditingController dropoffController;
  GoogleMapController? _mapController;

  Place? pickup;
  Place? dropoff;

  @override
  void initState() {
    super.initState();
    pickupController = TextEditingController();
    dropoffController = TextEditingController();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    pickupController.dispose();
    dropoffController.dispose();
    super.dispose();
  }

  Future<void> _setupLocation() async {
    try {
      final cubit = context.read<UserRideCubit>();

      var coordinate = cubit.state.coordinate;
      coordinate ??= await cubit.getMyLocation();

      if (coordinate == null) {
        debugPrint('⚠️ Coordinate is still null after getMyLocation');
        return;
      }

      final x = coordinate.x.toDouble();
      final y = coordinate.y.toDouble();

      await _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(y, x)));

      if (mounted) {
        await cubit.getNearbyPlaces(coordinate);
      }
      setState(() {});
    } catch (e, stack) {
      debugPrint('⚠️ Location setup failed: $e\n$stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'Ride',
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      body: Column(
        spacing: 16.h,
        children: [
          Text(
            'Choose your pick-up and destination point!',
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Card(
            child: Column(
              spacing: 16.h,
              children: [
                _buildMapSection(),
                PickLocationCardWidget(
                  padding: EdgeInsets.zero,
                  borderColor: context.colorScheme.card,
                  pickup: PickLocationParameters(
                    enabled: false,
                    controller: pickupController,
                    onPresesed: () async {
                      pickup = await context.pushNamed(
                        Routes.userRidePickup.name,
                        extra: {
                          LocationType.pickup.name: pickupController,
                          LocationType.dropoff.name: dropoffController,
                        },
                      );
                      pickupController.text = pickup?.vicinity ?? '';
                      setState(() {});
                    },
                  ),
                  dropoff: PickLocationParameters(
                    enabled: false,
                    controller: dropoffController,
                    onPresesed: () async {
                      dropoff = await context.pushNamed(
                        Routes.userRideDropoff.name,
                        extra: {
                          LocationType.pickup.name: pickupController,
                          LocationType.dropoff.name: dropoffController,
                        },
                      );
                      dropoffController.text = dropoff?.vicinity ?? '';
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<UserRideCubit, UserRideState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: Button.primary(
                  onPressed:
                      (pickup != null && dropoff != null && state.isSuccess)
                      ? () async {
                          if (pickup == null || dropoff == null) return;
                          await context.read<UserOrderCubit>().estimate(
                            pickup!,
                            dropoff!,
                          );
                          if (context.mounted) {
                            await context.pushNamed(
                              Routes.userRideSummary.name,
                            );
                          }
                        }
                      : null,
                  child: state.isLoading
                      ? const Submiting()
                      : const DefaultText('Procced'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    void navigateToDriverSearch() =>
        context.pushNamed(Routes.userDriverNearMe.name);

    return Button(
      onPressed: _mapController != null ? navigateToDriverSearch : null,
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.dg),
          child: Stack(
            children: [
              MapWrapperWidget(
                onMapCreated: (controller) {
                  _mapController = controller;
                  setState(() {});
                  _setupLocation();
                },
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                onTap: (_) => navigateToDriverSearch(),
              ),
              if (_mapController == null)
                Positioned.fill(
                  child: Container(
                    color: context.colorScheme.mutedForeground,
                  ).asSkeleton(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserRidePickupScreen extends StatefulWidget {
  const UserRidePickupScreen({super.key});

  @override
  State<UserRidePickupScreen> createState() => _UserRidePickupScreenState();
}

class _UserRidePickupScreenState extends State<UserRidePickupScreen> {
  TextEditingController? pickupController;
  TextEditingController? dropoffController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      pickupController =
          extra?[LocationType.pickup.name] as TextEditingController?;
      dropoffController =
          extra?[LocationType.dropoff.name] as TextEditingController?;

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      headers: const [
        DefaultAppBar(title: 'Where you at?'),
      ],
      body: PickLocationWidget(
        type: LocationType.pickup,
        pickupController: pickupController,
        dropoffController: dropoffController,
      ),
    );
  }
}

class UserRideDropoffScreen extends StatefulWidget {
  const UserRideDropoffScreen({super.key});

  @override
  State<UserRideDropoffScreen> createState() => _UserRideDropoffScreenState();
}

class _UserRideDropoffScreenState extends State<UserRideDropoffScreen> {
  TextEditingController? pickupController;
  TextEditingController? dropoffController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      pickupController =
          extra?[LocationType.pickup.name] as TextEditingController?;
      dropoffController =
          extra?[LocationType.dropoff.name] as TextEditingController?;

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      headers: const [
        DefaultAppBar(title: 'Where are you going?'),
      ],
      body: PickLocationWidget(
        type: LocationType.dropoff,
        pickupController: pickupController,
        dropoffController: dropoffController,
      ),
    );
  }
}
