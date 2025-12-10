import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/presentation/cubits/_export.dart';
import 'package:akademove/features/emergency/presentation/cubits/_export.dart';
import 'package:akademove/features/emergency/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'emergency_trigger_dialog.dart';

/// Emergency button that appears during active trips
/// Shows as a red floating action button with alert triangle icon
class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    required this.orderId,
    required this.currentLocation,
    super.key,
  });

  final String orderId;
  final EmergencyLocation currentLocation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmergencyCubit, EmergencyState>(
      listener: (context, state) {
        if (state.triggerEmergency.isSuccess) {
          context.showMyToast(
            context.l10n.emergency_alert_sent_successfully,
            type: ToastType.success,
          );
        } else if (state.triggerEmergency.isFailure) {
          context.showMyToast(
            'Failed to send alert: ${state.triggerEmergency.error?.message ?? 'Unknown error'}',
            type: ToastType.failed,
          );
        }
      },
      child: AppFloatingActionButton(
        onPressed: () => _showEmergencyDialog(context),
        backgroundColor: const Color(0xFFDC2626), // Red 600
        foregroundColor: Colors.white,
        elevation: 8,
        heroTag: 'emergency_button',
        child: const Icon(LucideIcons.triangleAlert, size: 32),
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    // Capture cubits from parent context before showing dialog
    final emergencyCubit = context.read<EmergencyCubit>();
    final authCubit = context.read<AuthCubit>();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: emergencyCubit),
          BlocProvider.value(value: authCubit),
        ],
        child: EmergencyTriggerDialog(
          orderId: orderId,
          currentLocation: currentLocation,
        ),
      ),
    );
  }
}
