import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Dialog for triggering an emergency during active trip
/// Redirects user to WhatsApp emergency contact
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
  @override
  void initState() {
    super.initState();
    // Fetch primary contact on dialog open
    context.read<SharedEmergencyCubit>().getPrimaryContact();
  }

  /// Opens WhatsApp with pre-filled emergency message
  Future<void> _openEmergencyWhatsApp(String phone) async {
    final cubit = context.read<SharedEmergencyCubit>();

    // Log emergency event before opening WhatsApp
    await cubit.logEmergency(
      orderId: widget.orderId,
      location: widget.currentLocation,
    );

    // Sanitize phone number for WhatsApp (remove +, spaces, dashes)
    final sanitizedPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    final message = Uri.encodeComponent(
      'EMERGENCY - Order ID: ${widget.orderId}\n'
      'Location: ${widget.currentLocation.latitude}, ${widget.currentLocation.longitude}\n'
      'I need immediate assistance!',
    );

    // Try WhatsApp URL scheme first, then fallback to web URL
    final whatsappUrl = Uri.parse(
      'whatsapp://send?phone=$sanitizedPhone&text=$message',
    );
    final webUrl = Uri.parse('https://wa.me/$sanitizedPhone?text=$message');

    try {
      // Try native WhatsApp app first
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
      // Fallback to web URL
      else if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (context.mounted && mounted) {
          context.showMyToast(
            context.l10n.emergency_whatsapp_error,
            type: ToastType.failed,
          );
        }
      }
    } catch (e) {
      if (context.mounted && mounted) {
        context.showMyToast(
          context.l10n.emergency_whatsapp_error,
          type: ToastType.failed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedEmergencyCubit, SharedEmergencyState>(
      builder: (context, state) {
        final primaryContactResult = state.primaryContact;

        return AlertDialog(
          title: Row(
            spacing: 12.w,
            children: [
              Icon(
                LucideIcons.triangleAlert,
                color: context.colorScheme.destructive,
                size: 28.sp,
              ),
              Text(context.l10n.emergency_alert_title),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.message_confirmation,
                  style: context.typography.p.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                // Show loading state while fetching contact
                if (primaryContactResult.isLoading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.dg),
                      child: const CircularProgressIndicator(),
                    ),
                  )
                // Show error state if fetch failed
                else if (primaryContactResult.isFailed)
                  Card(
                    padding: EdgeInsets.all(12.dg),
                    borderColor: context.colorScheme.destructive,
                    child: Column(
                      children: [
                        Icon(
                          LucideIcons.circleAlert,
                          color: context.colorScheme.destructive,
                          size: 24.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.l10n.emergency_contact_unavailable,
                          textAlign: TextAlign.center,
                          style: context.typography.base.copyWith(
                            color: context.colorScheme.destructive,
                          ),
                        ),
                      ],
                    ),
                  )
                // Show no contact available
                else if (primaryContactResult.isSuccess &&
                    primaryContactResult.value == null)
                  Card(
                    padding: EdgeInsets.all(12.dg),
                    borderColor: context.colorScheme.mutedForeground,
                    child: Column(
                      children: [
                        Icon(
                          LucideIcons.circleAlert,
                          color: context.colorScheme.mutedForeground,
                          size: 24.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.l10n.emergency_contact_unavailable,
                          textAlign: TextAlign.center,
                          style: context.typography.base.copyWith(
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  )
                // Show WhatsApp contact card
                else if (primaryContactResult.isSuccess &&
                    primaryContactResult.value != null)
                  _buildWhatsAppCard(primaryContactResult.value!),
              ],
            ),
          ),
          actions: [
            OutlineButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.cancel),
            ),
            if (primaryContactResult.isSuccess &&
                primaryContactResult.value != null)
              PrimaryButton(
                onPressed: () =>
                    _openEmergencyWhatsApp(primaryContactResult.value!.phone),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: [
                    Icon(
                      LucideIcons.messageCircle,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                    Text(
                      context.l10n.emergency_contact_whatsapp,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildWhatsAppCard(EmergencyContact contact) {
    return GestureDetector(
      onTap: () => _openEmergencyWhatsApp(contact.phone),
      child: Card(
        padding: EdgeInsets.all(12.dg),
        borderWidth: 2,
        borderColor: const Color(0xFF25D366), // WhatsApp green
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.messageCircle,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: context.typography.semiBold.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF25D366),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    context.l10n.emergency_contact_whatsapp_desc,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.externalLink,
              size: 18.sp,
              color: const Color(0xFF25D366),
            ),
          ],
        ),
      ),
    );
  }
}
