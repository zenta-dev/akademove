import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryPickupScreen extends StatefulWidget {
  const UserDeliveryPickupScreen({super.key});

  @override
  State<UserDeliveryPickupScreen> createState() =>
      _UserDeliveryPickupScreenState();
}

class _UserDeliveryPickupScreenState extends State<UserDeliveryPickupScreen> {
  late TextEditingController pickupController;
  late TextEditingController dropoffController;

  @override
  void initState() {
    super.initState();
    pickupController = TextEditingController();
    dropoffController = TextEditingController();
  }

  @override
  void dispose() {
    pickupController.dispose();
    dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserDeliveryCubit>(),
      child: BlocListener<UserDeliveryCubit, UserDeliveryState>(
        listener: (context, state) {
          if (state.isFailure) {
            context.showMyToast(
              state.error?.message ?? 'Failed to load places',
              type: ToastType.failed,
            );
          }
        },
        child: MyScaffold(
          scrollable: false,
          headers: [
            AppBar(
              padding: EdgeInsets.all(4.dg),
              title: Text(
                'Select Pickup Location',
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
          body: PickLocationWidget(
            type: LocationType.pickup,
            pickupController: pickupController,
            dropoffController: dropoffController,
          ),
        ),
      ),
    );
  }
}
