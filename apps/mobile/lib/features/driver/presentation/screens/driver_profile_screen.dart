import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
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
    await sl<DriverRepository>().getMine();
  }

  Future<void> _onRefresh() async {
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      builder: (context, state) {
        return MyScaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.profile,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          body: RefreshTrigger(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
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
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    user?.name?.substring(0, 1).toUpperCase() ?? 'D',
                    style: context.typography.h1.copyWith(
                      fontSize: 32.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
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
        const DeleteAccountButtonWidget(accountType: 'DRIVER'),
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
        context.go(Routes.authSignIn.path);

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
