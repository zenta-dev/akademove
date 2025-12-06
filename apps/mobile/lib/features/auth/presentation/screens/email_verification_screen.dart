import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
                      child: _EmailVerificationView(token: token),
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
}

class _EmailVerificationView extends StatefulWidget {
  const _EmailVerificationView({this.token});

  final String? token;

  @override
  State<_EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<_EmailVerificationView> {
  @override
  void initState() {
    super.initState();
    final token = widget.token;
    if (token != null && token.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<EmailVerificationCubit>().verifyEmail(token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = widget.token;

    if (token == null || token.isEmpty) {
      return _buildInvalidTokenView(context);
    }

    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildLoadingView(context);
        }

        if (state.isSuccess) {
          return _buildSuccessView(context);
        }

        if (state.isFailure) {
          return _buildFailureView(context, state);
        }

        return _buildLoadingView(context);
      },
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 64.h,
          width: 64.w,
          child: const CircularProgressIndicator(),
        ),
        Gap(24.h),
        DefaultText(
          context.l10n.loading,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.circleCheck, size: 64.w, color: Colors.green),
        Gap(16.h),
        DefaultText(
          context.l10n.email_verification_success_title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(8.h),
        Text(
          context.l10n.email_verification_success_description,
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

  Widget _buildFailureView(BuildContext context, EmailVerificationState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.circleX, size: 64.w, color: Colors.red),
        Gap(16.h),
        DefaultText(
          context.l10n.email_verification_failed,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(8.h),
        Text(
          state.error?.message ?? context.l10n.email_verification_invalid_token,
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
