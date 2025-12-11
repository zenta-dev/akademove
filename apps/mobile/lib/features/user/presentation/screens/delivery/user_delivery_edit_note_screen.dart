import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart' show TextInputAction;
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
  static const _nameKey = TextFieldKey('name');
  static const _phoneKey = TextFieldKey('phone');
  static const _insKey = TextFieldKey('ins');

  late FocusNode _nameFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _insFocusNode;

  OrderNote _note = OrderNote();
  GoogleMapController? _mapController;

  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _note = widget.initialNote;
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _insFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mapController?.dispose();

    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _insFocusNode.dispose();
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
        spacing: 16.h,
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
          Form(
            onSubmit: (context, values) async {
              if (_submitting) return;
              _submitting = true;

              final name = _nameKey[values];
              final phone = _phoneKey[values];
              final ins = _insKey[values];

              setState(() {
                if (widget.isPickup) {
                  _note = _note.copyWith(
                    senderName: name,
                    senderPhone: phone,
                    pickup: ins,
                  );
                } else {
                  _note = _note.copyWith(
                    recevierName: name,
                    recevierPhone: phone,
                    dropoff: ins,
                  );
                }
              });

              final valid = await context.submitForm();

              if (valid.errors.isEmpty && context.mounted) {
                context.pop(_note);
              }

              _submitting = false;
            },
            child: Column(
              spacing: 16.h,
              children: [
                FormField(
                  key: _nameKey,
                  label: DefaultText(
                    context.l10n.name,
                    fontWeight: FontWeight.w500,
                  ),
                  validator: LengthValidator(min: 5),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    initialValue: widget.isPickup
                        ? widget.initialNote.senderName
                        : widget.initialNote.recevierName,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                FormField(
                  key: _phoneKey,
                  label: DefaultText(
                    context.l10n.phone,
                    fontWeight: FontWeight.w500,
                  ),
                  validator: LengthValidator(min: 10),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    initialValue: widget.isPickup
                        ? widget.initialNote.senderPhone
                        : widget.initialNote.recevierPhone,
                    focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                FormField(
                  key: _insKey,
                  label: DefaultText(
                    "Notes & Instructions",
                    fontWeight: FontWeight.w500,
                  ),
                  validator: NotEmptyValidator(),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextArea(
                    initialValue: widget.isPickup
                        ? widget.initialNote.pickup
                        : widget.initialNote.dropoff,
                    focusNode: _insFocusNode,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FormErrorBuilder(
                    builder: (context, errors, child) {
                      return Button(
                        style: _submitting
                            ? const ButtonStyle.ghost()
                            : const ButtonStyle.primary(),
                        onPressed: _submitting
                            ? null
                            : () {
                                context.submitForm();
                                setState(() {
                                  _submitting = true;
                                });
                              },
                        child: _submitting
                            ? Submiting()
                            : DefaultText(
                                context.l10n.confirm,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                      );
                    },
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
