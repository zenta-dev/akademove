import "package:akademove/core/_export.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A widget that displays delivery-related information including
/// proof of delivery images, item photos, OTP status, and delivery notes.
class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    // Only show for DELIVERY orders or when there's delivery-specific data
    final hasDeliveryInfo =
        order.type == OrderType.DELIVERY ||
        order.proofOfDeliveryUrl != null ||
        order.deliveryItemPhotoUrl != null ||
        order.deliveryOtp != null ||
        order.deliveryItemType != null;

    if (!hasDeliveryInfo) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Information",
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16.h),

            // Delivery Item Type
            if (order.deliveryItemType != null) ...[
              _InfoRow(
                icon: LucideIcons.package,
                label: "Item Type",
                value: _formatDeliveryItemType(order.deliveryItemType!),
              ),
              Gap(12.h),
            ],

            // Sender Information
            if (order.note?.senderName != null ||
                order.note?.senderPhone != null) ...[
              _SectionHeader(title: "Sender"),
              Gap(8.h),
              if (order.note?.senderName != null)
                _InfoRow(
                  icon: LucideIcons.user,
                  label: "Name",
                  value: order.note!.senderName!,
                ),
              if (order.note?.senderPhone != null) ...[
                Gap(8.h),
                _InfoRow(
                  icon: LucideIcons.phone,
                  label: "Phone",
                  value: order.note!.senderPhone!,
                ),
              ],
              Gap(12.h),
            ],

            // Receiver Information
            if (order.note?.recevierName != null ||
                order.note?.recevierPhone != null) ...[
              _SectionHeader(title: "Receiver"),
              Gap(8.h),
              if (order.note?.recevierName != null)
                _InfoRow(
                  icon: LucideIcons.user,
                  label: "Name",
                  value: order.note!.recevierName!,
                ),
              if (order.note?.recevierPhone != null) ...[
                Gap(8.h),
                _InfoRow(
                  icon: LucideIcons.phone,
                  label: "Phone",
                  value: order.note!.recevierPhone!,
                ),
              ],
              Gap(12.h),
            ],

            // OTP Status
            if (order.deliveryOtp != null) ...[
              _OtpStatusSection(
                otp: order.deliveryOtp!,
                isVerified: order.otpVerifiedAt != null,
                verifiedAt: order.otpVerifiedAt,
              ),
              Gap(12.h),
            ],

            // Delivery Item Photo
            if (order.deliveryItemPhotoUrl != null) ...[
              _ImageSection(
                title: "Item Photo",
                subtitle: "Photo taken at pickup",
                imageUrl: order.deliveryItemPhotoUrl!,
                icon: LucideIcons.camera,
              ),
              Gap(12.h),
            ],

            // Proof of Delivery Photo
            if (order.proofOfDeliveryUrl != null) ...[
              _ImageSection(
                title: "Proof of Delivery",
                subtitle: "Photo taken at dropoff",
                imageUrl: order.proofOfDeliveryUrl!,
                icon: LucideIcons.badgeCheck,
              ),
            ],

            // Attachment URL (for document delivery)
            if (order.attachmentUrl != null) ...[
              Gap(12.h),
              _InfoRow(
                icon: LucideIcons.paperclip,
                label: "Attachment",
                value: "Document attached",
                trailing: IconButton.ghost(
                  icon: const Icon(LucideIcons.externalLink),
                  onPressed: () {
                    // TODO: Open attachment URL
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDeliveryItemType(DeliveryItemType type) {
    switch (type) {
      case DeliveryItemType.FOOD:
        return "Food";
      case DeliveryItemType.CLOTH:
        return "Clothing";
      case DeliveryItemType.DOCUMENT:
        return "Document";
      case DeliveryItemType.MEDICINE:
        return "Medicine";
      case DeliveryItemType.BOOK:
        return "Book";
      case DeliveryItemType.OTHER:
        return "Other";
    }
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.typography.small.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.primary,
      ),
    );
  }
}

/// Info row widget for displaying label-value pairs
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: context.colorScheme.mutedForeground),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  fontSize: 11.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              Text(
                value,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// OTP status section widget
class _OtpStatusSection extends StatelessWidget {
  const _OtpStatusSection({
    required this.otp,
    required this.isVerified,
    this.verifiedAt,
  });

  final String otp;
  final bool isVerified;
  final DateTime? verifiedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isVerified
            ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
            : context.colorScheme.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isVerified
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : context.colorScheme.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isVerified
                  ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
                  : context.colorScheme.muted,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVerified ? LucideIcons.shieldCheck : LucideIcons.keyRound,
              size: 20.sp,
              color: isVerified
                  ? const Color(0xFF4CAF50)
                  : context.colorScheme.mutedForeground,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery OTP",
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Gap(2.h),
                Row(
                  children: [
                    Text(
                      otp,
                      style: context.typography.h4.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    Gap(8.w),
                    if (isVerified)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "VERIFIED",
                          style: context.typography.small.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                if (verifiedAt != null) ...[
                  Gap(4.h),
                  Text(
                    "Verified at ${verifiedAt!.format("dd MMM yyyy, HH:mm")}",
                    style: context.typography.small.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Image section widget for displaying photos with preview capability
class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: context.colorScheme.mutedForeground),
            Gap(8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.typography.small.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(8.h),
        GestureDetector(
          onTap: () => _showFullImage(context),
          child: Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.colorScheme.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: context.colorScheme.muted,
                  child: Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: context.colorScheme.muted,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.imageOff,
                        size: 32.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                      Gap(8.h),
                      Text(
                        "Failed to load image",
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => GestureDetector(
        onTap: () => Navigator.of(dialogContext).pop(),
        child: Container(
          color: Colors.black.withValues(alpha: 0.9),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(LucideIcons.imageOff, size: 48),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 48,
                right: 16,
                child: IconButton(
                  icon: Icon(LucideIcons.x, color: Colors.white, size: 28.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  variance: ButtonVariance.ghost,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
