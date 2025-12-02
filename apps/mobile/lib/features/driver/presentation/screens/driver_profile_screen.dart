import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
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
          title: const Text('Profile'),
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.settings),
              onPressed: () {
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Settings',
                    message: 'Settings feature coming soon',
                  ),
                );
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
            'Failed to load profile',
            style: context.typography.h3.copyWith(fontSize: 20.sp),
          ),
          PrimaryButton(onPressed: _loadProfile, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Driver driver) {
    final user = driver.user;
    final statusColor = _getStatusColor(driver.status);
    final statusText = _getStatusText(driver.status);

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
                    'License Plate',
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
            driver.isTakingOrder ? 'Taking Orders' : 'Not Taking Orders',
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
              'Student Card (KTM)',
              driver.studentCard.isNotEmpty,
            ),
            _buildDocumentItem(
              'Driver License (SIM)',
              driver.driverLicense.isNotEmpty,
            ),
            _buildDocumentItem(
              'Vehicle Certificate (STNK)',
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
          isUploaded ? 'Uploaded' : 'Missing',
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
              'Bank Account',
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
              children: const [Icon(LucideIcons.pencil), Text('Edit Profile')],
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
              children: [const Icon(LucideIcons.logOut), const Text('Logout')],
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
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          material.TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _performLogout();
            },
            child: const Text('Logout'),
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
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Success',
            message: 'Logged out successfully',
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to logout: ${e.toString()}',
          ),
        );
      }
    }
  }

  void _showEditProfileDialog() {
    if (_driver == null) return;

    final licensePlateController = material.TextEditingController(
      text: _driver!.licensePlate,
    );

    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: const Text('Edit Profile'),
        content: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your profile information',
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            SizedBox(height: 16.h),
            material.TextField(
              controller: licensePlateController,
              decoration: const material.InputDecoration(
                labelText: 'License Plate',
                hintText: 'Enter license plate',
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
            child: const Text('Cancel'),
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
                return;
              }

              // Close dialog
              licensePlateController.dispose();
              Navigator.of(dialogContext).pop();

              // Update profile
              try {
                setState(() => _isLoading = true);

                final response = await context.read<DriverRepository>().update(
                  driverId: _driver!.id,
                  licensePlate: newLicensePlate,
                );

                if (mounted) {
                  setState(() {
                    _driver = response.data;
                    _isLoading = false;
                  });

                  showToast(
                    context: context,
                    builder: (context, overlay) => context.buildToast(
                      title: 'Success',
                      message: 'Profile updated successfully',
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  setState(() => _isLoading = false);
                  showToast(
                    context: context,
                    builder: (context, overlay) => context.buildToast(
                      title: 'Error',
                      message: 'Failed to update profile: ${e.toString()}',
                    ),
                  );
                }
              }
            },
            child: const Text('Save'),
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

  String _getStatusText(DriverStatus status) {
    switch (status) {
      case DriverStatus.PENDING:
        return 'Pending Approval';
      case DriverStatus.ACTIVE:
        return 'Active';
      case DriverStatus.APPROVED:
        return 'Approved';
      case DriverStatus.REJECTED:
        return 'Rejected';
      case DriverStatus.INACTIVE:
        return 'Inactive';
      case DriverStatus.SUSPENDED:
        return 'Suspended';
    }
  }
}
