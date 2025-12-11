import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryDetailsScreen extends StatefulWidget {
  const UserDeliveryDetailsScreen({super.key});

  @override
  State<UserDeliveryDetailsScreen> createState() =>
      _UserDeliveryDetailsScreenState();
}

class _UserDeliveryDetailsScreenState extends State<UserDeliveryDetailsScreen> {
  WeightSize? selectedWeightSize;
  DeliveryItemType selectedItemType = DeliveryItemType.OTHER;
  GoogleMapController? _mapController;

  OrderNote note = OrderNote();

  @override
  void initState() {
    super.initState();
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

  bool isWeightSelected(WeightSize size) => selectedWeightSize == size;
  bool isTypeSelected(DeliveryItemType type) => selectedItemType == type;

  void handleWeightDrawer() {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.dg),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.h,
              children: [
                Text(
                  context.l10n.choose_your_items_size,
                  style: context.typography.small.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ...WeightSize.values.map(
                  (preset) => OutlineButton(
                    onPressed: () {
                      setState(() {
                        selectedWeightSize = preset;
                      });
                      closeDrawer(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          preset.localizedName(context),
                          style: context.typography.small.copyWith(
                            fontSize: 16.sp,
                            color: isWeightSelected(preset)
                                ? context.colorScheme.foreground
                                : context.colorScheme.mutedForeground,
                          ),
                        ),
                        Text(
                          '${context.l10n.max} ${preset.maxWeight.toStringAsFixed(0)} kg',
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            color: isWeightSelected(preset)
                                ? context.colorScheme.foreground
                                : context.colorScheme.mutedForeground,
                          ),
                        ),
                        Radio(value: isWeightSelected(preset)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      position: OverlayPosition.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.title_delivery_details,
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
      body: BlocConsumer<UserOrderCubit, UserOrderState>(
        listener: (context, state) {
          if (state.estimateOrder.isSuccess && state.estimateOrder.hasData) {
            context.popUntilRoot();
            context.pushNamed(Routes.userDeliverySummary.name);
          }
        },
        builder: (context, state) {
          return Column(
            spacing: 16.h,
            children: [
              BlocBuilder<UserOrderCubit, UserOrderState>(
                builder: (context, state) {
                  final pickup = state.pickupLocation;
                  final dropoff = state.dropoffLocation;
                  if (pickup == null || dropoff == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      _LocationCardWidget(
                        place: pickup,
                        note: note,
                        isPickup: true,
                        onChanged: (value) {
                          setState(() {
                            note = value;
                          });
                        },
                      ),
                      _LocationCardWidget(
                        place: dropoff,
                        note: note,
                        isPickup: false,
                        onChanged: (value) {
                          setState(() {
                            note = value;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Icon(
                        LucideIcons.weight,
                        size: 20.sp,
                        color: context.colorScheme.primary,
                      ),
                      Text(
                        context.l10n.total_weight,
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  GhostButton(
                    onPressed: handleWeightDrawer,
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Text(
                          selectedWeightSize != null
                              ? WeightSize.values
                                    .firstWhere(
                                      (element) =>
                                          element == selectedWeightSize,
                                    )
                                    .localizedName(context)
                              : context.l10n.choose,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: selectedWeightSize != null
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: selectedWeightSize != null
                                ? context.colorScheme.foreground
                                : context.colorScheme.mutedForeground,
                          ),
                        ),
                        Icon(
                          LucideIcons.chevronDown,
                          size: 16.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8.w,
                children: [
                  Icon(
                    LucideIcons.package,
                    size: 20.sp,
                    color: context.colorScheme.primary,
                  ),
                  Text(
                    context.l10n.choose_item_type,
                    style: context.typography.small.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 4.w,
                runSpacing: 8.h,
                children: DeliveryItemType.values.map((itemType) {
                  return Chip(
                    onPressed: () => setState(() {
                      selectedItemType = itemType;
                    }),
                    style: isTypeSelected(itemType)
                        ? ButtonStyle.primary()
                        : ButtonStyle.outline(),
                    child: Padding(
                      padding: EdgeInsets.all(4.dg),
                      child: Text(
                        itemType.localizedName(context),
                        style: context.typography.small.copyWith(
                          fontSize: 14.sp,
                          color: selectedItemType == itemType
                              ? Colors.white
                              : context.colorScheme.foreground,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.w,
                children: [
                  Text(
                    context.l10n.total_delivery_distance,
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  BlocConsumer<UserMapCubit, UserMapState>(
                    listener: (context, state) {
                      if (state.routeCoordinates.isSuccess &&
                          state.routeCoordinates.value != null) {}
                    },
                    builder: (context, state) {
                      return Text(
                        '${state.routeInfo.value?.km.toStringAsFixed(1) ?? '-'} km',
                        style: context.typography.small.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ).asSkeleton(enabled: state.routeInfo.isLoading);
                    },
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 150.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: BlocBuilder<UserMapCubit, UserMapState>(
                    builder: (context, state) {
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
                      ).asSkeleton(enabled: state.routeCoordinates.isLoading);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Button.primary(
                  enabled: !state.estimateOrder.isLoading,
                  onPressed: state.estimateOrder.isLoading
                      ? null
                      : () {
                          if (selectedWeightSize == null) {
                            context.showMyToast(
                              "Please select a weight size",
                              type: ToastType.failed,
                            );
                            return;
                          }

                          final orderState = context
                              .read<UserOrderCubit>()
                              .state;
                          final pickup = orderState.pickupLocation;
                          final dropoff = orderState.dropoffLocation;
                          if (pickup == null || dropoff == null) {
                            context.showMyToast(
                              "Pickup and dropoff locations are required",
                            );
                            return;
                          }
                          context.read<UserOrderCubit>().estimate(
                            req: EstimateOrder(
                              pickupLocation: Coordinate(
                                x: pickup.lng,
                                y: pickup.lat,
                              ),
                              dropoffLocation: Coordinate(
                                x: dropoff.lng,
                                y: dropoff.lat,
                              ),
                              type: OrderType.DELIVERY,
                              note: note,
                              weight: selectedWeightSize?.maxWeight,
                            ),
                            pickup: pickup,
                            dropoff: dropoff,
                          );
                        },
                  child: state.estimateOrder.isLoading
                      ? const Submiting()
                      : Text(
                          context.l10n.continue_text,
                          style: context.typography.small.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LocationCardWidget extends StatelessWidget {
  const _LocationCardWidget({
    required this.place,
    required this.note,
    required this.isPickup,
    required this.onChanged,
  });
  final Place place;
  final OrderNote note;
  final bool isPickup;
  final Function(OrderNote value) onChanged;

  @override
  Widget build(BuildContext context) {
    void navigateToEdit() async {
      final result = await context.pushNamed<OrderNote>(
        Routes.userDeliveryDetailsEditDetail.name,
        extra: {'initialNote': note, 'place': place, 'isPickup': isPickup},
      );
      if (result != null) onChanged(result);
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Basic(
          leading: Icon(
            LucideIcons.mapPin,
            size: 20.sp,
            color: context.colorScheme.primary,
          ),
          title: Text(
            place.name,
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  place.vicinity,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Center(
                  child: LinkButton(
                    onPressed: navigateToEdit,
                    child: Text(
                      context.l10n.add_delivery_detail,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            density: ButtonDensity.compact,
            onPressed: navigateToEdit,
            icon: Icon(
              LucideIcons.chevronRight,
              size: 16.sp,
              color: context.colorScheme.mutedForeground,
            ),
            variance: const ButtonStyle.ghost(),
          ),
          trailingAlignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
