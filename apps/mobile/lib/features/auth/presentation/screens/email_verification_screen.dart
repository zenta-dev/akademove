import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// This screen is shown when user navigates to /verify-email without proper parameters.
/// With OTP-based verification, users should go to [EmailVerificationPendingScreen] instead.
class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, this.token});

  final String? token;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      child: Stack(
        children: [
          SvgTiledBackground(
            asset: Assets.images.bg.signIn.path,
            tileSize: 400.w,
            colorFilter: ColorFilter.mode(
              context.isDarkMode
                  ? Colors.neutral.shade900
                  : Colors.neutral.shade100,
              BlendMode.srcIn,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.dg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Assets.icons.brand.svg(width: 48.w),
                      DefaultText(
                        context.l10n.email_verification_title,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ).gap(8.h),
                  Gap(16.h),
                  Card(
                    padding: EdgeInsets.all(16.dg),
                    child: SizedBox(
                      width: size.width.w,
                      child: _buildInvalidTokenView(context),
                    ),
                  ).intrinsic(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvalidTokenView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.triangleAlert, size: 64.w, color: Colors.orange),
        Gap(16.h),
        DefaultText(
          context.l10n.email_verification_failed,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(8.h),
        Text(
          context.l10n.email_verification_invalid_token,
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(24.h),
        Button(
          style: const ButtonStyle.primary(),
          onPressed: () => context.goNamed(Routes.authSignIn.name),
          child: DefaultText(
            context.l10n.back_to_sign_in,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
