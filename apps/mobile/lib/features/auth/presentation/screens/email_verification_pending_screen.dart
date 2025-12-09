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
              child: SingleChildScrollView(
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
  final FormKey<String> _codeKey = const TextFieldKey('code');
  late FocusNode _codeFn;

  bool _canResend = true;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    _codeFn = FocusNode();
    context.read<AuthCubit>().reset();
  }

  @override
  void dispose() {
    _codeFn.dispose();
    super.dispose();
  }

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
      final step = state.value?.step;
      context.showMyToast(
        state.message ?? context.l10n.email_verification_success_title,
        type: ToastType.success,
      );
      // Only navigate to sign-in when email verification is complete (verifyCode step)
      if (step == EmailVerificationStep.verifyCode) {
        await delay(const Duration(seconds: 1), () {});
        if (context.mounted) {
          context.goNamed(Routes.authSignIn.name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
      listener: handleEvent,
      builder: (context, state) {
        // Capture cubit reference from the BlocConsumer's context
        final cubit = context.read<EmailVerificationCubit>();
        return Form(
          onSubmit: (formContext, values) async {
            if (state.isLoading) return;
            final code = _codeKey[values];
            if (code == null || code.isEmpty) return;

            await cubit.verifyEmail(email: widget.email, code: code);
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(12.dg),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.muted.withValues(
                      alpha: 0.5,
                    ),
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
                Gap(16.h),
                FormField(
                  key: _codeKey,
                  label: DefaultText(
                    context.l10n.otp_code,
                    fontWeight: FontWeight.w500,
                  ),
                  validator: const LengthValidator(min: 6, max: 6),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    focusNode: _codeFn,
                    placeholder: Text(context.l10n.placeholder_otp_code),
                    keyboardType: TextInputType.number,
                    features: const [
                      InputFeature.leading(Icon(LucideIcons.keyRound)),
                    ],
                  ),
                ),
                Gap(16.h),
                FormErrorBuilder(
                  builder: (context, errors, child) {
                    final hasErrors = errors.isNotEmpty;
                    final isLoading = state.isLoading;

                    return Button(
                      style: isLoading || hasErrors
                          ? const ButtonStyle.outline()
                          : const ButtonStyle.primary(),
                      onPressed: (!hasErrors && !isLoading)
                          ? () => context.submitForm()
                          : null,
                      child: isLoading
                          ? const Submiting()
                          : DefaultText(
                              context.l10n.submit,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                    );
                  },
                ),
                Gap(16.h),
                Button(
                  style: _canResend && !state.isLoading
                      ? const ButtonStyle.outline()
                      : const ButtonStyle.ghost(),
                  onPressed: _canResend && !state.isLoading
                      ? () => _handleResend(context)
                      : null,
                  child: _canResend
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
                  style: const ButtonStyle.ghost(),
                  onPressed: () => context.goNamed(Routes.authSignIn.name),
                  child: DefaultText(
                    context.l10n.back_to_sign_in,
                    fontWeight: FontWeight.w500,
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
            ),
          ),
        );
      },
    );
  }
}
