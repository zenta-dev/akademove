import 'package:akademove/app/router/router.dart';
import 'package:akademove/app/widgets/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    await context.read<DriverProfileCubit>().loadProfile();
  }

  Future<void> _onRefresh() async {
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverProfileCubit, DriverProfileState>(
      builder: (context, state) {
        return Scaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.profile,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          child: SafeRefreshTrigger(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.dg),
                child: Builder(
                  builder: (context) {
                    final driver = state.driver;
                    if (driver == null) return _buildErrorState();

                    return Column(
                      spacing: 16.h,
                      children: [
                        _buildProfileHeader(driver),
                        _buildStatsCards(driver),
                        _buildDocumentSection(driver),
                        _buildBankSection(driver),
                        _buildActionButtons(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.h,
        children: [
          Icon(
            LucideIcons.triangleAlert,
            size: 64.sp,
            color: context.colorScheme.destructive,
          ),
          Text(
            context.l10n.failed_to_load_profile,
            style: context.typography.h3.copyWith(fontSize: 20.sp),
          ),
          PrimaryButton(
            onPressed: _loadProfile,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Driver driver) {
    final user = driver.user;
    final statusColor = _getStatusColor(driver.status);
    final statusText = _getStatusText(context, driver.status);

    return Card(
      child: Column(
        spacing: 16.h,
        children: [
          // Avatar and basic info
          Row(
            spacing: 16.w,
            children: [
              _buildAvatar(user),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      user?.name ?? 'Driver',
                      style: context.typography.h3.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: 8.w,
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 16.sp,
                          color: const Color(0xFFFFC107),
                        ),
                        Text(
                          driver.rating.toStringAsFixed(1),
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        statusText,
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          // License plate and student ID
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  LucideIcons.car,
                  context.l10n.license_plate,
                  driver.licensePlate,
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: context.colorScheme.border,
              ),
              Expanded(
                child: _buildInfoItem(
                  LucideIcons.idCard,
                  'Student ID',
                  driver.studentId.toString(),
                ),
              ),
            ],
          ),
          const Divider(),
          // User ID with copy functionality
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: driver.userId));
              context.showMyToast(
                context.l10n.copied_to_clipboard,
                type: ToastType.success,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.fingerprint,
                  size: 16.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  context.l10n.label_user_id,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Text(
                  driver.userId.length > 8
                      ? '${driver.userId.substring(0, 8)}...'
                      : driver.userId,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  LucideIcons.copy,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      spacing: 4.h,
      children: [
        Icon(icon, size: 20.sp, color: context.colorScheme.mutedForeground),
        Text(
          label,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
        Text(
          value,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(DriverUser? user) {
    final imageUrl = user?.image;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Container(
      width: 80.r,
      height: 80.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        border: Border.all(color: context.colorScheme.primary, width: 2),
      ),
      child: ClipOval(
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80.r,
                height: 80.r,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    _buildAvatarPlaceholder(user),
              )
            : _buildAvatarPlaceholder(user),
      ),
    );
  }

  Widget _buildAvatarPlaceholder(DriverUser? user) {
    return Center(
      child: Text(
        user?.name?.firstChar.toUpperCase() ?? 'D',
        style: context.typography.h1.copyWith(
          fontSize: 32.sp,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildStatsCards(Driver driver) {
    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: _buildStatCard(
            LucideIcons.circleCheck,
            driver.isTakingOrder
                ? context.l10n.taking_orders
                : context.l10n.not_taking_orders,
            driver.isTakingOrder
                ? const Color(0xFF4CAF50)
                : context.colorScheme.mutedForeground,
          ),
        ),
        Expanded(
          child: _buildStatCard(
            LucideIcons.wifi,
            driver.isOnline ? 'Online' : 'Offline',
            driver.isOnline
                ? const Color(0xFF4CAF50)
                : context.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String label, Color color) {
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Icon(icon, size: 24.sp, color: color),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection(Driver driver) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Documents',
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          _buildDocumentItem(
            context.l10n.student_card,
            driver.studentCard.isNotEmpty,
          ),
          _buildDocumentItem(
            context.l10n.driver_license,
            driver.driverLicense.isNotEmpty,
          ),
          _buildDocumentItem(
            context.l10n.vehicle_certificate,
            driver.vehicleCertificate.isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String label, bool isUploaded) {
    return Row(
      children: [
        Icon(
          isUploaded ? LucideIcons.circleCheck : LucideIcons.circleX,
          size: 20.sp,
          color: isUploaded
              ? const Color(0xFF4CAF50)
              : context.colorScheme.destructive,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: context.typography.p.copyWith(fontSize: 14.sp),
          ),
        ),
        Text(
          isUploaded ? context.l10n.uploaded : context.l10n.missing,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            color: isUploaded
                ? const Color(0xFF4CAF50)
                : context.colorScheme.destructive,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBankSection(Driver driver) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            context.l10n.bank_account,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                LucideIcons.building,
                size: 20.sp,
                color: context.colorScheme.mutedForeground,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      driver.bank.provider.name,
                      style: context.typography.p.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      driver.bank.number.toString(),
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: 12.h,
      children: [
        // Account Settings Section
        Text(
          context.l10n.account_settings,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Button(
          style:
              ButtonStyle.card(
                density: ButtonDensity(
                  (val) =>
                      EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                ),
              ).copyWith(
                decoration: (context, states, value) =>
                    value.copyWithIfBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
              ),
          onPressed: () async {
            await context.pushNamed(Routes.driverEditProfile.name);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(context.l10n.edit_profile, fontSize: 14.sp),
              Icon(LucideIcons.pencil, size: 14.sp),
            ],
          ),
        ),
        Button(
          style:
              ButtonStyle.card(
                density: ButtonDensity(
                  (val) =>
                      EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                ),
              ).copyWith(
                decoration: (context, states, value) =>
                    value.copyWithIfBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
              ),
          onPressed: () async {
            await context.pushNamed(Routes.driverChangePassword.name);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(context.l10n.change_password, fontSize: 14.sp),
              Icon(LucideIcons.pencil, size: 14.sp),
            ],
          ),
        ),

        // Legal Section
        Text(
          'Legal',
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Button(
          style:
              ButtonStyle.card(
                density: ButtonDensity(
                  (val) =>
                      EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                ),
              ).copyWith(
                decoration: (context, states, value) =>
                    value.copyWithIfBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
              ),
          onPressed: () async {
            await context.pushNamed(Routes.termsOfService.name);
          },
          child: Row(
            children: [
              DefaultText(context.l10n.terms_of_service, fontSize: 14.sp),
            ],
          ),
        ),
        Button(
          style:
              ButtonStyle.card(
                density: ButtonDensity(
                  (val) =>
                      EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                ),
              ).copyWith(
                decoration: (context, states, value) =>
                    value.copyWithIfBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
              ),
          onPressed: () async {
            await context.pushNamed(Routes.privacyPolicies.name);
          },
          child: Row(
            children: [
              DefaultText(context.l10n.privacy_policy, fontSize: 14.sp),
            ],
          ),
        ),
        Button(
          style:
              ButtonStyle.card(
                density: ButtonDensity(
                  (val) =>
                      EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                ),
              ).copyWith(
                decoration: (context, states, value) =>
                    value.copyWithIfBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
              ),
          onPressed: () async {
            await context.pushNamed(Routes.faq.name);
          },
          child: Row(
            children: [DefaultText(context.l10n.faq, fontSize: 14.sp)],
          ),
        ),

        // App Settings Section
        Text(
          context.l10n.app_settings,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          spacing: 8.h,
          children: [
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(context.l10n.language, fontSize: 14.sp),
                const AppSelectLocaleWidget(),
              ],
            ),
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(context.l10n.theme, fontSize: 14.sp),
                const AppSelectThemeWidget(),
              ],
            ),
          ],
        ),

        // Account Actions Section
        // const DeleteAccountButtonWidget(accountType: 'DRIVER'),
        SizedBox(
          width: double.infinity,
          child: DestructiveButton(
            onPressed: () {
              _showLogoutDialog();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                const Icon(LucideIcons.logOut),
                Text(context.l10n.logout),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.logout),
        content: Text(context.l10n.are_you_sure_you_want_to_logout),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          DestructiveButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _performLogout();
            },
            child: Text(context.l10n.logout),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      // Call AuthCubit to sign out
      await context.read<AuthCubit>().signOut();

      if (mounted) {
        // Navigate to sign-in screen and clear navigation stack
        context.goNamed(Routes.authSignIn.name);

        // Show success message
        context.showMyToast(
          context.l10n.logged_out_successfully,
          type: ToastType.success,
        );
      }
    } on BaseError catch (e) {
      if (mounted) {
        context.showMyToast(e.message, type: ToastType.failed);
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(
          context.l10n.an_error_occurred,
          type: ToastType.failed,
        );
      }
    }
  }

  Color _getStatusColor(DriverStatus status) {
    switch (status) {
      case DriverStatus.PENDING:
        return const Color(0xFFFF9800);
      case DriverStatus.ACTIVE:
      case DriverStatus.APPROVED:
        return const Color(0xFF4CAF50);
      case DriverStatus.REJECTED:
        return const Color(0xFFF44336);
      case DriverStatus.INACTIVE:
      case DriverStatus.SUSPENDED:
        return const Color(0xFF9E9E9E);
    }
  }

  String _getStatusText(BuildContext context, DriverStatus status) {
    switch (status) {
      case DriverStatus.PENDING:
        return context.l10n.pending_approval;
      case DriverStatus.ACTIVE:
        return context.l10n.active;
      case DriverStatus.APPROVED:
        return context.l10n.approved;
      case DriverStatus.REJECTED:
        return context.l10n.rejected;
      case DriverStatus.INACTIVE:
        return context.l10n.inactive;
      case DriverStatus.SUSPENDED:
        return context.l10n.suspended;
    }
  }
}
