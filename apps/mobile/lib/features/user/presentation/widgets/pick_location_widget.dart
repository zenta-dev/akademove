import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
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
    refresh();
  }

  @override
  void dispose() {
    searchDebouncer.dispose();
    if (widget.pickupController == null) pickupController.dispose();
    if (widget.dropoffController == null) dropoffController.dispose();
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    // Note: Do not call dispose() on GlobalKey's currentState
    // The widget framework handles disposal of the state automatically
    super.dispose();
  }

  Future<void> refresh() async {
    final cubit = context.read<UserRideCubit>();
    final coord = context.read<UserLocationCubit>().state.coordinate;
    final isSearchMode =
        (widget.type.isPickup ? pickupController : dropoffController)
            .text
            .isNotEmpty;

    if (isSearchMode) {
      await cubit.searchPlaces(
        (widget.type.isPickup ? pickupController : dropoffController).text,
        isRefresh: true,
        coordinate: coord,
      );
    } else if (coord != null) {
      await cubit.getNearbyPlaces(coord, isRefresh: true);
    }
  }

  Future<void> _onScroll() async {
    if (_isBottom) {
      final cubit = context.read<UserRideCubit>();
      final state = cubit.state;
      if (pickupController.text.isNotEmpty ||
          dropoffController.text.isNotEmpty) {
        if (state.searchPlaces.value?.token != null) {
          final coord = context.read<UserLocationCubit>().state.coordinate;
          await cubit.searchPlaces(
            (widget.type.isPickup ? pickupController : dropoffController).text,
            coordinate: coord,
          );
        }
      } else {
        final coord = context.read<UserLocationCubit>().state.coordinate;
        if (state.nearbyPlaces.value?.token != null && coord != null) {
          await cubit.getNearbyPlaces(coord);
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
            onChanged: (value) => searchDebouncer.run(() async {
              final cubit = context.read<UserRideCubit>();
              if (value.isEmpty) {
                return cubit.clearSearchPlaces();
              }
              final coord = context.read<UserLocationCubit>().state.coordinate;
              return cubit.searchPlaces(value, coordinate: coord);
            }),
          ),
          dropoff: PickLocationParameters(
            enabled: widget.type.isDropoff,
            controller: dropoffController,
            onChanged: (value) => searchDebouncer.run(() async {
              final cubit = context.read<UserRideCubit>();
              if (value.isEmpty) {
                return cubit.clearSearchPlaces();
              }
              final coord = context.read<UserLocationCubit>().state.coordinate;
              return cubit.searchPlaces(value, coordinate: coord);
            }),
          ),
        ),
        Button(
          style: const ButtonStyle.secondary(density: ButtonDensity.dense),
          onPressed: () async {
            final coord = context.read<UserLocationCubit>().state.coordinate;
            final result = await context.pushNamed<Place>(
              Routes.userMapPicker.name,
              extra: {'locationType': widget.type, 'initialLocation': coord},
            );
            if (result != null && context.mounted) {
              context.pop(result);
            }
          },
          child: Row(
            spacing: 4.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.map, size: 16.sp),
              DefaultText(
                context.l10n.text_select_via_map,
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ],
          ),
        ),
        BlocBuilder<UserRideCubit, UserRideState>(
          builder: (context, state) {
            if (state.searchPlaces.isLoading) {
              return Expanded(
                child: ListPlacesWidget(
                  places: List.generate(10, (_) => dummyPlace),
                  hasMore: false,
                  isLoading: true,
                ).asSkeleton(),
              );
            }
            final isSearchMode =
                (widget.type.isPickup ? pickupController : dropoffController)
                    .text
                    .isNotEmpty;
            final places = isSearchMode
                ? state.searchPlaces.value?.data ?? []
                : state.nearbyPlaces.value?.data ?? [];

            if (places.isEmpty && !state.searchPlaces.isLoading) {
              return SizedBox(
                width: double.infinity,
                child: Alert.destructive(
                  content: Text(context.l10n.text_no_place_found),
                  leading: const Icon(LucideIcons.info),
                  trailing: IconButton(
                    icon: const Icon(LucideIcons.refreshCcw),
                    variance: const ButtonStyle.ghost(),
                    onPressed: refresh,
                  ),
                ),
              );
            }

            final hasMore = isSearchMode
                ? state.searchPlaces.value?.token != null
                : state.nearbyPlaces.value?.token != null;

            return Expanded(
              child: RefreshTrigger(
                key: refreshTriggerKey,
                onRefresh: refresh,
                child: ListPlacesWidget(
                  scrollController: scrollController,
                  places: places,
                  hasMore: hasMore,
                  isLoading: false,
                  onItemTap: context.pop,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
