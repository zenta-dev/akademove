import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class EmailVerificationPendingScreen extends StatelessWidget {
  const EmailVerificationPendingScreen({super.key, required this.email});

  final String email;

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
                      Icon(
                        LucideIcons.mailCheck,
                        size: 64.w,
                        color: context.theme.colorScheme.primary,
                      ),
                      Gap(16.h),
                      DefaultText(
                        context.l10n.email_verification_title,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Text(
                        context.l10n.email_verification_description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).gap(8.h),
                  Gap(16.h),
                  Card(
                    padding: EdgeInsets.all(16.dg),
                    child: SizedBox(
                      width: size.width.w,
                      child: _EmailVerificationPendingView(email: email),
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

class _EmailVerificationPendingView extends StatefulWidget {
  const _EmailVerificationPendingView({required this.email});

  final String email;

  @override
  State<_EmailVerificationPendingView> createState() =>
      _EmailVerificationPendingViewState();
}

class _EmailVerificationPendingViewState
    extends State<_EmailVerificationPendingView> {
  bool _canResend = true;
  int _resendCountdown = 0;

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          _canResend = true;
        }
      });
      return _resendCountdown > 0;
    });
  }

  Future<void> _handleResend(BuildContext context) async {
    if (!_canResend) return;
    _startResendTimer();
    await context.read<EmailVerificationCubit>().sendVerificationEmail(
      widget.email,
    );
  }

  Future<void> handleEvent(
    BuildContext context,
    EmailVerificationState state,
  ) async {
    if (state.isFailure) {
      context.showMyToast(state.error?.message, type: ToastType.failed);
    }
    if (state.isSuccess) {
      context.showMyToast(
        state.message ?? context.l10n.email_verification_sent,
        type: ToastType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
      listener: handleEvent,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(12.dg),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.muted.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.mail,
                    size: 20.w,
                    color: context.colorScheme.mutedForeground,
                  ),
                  Gap(8.w),
                  Expanded(
                    child: DefaultText(
                      widget.email,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Text(
              context.l10n.email_verification_instruction,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),
            Button(
              style: _canResend && !state.isLoading
                  ? const ButtonStyle.outline()
                  : const ButtonStyle.ghost(),
              onPressed: _canResend && !state.isLoading
                  ? () => _handleResend(context)
                  : null,
              child: state.isLoading
                  ? const Submiting()
                  : _canResend
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.refreshCw, size: 16.w),
                        Gap(8.w),
                        DefaultText(
                          context.l10n.email_verification_resend,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )
                  : DefaultText(
                      context.l10n.email_verification_resend_countdown(
                        _resendCountdown.toString(),
                      ),
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.mutedForeground,
                    ),
            ),
            Gap(16.h),
            Button(
              style: const ButtonStyle.primary(),
              onPressed: () => context.goNamed(Routes.authSignIn.name),
              child: DefaultText(
                context.l10n.back_to_sign_in,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Gap(8.h),
            Text(
              context.l10n.email_verification_spam_hint,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
