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

class MerchantProfileScreen extends StatefulWidget {
  const MerchantProfileScreen({super.key});

  @override
  State<MerchantProfileScreen> createState() => _MerchantProfileScreenState();
}

class _MerchantProfileScreenState extends State<MerchantProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    await context.read<MerchantCubit>().loadProfile();
  }

  Future<void> _onRefresh() async {
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantCubit, MerchantState>(
      builder: (context, state) {
        return Scaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.profile,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: RefreshTrigger(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) {
                    final merchant = state.merchant ?? state.mine.value;
                    if (merchant == null) return _buildErrorState();

                    return Column(
                      spacing: 16.h,
                      children: [
                        _buildProfileHeader(merchant),
                        _buildStatsCards(merchant),
                        _buildDocumentSection(merchant),
                        _buildBankSection(merchant),
                        _buildContactSection(merchant),
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

  Widget _buildProfileHeader(Merchant merchant) {
    final statusColor = _getStatusColor(merchant.status);
    final statusText = _getStatusText(context, merchant.status);

    return Card(
      child: Column(
        spacing: 16.h,
        children: [
          // Avatar and basic info
          Row(
            spacing: 16.w,
            children: [
              // Merchant image or placeholder
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
                child: ClipOval(
                  child: merchant.image != null && merchant.image!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: merchant.image!,
                          fit: BoxFit.cover,
                          width: 80.r,
                          height: 80.r,
                          placeholder: (context, url) => Center(
                            child: Text(
                              merchant.name.firstChar.toUpperCase(),
                              style: context.typography.h1.copyWith(
                                fontSize: 32.sp,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text(
                              merchant.name.firstChar.toUpperCase(),
                              style: context.typography.h1.copyWith(
                                fontSize: 32.sp,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            merchant.name.firstChar.toUpperCase(),
                            style: context.typography.h1.copyWith(
                              fontSize: 32.sp,
                              color: context.colorScheme.primary,
                            ),
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
                      merchant.name,
                      style: context.typography.h3.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Rating
                    Row(
                      spacing: 8.w,
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 16.sp,
                          color: const Color(0xFFFFC107),
                        ),
                        Text(
                          merchant.rating.toStringAsFixed(1),
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // Status badge
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
          // Category and Active Orders
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  LucideIcons.tag,
                  context.l10n.label_category,
                  merchant.category.value,
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: context.colorScheme.border,
              ),
              Expanded(
                child: _buildInfoItem(
                  LucideIcons.shoppingBag,
                  'Active Orders',
                  merchant.activeOrderCount.toString(),
                ),
              ),
            ],
          ),
          const Divider(),
          // User ID with copy functionality
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: merchant.userId));
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
                  merchant.userId.length > 8
                      ? '${merchant.userId.prefix(8)}...'
                      : merchant.userId,
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

  Widget _buildStatsCards(Merchant merchant) {
    final operatingColor = _getOperatingStatusColor(merchant.operatingStatus);
    final operatingText = _getOperatingStatusText(
      context,
      merchant.operatingStatus,
    );

    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: _buildStatCard(
            LucideIcons.wifi,
            merchant.isOnline ? 'Online' : 'Offline',
            merchant.isOnline
                ? const Color(0xFF4CAF50)
                : context.colorScheme.mutedForeground,
          ),
        ),
        Expanded(
          child: _buildStatCard(
            LucideIcons.store,
            operatingText,
            operatingColor,
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

  Widget _buildDocumentSection(Merchant merchant) {
    final hasDocument =
        merchant.document != null && merchant.document!.isNotEmpty;

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
          _buildDocumentItem(context.l10n.government_document, hasDocument),
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

  Widget _buildBankSection(Merchant merchant) {
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
                      merchant.bank.provider.name,
                      style: context.typography.p.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      merchant.bank.number.toString(),
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    if (merchant.bank.accountName != null)
                      Text(
                        merchant.bank.accountName!,
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

  Widget _buildContactSection(Merchant merchant) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Business Information',
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          // Email
          Row(
            spacing: 12.w,
            children: [
              Icon(
                LucideIcons.mail,
                size: 20.sp,
                color: context.colorScheme.mutedForeground,
              ),
              Expanded(
                child: Text(
                  merchant.email,
                  style: context.typography.p.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          // Phone
          if (merchant.phone != null)
            Row(
              spacing: 12.w,
              children: [
                Icon(
                  LucideIcons.phone,
                  size: 20.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Expanded(
                  child: Text(
                    '${merchant.phone!.countryCode.value} ${merchant.phone!.number}',
                    style: context.typography.p.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.w,
            children: [
              Icon(
                LucideIcons.mapPin,
                size: 20.sp,
                color: context.colorScheme.mutedForeground,
              ),
              Expanded(
                child: Text(
                  merchant.address,
                  style: context.typography.p.copyWith(fontSize: 14.sp),
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
            await context.pushNamed(Routes.merchantSetUpOutlet.name);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(context.l10n.title_set_up_outlet, fontSize: 14.sp),
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
            await context.pushNamed(Routes.merchantEditProfile.name);
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
            await context.pushNamed(Routes.merchantChangePassword.name);
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
        // const DeleteAccountButtonWidget(accountType: 'MERCHANT'),
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
                Text(context.l10n.sign_out),
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
        title: Text(context.l10n.sign_out),
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
            child: Text(context.l10n.sign_out),
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
          context.l10n.error_unexpected,
          type: ToastType.failed,
        );
      }
    }
  }

  Color _getStatusColor(MerchantStatusEnum status) {
    switch (status) {
      case MerchantStatusEnum.PENDING:
        return const Color(0xFFFF9800);
      case MerchantStatusEnum.ACTIVE:
      case MerchantStatusEnum.APPROVED:
        return const Color(0xFF4CAF50);
      case MerchantStatusEnum.REJECTED:
        return const Color(0xFFF44336);
      case MerchantStatusEnum.INACTIVE:
      case MerchantStatusEnum.SUSPENDED:
        return const Color(0xFF9E9E9E);
    }
  }

  String _getStatusText(BuildContext context, MerchantStatusEnum status) {
    switch (status) {
      case MerchantStatusEnum.PENDING:
        return context.l10n.pending_approval;
      case MerchantStatusEnum.ACTIVE:
        return context.l10n.active;
      case MerchantStatusEnum.APPROVED:
        return context.l10n.approved;
      case MerchantStatusEnum.REJECTED:
        return context.l10n.rejected;
      case MerchantStatusEnum.INACTIVE:
        return context.l10n.inactive;
      case MerchantStatusEnum.SUSPENDED:
        return context.l10n.suspended;
    }
  }

  Color _getOperatingStatusColor(MerchantOperatingStatusEnum status) {
    switch (status) {
      case MerchantOperatingStatusEnum.OPEN:
        return const Color(0xFF4CAF50);
      case MerchantOperatingStatusEnum.CLOSED:
        return const Color(0xFFF44336);
      case MerchantOperatingStatusEnum.BREAK:
        return const Color(0xFFFF9800);
      case MerchantOperatingStatusEnum.MAINTENANCE:
        return const Color(0xFF9E9E9E);
    }
  }

  String _getOperatingStatusText(
    BuildContext context,
    MerchantOperatingStatusEnum status,
  ) {
    switch (status) {
      case MerchantOperatingStatusEnum.OPEN:
        return 'Open';
      case MerchantOperatingStatusEnum.CLOSED:
        return 'Closed';
      case MerchantOperatingStatusEnum.BREAK:
        return 'Break';
      case MerchantOperatingStatusEnum.MAINTENANCE:
        return 'Maintenance';
    }
  }
}
