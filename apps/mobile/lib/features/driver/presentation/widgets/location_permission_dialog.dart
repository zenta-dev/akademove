import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
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

    return AlertDialog(
      title: Row(
        spacing: 12.w,
        children: [
          Icon(
            LucideIcons.mapPin,
            size: 28.sp,
            color: context.colorScheme.primary,
          ),
          Expanded(
            child: Text(
              context.l10n.title_location_permission_required,
              style: context.typography.h4.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              isPermanentlyDenied
                  ? context.l10n.text_location_permission_denied
                  : context.l10n.text_location_permission_request,
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
            if (!isPermanentlyDenied) ...[
              SizedBox(height: 8.h),
              _buildBenefitItem(
                context,
                LucideIcons.navigation,
                context.l10n.text_location_benefit_match_orders,
              ),
              _buildBenefitItem(
                context,
                LucideIcons.users,
                context.l10n.text_location_benefit_track_arrival,
              ),
              _buildBenefitItem(
                context,
                LucideIcons.shieldCheck,
                context.l10n.text_location_benefit_safety,
              ),
            ],
            if (isPermanentlyDenied) ...[
              SizedBox(height: 8.h),
              Alert.destructive(
                leading: Icon(LucideIcons.info, size: 20.sp),
                content: Text(
                  context.l10n.text_location_redirect_settings,
                  style: context.typography.small.copyWith(fontSize: 12.sp),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        OutlineButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.l10n.button_cancel),
        ),
        PrimaryButton(
          onPressed: () async {
            if (isPermanentlyDenied) {
              // Open app settings
              await Geolocator.openAppSettings();
              if (context.mounted) {
                Navigator.of(context).pop(false);
              }
            } else {
              // Request permission
              final permission = await Geolocator.requestPermission();
              final granted =
                  permission == LocationPermission.always ||
                  permission == LocationPermission.whileInUse;
              if (context.mounted) {
                Navigator.of(context).pop(granted);
              }
            }
          },
          child: Text(
            isPermanentlyDenied
                ? context.l10n.button_open_settings
                : context.l10n.button_grant_permission,
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
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        LocationPermissionDialog(permissionStatus: permissionStatus),
  );

  return result ?? false;
}
