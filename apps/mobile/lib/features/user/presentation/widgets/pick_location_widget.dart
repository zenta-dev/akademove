import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum LocationType {
  pickup,
  dropoff;

  bool get isPickup => this == LocationType.pickup;
  bool get isDropoff => this == LocationType.dropoff;
}

class PickLocationWidget extends StatefulWidget {
  const PickLocationWidget({
    required this.type,
    super.key,
    this.pickupController,
    this.dropoffController,
  });
  final LocationType type;
  final TextEditingController? pickupController;
  final TextEditingController? dropoffController;

  @override
  State<PickLocationWidget> createState() => _PickLocationWidgetState();
}

class _PickLocationWidgetState extends State<PickLocationWidget> {
  late Debouncer searchDebouncer;
  late TextEditingController pickupController;
  late TextEditingController dropoffController;
  late ScrollController scrollController;

  late GlobalKey<RefreshTriggerState> refreshTriggerKey;

  @override
  void initState() {
    super.initState();
    searchDebouncer = Debouncer(milliseconds: 500);
    pickupController = widget.pickupController ?? TextEditingController();
    dropoffController = widget.dropoffController ?? TextEditingController();
    scrollController = ScrollController()..addListener(_onScroll);
    refreshTriggerKey = GlobalKey<RefreshTriggerState>();
  }

  @override
  void dispose() {
    searchDebouncer.dispose();
    if (widget.pickupController == null) pickupController.dispose();
    if (widget.dropoffController == null) dropoffController.dispose();
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    refreshTriggerKey.currentState?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final cubit = context.read<UserRideCubit>();
      final state = cubit.state;

      if (pickupController.text.isNotEmpty ||
          dropoffController.text.isNotEmpty) {
        if (state.searchPlaces.token != null) {
          cubit.searchPlaces(
            (widget.type.isPickup ? pickupController : dropoffController).text,
          );
        }
      } else {
        if (state.nearbyPlaces.token != null && state.coordinate != null) {
          cubit.getNearbyPlaces(state.coordinate!);
        }
      }
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PickLocationCardWidget(
          padding: EdgeInsets.all(8.dg),
          pickup: PickLocationParameters(
            enabled: widget.type.isPickup,
            controller: pickupController,
            onChanged: (value) => searchDebouncer.run(
              () async {
                final cubit = context.read<UserRideCubit>();
                if (value.isEmpty) {
                  return cubit.clearSearchPlaces();
                }
                return cubit.searchPlaces(value);
              },
            ),
          ),
          dropoff: PickLocationParameters(
            enabled: widget.type.isDropoff,
            controller: dropoffController,
            onChanged: (value) => searchDebouncer.run(
              () async {
                final cubit = context.read<UserRideCubit>();
                if (value.isEmpty) {
                  return cubit.clearSearchPlaces();
                }
                return cubit.searchPlaces(value);
              },
            ),
          ),
        ),
        Button(
          style: const ButtonStyle.secondary(density: ButtonDensity.dense),
          onPressed: () {},
          child: Row(
            spacing: 4.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.map, size: 16.sp),
              DefaultText(
                'Select via map',
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<UserRideCubit, UserRideState>(
            builder: (context, state) {
              if (state.isLoading) {
                return ListPlacesWidget(
                  places: List.generate(5, (_) => dummyPlace),
                  hasMore: false,
                  isLoading: true,
                ).asSkeleton();
              }
              final isSearchMode =
                  (widget.type.isPickup ? pickupController : dropoffController)
                      .text
                      .isNotEmpty;
              final places = isSearchMode
                  ? state.searchPlaces.data
                  : state.nearbyPlaces.data;
              final hasMore = isSearchMode
                  ? state.searchPlaces.token != null
                  : state.nearbyPlaces.token != null;

              return RefreshTrigger(
                key: refreshTriggerKey,
                onRefresh: () async {
                  final cubit = context.read<UserRideCubit>();
                  if (isSearchMode) {
                    await cubit.searchPlaces(
                      (widget.type.isPickup
                              ? pickupController
                              : dropoffController)
                          .text,
                      isRefresh: true,
                    );
                  } else if (state.coordinate != null) {
                    await cubit.getNearbyPlaces(
                      state.coordinate!,
                      isRefresh: true,
                    );
                  }
                },
                child: ListPlacesWidget(
                  scrollController: scrollController,
                  places: places,
                  hasMore: hasMore,
                  isLoading: false,
                  onItemTap: context.pop,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
