import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Assets.icons.brand.svg(width: 48.w),
                        DefaultText(
                          context.l10n.reset_password,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Text(
                          context.l10n.description_reset_password,
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
                      padding: EdgeInsets.all(8.dg),
                      child: SizedBox(
                        width: size.width.w,
                        child: _ResetPasswordFormView(email: email),
                      ),
                    ).intrinsic(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordFormView extends StatefulWidget {
  const _ResetPasswordFormView({this.email});

  final String? email;

  @override
  State<_ResetPasswordFormView> createState() => _ResetPasswordFormViewState();
}

class _ResetPasswordFormViewState extends State<_ResetPasswordFormView> {
  final FormKey<String> _codeKey = const TextFieldKey('code');
  final FormKey<String> _newPasswordKey = const TextFieldKey('newPassword');
  final FormKey<String> _confirmPasswordKey = const TextFieldKey(
    'confirmPassword',
  );
  late FocusNode _codeFn;
  late FocusNode _newPasswordFn;
  late FocusNode _confirmPasswordFn;

  @override
  void initState() {
    super.initState();
    _codeFn = FocusNode();
    _newPasswordFn = FocusNode();
    _confirmPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    _codeFn.dispose();
    _newPasswordFn.dispose();
    _confirmPasswordFn.dispose();
    super.dispose();
  }

  Future<void> handleEvent(BuildContext context, AuthState state) async {
    if (state.resetPasswordResult.isFailure) {
      context.showMyToast(
        state.resetPasswordResult.error?.message,
        type: ToastType.failed,
      );
    }
    if (state.resetPasswordResult.isSuccess) {
      context.showMyToast(
        state.resetPasswordResult.message,
        type: ToastType.success,
      );
      await delay(const Duration(seconds: 1), () {});
      if (context.mounted) {
        context.goNamed(Routes.authSignIn.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    if (email == null || email.isEmpty) {
      return Column(
        children: [
          Icon(LucideIcons.triangleAlert, size: 48.w, color: Colors.red),
          Gap(16.h),
          DefaultText(
            context.l10n.error_invalid_reset_token,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          Gap(8.h),
          Button(
            style: const ButtonStyle.primary(),
            onPressed: () => context.goNamed(Routes.authSignIn.name),
            child: Text(context.l10n.back_to_sign_in),
          ),
        ],
      ).gap(8.h);
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: handleEvent,
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) async {
            if (state.resetPasswordResult.isLoading) return;
            final code = _codeKey[values];
            final newPassword = _newPasswordKey[values];
            final confirmPassword = _confirmPasswordKey[values];
            if (code == null ||
                newPassword == null ||
                confirmPassword == null) {
              return;
            }

            if (newPassword != confirmPassword) {
              context.showMyToast(
                context.l10n.error_password_mismatch,
                type: ToastType.failed,
              );
              return;
            }

            await context.read<AuthCubit>().resetPassword(
              email: email,
              code: code,
              newPassword: newPassword,
              confirmPassword: confirmPassword,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.otp_code_sent_to_email,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8.h),
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
                  FormField(
                    key: _newPasswordKey,
                    label: DefaultText(
                      context.l10n.new_password,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _newPasswordFn,
                      placeholder: Text(context.l10n.placeholder_password),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormField(
                    key: _confirmPasswordKey,
                    label: DefaultText(
                      context.l10n.confirm_password,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _confirmPasswordFn,
                      placeholder: Text(
                        context.l10n.placeholder_confirm_password,
                      ),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormErrorBuilder(
                    builder: (context, errors, child) {
                      final hasErrors = errors.isNotEmpty;
                      final isLoading = state.resetPasswordResult.isLoading;

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
                                context.l10n.reset_password,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4.w,
                    children: [
                      DefaultText(
                        context.l10n.message_remember_password,
                        fontSize: 14.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                      Button(
                        style: const ButtonStyle.link(
                          size: ButtonSize.small,
                          density: ButtonDensity.compact,
                        ),
                        onPressed: () async {
                          await context.pushNamed(Routes.authSignIn.name);
                        },
                        child: DefaultText(
                          context.l10n.sign_in,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ).gap(8.h),
            ],
          ),
        );
      },
    );
  }
}
