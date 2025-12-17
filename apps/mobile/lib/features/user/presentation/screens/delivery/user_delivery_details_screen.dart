import 'dart:io';

import 'package:akademove/app/router/router.dart';
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
  File? _itemPhotoFile;

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
    return Scaffold(
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              if (state.estimateOrder.isSuccess &&
                  state.estimateOrder.hasData) {
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
                  // Item Photo Section (Required)
                  _DeliveryItemPhotoWidget(
                    photoFile: _itemPhotoFile,
                    onPhotoSelected: (file) {
                      setState(() => _itemPhotoFile = file);
                    },
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
                          ).asSkeleton(
                            enabled: state.routeCoordinates.isLoading,
                          );
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

                              // Validate item photo is uploaded (required for DELIVERY orders)
                              final orderLocationCubit = context
                                  .read<OrderLocationCubit>();
                              if (orderLocationCubit.deliveryItemPhotoUrl ==
                                  null) {
                                context.showMyToast(
                                  "Please upload a photo of the item",
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
                              // Store delivery details in OrderLocationCubit for payment screen
                              orderLocationCubit.setDeliveryNote(note);
                              orderLocationCubit.setDeliveryItemType(
                                selectedItemType,
                              );

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
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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

/// Widget for selecting and uploading delivery item photo
/// Required before placing a delivery order
class _DeliveryItemPhotoWidget extends StatelessWidget {
  const _DeliveryItemPhotoWidget({
    required this.photoFile,
    required this.onPhotoSelected,
  });

  final File? photoFile;
  final void Function(File? file) onPhotoSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderLocationCubit, OrderLocationState>(
      listenWhen: (previous, current) =>
          previous.uploadDeliveryItemPhoto != current.uploadDeliveryItemPhoto,
      listener: (context, state) {
        if (state.uploadDeliveryItemPhoto.isSuccess) {
          context.showMyToast(context.l10n.uploaded, type: ToastType.success);
        } else if (state.uploadDeliveryItemPhoto.isFailure) {
          context.showMyToast(
            state.uploadDeliveryItemPhoto.error?.message ??
                context.l10n.an_error_occurred,
            type: ToastType.failed,
          );
        }
      },
      builder: (context, locationState) {
        final isUploading = locationState.uploadDeliveryItemPhoto.isLoading;
        final isUploaded = locationState.uploadDeliveryItemPhoto.isSuccess;
        final uploadedUrl = locationState.uploadDeliveryItemPhoto.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            // Header row
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.camera,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  'Item Photo',
                  style: context.typography.small.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '*',
                  style: context.typography.small.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.destructive,
                  ),
                ),
              ],
            ),
            // Description
            Text(
              'Take a photo of the item to be delivered',
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            // Photo picker / preview
            if (photoFile != null)
              _PhotoPreview(
                photoFile: photoFile!,
                isUploading: isUploading,
                isUploaded: isUploaded,
                onRemove: () {
                  onPhotoSelected(null);
                  context.read<OrderLocationCubit>().clearDeliveryItemPhoto();
                },
                onRetryUpload: () {
                  context.read<OrderLocationCubit>().uploadDeliveryItemPhoto(
                    photoFile!.path,
                  );
                },
              )
            else
              _PhotoPickerButtons(
                onPhotoSelected: (file) async {
                  onPhotoSelected(file);
                  // Automatically upload when photo is selected
                  await context
                      .read<OrderLocationCubit>()
                      .uploadDeliveryItemPhoto(file.path);
                },
              ),
            // Upload status indicator
            if (isUploaded && uploadedUrl != null)
              Row(
                spacing: 4.w,
                children: [
                  Icon(LucideIcons.check, size: 14.sp, color: Colors.green),
                  Text(
                    context.l10n.uploaded,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

/// Photo preview with upload status
class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({
    required this.photoFile,
    required this.isUploading,
    required this.isUploaded,
    required this.onRemove,
    required this.onRetryUpload,
  });

  final File photoFile;
  final bool isUploading;
  final bool isUploaded;
  final VoidCallback onRemove;
  final VoidCallback onRetryUpload;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            photoFile,
            width: double.infinity,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
        // Overlay when uploading
        if (isUploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.h,
                  children: [
                    const CircularProgressIndicator(
                      size: 24,
                      color: Colors.white,
                    ),
                    Text(
                      context.l10n.attachment_uploading,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // Remove button (top right)
        if (!isUploading)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(6.dg),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.x, size: 16.sp, color: Colors.white),
              ),
            ),
          ),
        // Retry button if upload failed
        if (!isUploading && !isUploaded)
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRetryUpload,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.w,
                  children: [
                    Icon(
                      LucideIcons.refreshCw,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    Text(
                      context.l10n.retry,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Buttons to pick photo from camera or gallery
class _PhotoPickerButtons extends StatelessWidget {
  const _PhotoPickerButtons({required this.onPhotoSelected});

  final void Function(File file) onPhotoSelected;

  Future<void> _pickImage(BuildContext context, bool fromCamera) async {
    try {
      final imageService = sl<ImageService>();
      final file = fromCamera
          ? await imageService.pickFromCamera()
          : await imageService.pickFromGallery();

      onPhotoSelected(file);
    } catch (e, st) {
      logger.e(
        '[_PhotoPickerButtons] - Error picking image: $e',
        error: e,
        stackTrace: st,
      );
      if (context.mounted) {
        context.showMyToast(
          context.l10n.error_photo_pick_failed,
          type: ToastType.failed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.border,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: context.isDarkMode
            ? Colors.neutral.shade900
            : Colors.neutral.shade50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24.w,
        children: [
          _PickerButton(
            icon: LucideIcons.camera,
            label: context.l10n.action_take_photo,
            onTap: () => _pickImage(context, true),
          ),
          _PickerButton(
            icon: LucideIcons.image,
            label: context.l10n.action_choose_gallery,
            onTap: () => _pickImage(context, false),
          ),
        ],
      ),
    );
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.h,
        children: [
          Container(
            padding: EdgeInsets.all(12.dg),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24.sp, color: context.colorScheme.primary),
          ),
          Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
