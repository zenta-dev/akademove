import 'package:flutter/material.dart';

/// Emergency button that appears during active trips
/// Shows as a red floating action button with SOS icon
class EmergencyButton extends StatelessWidget {
  const EmergencyButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      elevation: 8,
      heroTag: 'emergency_button',
      child: const Icon(Icons.warning_rounded, size: 32),
    );
  }
}
