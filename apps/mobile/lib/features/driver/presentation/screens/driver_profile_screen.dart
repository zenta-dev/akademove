import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
  Driver? _driver;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);

    try {
      final response = await context.read<DriverRepository>().getMine();
      if (mounted) {
        setState(() {
          _driver = response.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to load profile: ${e.toString()}',
          ),
        );
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: Text(context.l10n.profile),
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.settings),
              onPressed: () {
                _showSettingsDialog();
              },
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      body: _isLoading && _driver == null
          ? const Center(child: CircularProgressIndicator())
          : material.RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.dg),
                child: Builder(
                  builder: (context) {
                    final driver = _driver;
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
            color: material.Colors.red,
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
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 16.h,
          children: [
            // Avatar and basic info
            Row(
              spacing: 16.w,
              children: [
                material.CircleAvatar(
                  radius: 40.r,
                  child: Text(
                    user?.name?.substring(0, 1).toUpperCase() ?? 'D',
                    style: context.typography.h1.copyWith(fontSize: 32.sp),
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
                            color: material.Colors.amber,
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
            driver.isTakingOrder ? material.Colors.green : material.Colors.grey,
          ),
        ),
        Expanded(
          child: _buildStatCard(
            LucideIcons.wifi,
            driver.isOnline ? 'Online' : 'Offline',
            driver.isOnline ? material.Colors.green : material.Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String label, material.Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.dg),
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
      ),
    );
  }

  Widget _buildDocumentSection(Driver driver) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
      ),
    );
  }

  Widget _buildDocumentItem(String label, bool isUploaded) {
    return Row(
      children: [
        Icon(
          isUploaded ? LucideIcons.circleCheck : LucideIcons.circleX,
          size: 20.sp,
          color: isUploaded ? material.Colors.green : material.Colors.red,
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
            color: isUploaded ? material.Colors.green : material.Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBankSection(Driver driver) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: 12.h,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlineButton(
            onPressed: () {
              _showEditProfileDialog();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Icon(LucideIcons.pencil),
                Text(context.l10n.edit_profile),
              ],
            ),
          ),
        ),
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
    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: Text(context.l10n.logout),
        content: Text(context.l10n.are_you_sure_you_want_to_logout),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          material.TextButton(
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
      setState(() => _isLoading = true);

      // Call AuthCubit to sign out
      await context.read<AuthCubit>().signOut();

      if (mounted) {
        setState(() => _isLoading = false);

        // Clear all cached data
        AppCaches.clearAll();

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
        setState(() => _isLoading = false);
        context.showMyToast(e.message, type: ToastType.failed);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          context.l10n.an_error_occurred,
          type: ToastType.failed,
        );
      }
    }
  }

  void _showEditProfileDialog() {
    final driver = _driver;
    if (driver == null) return;

    final licensePlateController = material.TextEditingController(
      text: driver.licensePlate,
    );

    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: Text(context.l10n.edit_profile),
        content: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.update_your_license_plate,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            SizedBox(height: 16.h),
            material.TextField(
              controller: licensePlateController,
              decoration: material.InputDecoration(
                labelText: context.l10n.license_plate,
                hintText: context.l10n.enter_license_plate,
                border: material.OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          material.TextButton(
            onPressed: () {
              licensePlateController.dispose();
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.cancel),
          ),
          material.TextButton(
            onPressed: () async {
              final newLicensePlate = licensePlateController.text.trim();

              if (newLicensePlate.isEmpty) {
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Validation Error',
                    message: 'License plate cannot be empty',
                  ),
                );
                context.showMyToast(
                  context.l10n.license_plate_cannot_be_empty,
                  type: ToastType.warning,
                );
                return;
              }

              // Close dialog
              licensePlateController.dispose();
              Navigator.of(dialogContext).pop();

              // Update profile
              try {
                setState(() => _isLoading = true);

                final response = await context.read<DriverRepository>().update(
                  driverId: driver.id,
                  licensePlate: newLicensePlate,
                );

                if (mounted) {
                  setState(() {
                    _driver = response.data;
                    _isLoading = false;
                  });

                  context.showMyToast(
                    context.l10n.profile_updated_successfully,
                    type: ToastType.success,
                  );
                }
              } on BaseError catch (e) {
                if (mounted) {
                  setState(() => _isLoading = false);
                  context.showMyToast(e.message, type: ToastType.failed);
                }
              } catch (e) {
                if (mounted) {
                  setState(() => _isLoading = false);
                  context.showMyToast(
                    context.l10n.an_error_occurred,
                    type: ToastType.failed,
                  );
                }
              }
            },
            child: Text(context.l10n.save),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    if (_driver == null) return;

    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: Text(context.l10n.settings),
        content: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.driver_preferences_and_settings,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            SizedBox(height: 16.h),
            material.ListTile(
              leading: Icon(LucideIcons.bell, size: 24.sp),
              title: Text(context.l10n.notifications),
              subtitle: Text(context.l10n.manage_notification_preferences),
              trailing: Icon(LucideIcons.chevronRight, size: 20.sp),
              onTap: () {
                Navigator.of(dialogContext).pop();
                context.ensureNotification();
              },
            ),
            // const Divider(),
            // material.ListTile(
            //   leading: Icon(LucideIcons.shield, size: 24.sp),
            //   title: const Text('Privacy'),
            //   subtitle: const Text('Control your privacy settings'),
            //   trailing: Icon(LucideIcons.chevronRight, size: 20.sp),
            //   onTap: () {
            //     Navigator.of(dialogContext).pop();
            //     showToast(
            //       context: context,
            //       builder: (context, overlay) => context.buildToast(
            //         title: 'Privacy',
            //         message: 'Privacy settings coming soon',
            //       ),
            //     );
            //   },
            // ),
            const Divider(),
            material.ListTile(
              leading: Icon(LucideIcons.info, size: 24.sp),
              title: Text(context.l10n.about),
              subtitle: Text(context.l10n.app_version_information),
              trailing: Icon(LucideIcons.chevronRight, size: 20.sp),
              onTap: () {
                Navigator.of(dialogContext).pop();
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'About',
                    message: 'AkadeMove Driver v1.0.0',
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.close),
          ),
        ],
      ),
    );
  }

  material.Color _getStatusColor(DriverStatus status) {
    switch (status) {
      case DriverStatus.PENDING:
        return material.Colors.orange;
      case DriverStatus.ACTIVE:
      case DriverStatus.APPROVED:
        return material.Colors.green;
      case DriverStatus.REJECTED:
        return material.Colors.red;
      case DriverStatus.INACTIVE:
      case DriverStatus.SUSPENDED:
        return material.Colors.grey;
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
