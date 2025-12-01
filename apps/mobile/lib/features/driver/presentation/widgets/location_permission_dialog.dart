import 'package:akademove/core/_export.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({required this.permissionStatus, super.key});

  final LocationPermission permissionStatus;

  @override
  Widget build(BuildContext context) {
    final isPermanentlyDenied =
        permissionStatus == LocationPermission.deniedForever;

    return material.AlertDialog(
      shape: material.RoundedRectangleBorder(
        borderRadius: material.BorderRadius.circular(12.r),
      ),
      title: Row(
        children: [
          Icon(
            LucideIcons.mapPin,
            size: 28.sp,
            color: context.colorScheme.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Location Permission Required',
              style: context.typography.h4.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: material.SingleChildScrollView(
        child: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            Text(
              isPermanentlyDenied
                  ? 'Location permission was previously denied. To go online and accept orders, you need to enable location access in your device settings.'
                  : 'To accept ride and delivery orders, drivers must share their location in real-time. This helps:',
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
            if (!isPermanentlyDenied) ...[
              SizedBox(height: 16.h),
              _buildBenefitItem(
                context,
                LucideIcons.navigation,
                'Match you with nearby orders',
              ),
              SizedBox(height: 8.h),
              _buildBenefitItem(
                context,
                LucideIcons.users,
                'Let customers track your arrival',
              ),
              SizedBox(height: 8.h),
              _buildBenefitItem(
                context,
                LucideIcons.shieldCheck,
                'Ensure safety and accountability',
              ),
            ],
            if (isPermanentlyDenied) ...[
              SizedBox(height: 16.h),
              material.Container(
                padding: EdgeInsets.all(12.dg),
                decoration: material.BoxDecoration(
                  color: context.colorScheme.destructive.withValues(alpha: 0.1),
                  borderRadius: material.BorderRadius.circular(8.r),
                  border: material.Border.all(
                    color: context.colorScheme.destructive.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 20.sp,
                      color: context.colorScheme.destructive,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'You will be redirected to app settings to enable location access.',
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        material.TextButton(
          onPressed: () => material.Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        material.ElevatedButton(
          onPressed: () async {
            if (isPermanentlyDenied) {
              // Open app settings
              await Geolocator.openAppSettings();
              if (context.mounted) {
                material.Navigator.of(context).pop(false);
              }
            } else {
              // Request permission
              final permission = await Geolocator.requestPermission();
              final granted =
                  permission == LocationPermission.always ||
                  permission == LocationPermission.whileInUse;
              if (context.mounted) {
                material.Navigator.of(context).pop(granted);
              }
            }
          },
          style: material.ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.primaryForeground,
          ),
          child: Text(
            isPermanentlyDenied ? 'Open Settings' : 'Grant Permission',
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: context.colorScheme.primary.withValues(alpha: 0.7),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: context.typography.p.copyWith(
              fontSize: 13.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// Shows location permission dialog
/// Returns true if permission was granted, false otherwise
Future<bool> showLocationPermissionDialog(
  BuildContext context,
  LocationPermission permissionStatus,
) async {
  final result = await material.showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        LocationPermissionDialog(permissionStatus: permissionStatus),
  );

  return result ?? false;
}
