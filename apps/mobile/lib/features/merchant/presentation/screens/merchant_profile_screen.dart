import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantProfileScreen extends StatelessWidget {
  const MerchantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      safeArea: true,
      body: Column(
        spacing: 16.h,
        children: [
          Card(
            child: Row(
              spacing: 24.w,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    'assets/images/fore_logo.png',
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Hello, Fore!',
                  style: context.typography.small.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Button.card(
            onPressed: () => context.pushNamed(Routes.merchantSetUpOutlet.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set Up Outlet',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  LucideIcons.pencil,
                  size: 14,
                ),
              ],
            ),
          ),
          Button.card(
            onPressed: () => context.pushNamed(Routes.merchantEditProfile.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Profile',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  LucideIcons.pencil,
                  size: 14,
                ),
              ],
            ),
          ),
          Button.card(
            onPressed: () =>
                context.pushNamed(Routes.merchantChangePassword.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change Password',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  LucideIcons.pencil,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Button.card(
              onPressed: () => context.pushNamed(Routes.privacyPolicies.name),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Privacy Policies',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          const SignOutButtonWidget(),
        ],
      ),
    );
  }
}
