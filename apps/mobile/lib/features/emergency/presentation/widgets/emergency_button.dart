import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
    return FloatingActionButton(
      onPressed: () => _showEmergencyDialog(context),
      backgroundColor: const Color(0xFFDC2626), // Red 600
      foregroundColor: Colors.white,
      elevation: 8,
      heroTag: 'emergency_button',
      child: const Icon(LucideIcons.alertTriangle, size: 32),
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
