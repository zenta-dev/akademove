import 'package:akademove/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:akademove/features/emergency/presentation/cubits/emergency_cubit.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dialog for triggering an emergency during active trip
/// Allows user/driver to select emergency type and provide description
class EmergencyTriggerDialog extends StatefulWidget {
  const EmergencyTriggerDialog({
    required this.orderId,
    required this.currentLocation,
    super.key,
  });

  final String orderId;
  final EmergencyLocation currentLocation;

  @override
  State<EmergencyTriggerDialog> createState() => _EmergencyTriggerDialogState();
}

class _EmergencyTriggerDialogState extends State<EmergencyTriggerDialog> {
  EmergencyType _selectedType = EmergencyType.OTHER;
  final _descriptionController = TextEditingController();
  bool _confirmed = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _getTypeLabel(EmergencyType type) {
    switch (type) {
      case EmergencyType.ACCIDENT:
        return 'Accident';
      case EmergencyType.HARASSMENT:
        return 'Harassment';
      case EmergencyType.THEFT:
        return 'Theft';
      case EmergencyType.MEDICAL:
        return 'Medical Emergency';
      case EmergencyType.OTHER:
        return 'Other';
    }
  }

  IconData _getTypeIcon(EmergencyType type) {
    switch (type) {
      case EmergencyType.ACCIDENT:
        return Icons.car_crash_rounded;
      case EmergencyType.HARASSMENT:
        return Icons.person_off_rounded;
      case EmergencyType.THEFT:
        return Icons.report_problem_rounded;
      case EmergencyType.MEDICAL:
        return Icons.medical_services_rounded;
      case EmergencyType.OTHER:
        return Icons.warning_amber_rounded;
    }
  }

  void _handleTrigger() {
    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a description'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cubit = context.read<EmergencyCubit>();
    final userId = context.read<AuthCubit>().state.data?.id;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not authenticated'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    cubit.trigger(
      orderId: widget.orderId,
      userId: userId,
      type: _selectedType,
      description: _descriptionController.text.trim(),
      location: widget.currentLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_confirmed) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 28),
            SizedBox(width: 12),
            Text('Emergency Alert'),
          ],
        ),
        content: const Text(
          'This will send an emergency alert to campus authorities and '
          'notify emergency contacts. Are you sure you want to continue?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _confirmed = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Continue'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: const Text('Report Emergency'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select emergency type:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            // Emergency type selector
            ...EmergencyType.values.map((type) {
              final isSelected = _selectedType == type;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedType = type;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getTypeIcon(type),
                          color: isSelected ? Colors.red : Colors.grey.shade700,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _getTypeLabel(type),
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected ? Colors.red : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Describe the emergency situation...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
              maxLines: 4,
              maxLength: 500,
              autofocus: false,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _handleTrigger,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Send Alert'),
        ),
      ],
    );
  }
}
