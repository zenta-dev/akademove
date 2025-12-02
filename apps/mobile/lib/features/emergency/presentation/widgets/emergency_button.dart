import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/presentation/cubits/_export.dart';
import 'package:akademove/features/emergency/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        if (state.state == CubitState.success && state.triggered != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Emergency alert sent successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        } else if (state.state == CubitState.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to send alert: ${state.message ?? 'Unknown error'}',
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child: FloatingActionButton(
        onPressed: () => _showEmergencyDialog(context),
        backgroundColor: const Color(0xFFDC2626), // Red 600
        foregroundColor: Colors.white,
        elevation: 8,
        heroTag: 'button',
        child: const Icon(Icons.warning_rounded, size: 32),
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => EmergencyTriggerDialog(
        orderId: orderId,
        currentLocation: currentLocation,
      ),
    );
  }
}
