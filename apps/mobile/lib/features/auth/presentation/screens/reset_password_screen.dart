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
  const ResetPasswordScreen({super.key, this.token});

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
                        'Reset Password',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Text(
                        'Enter your new password',
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
                      child: _ResetPasswordFormView(token: token),
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

class _ResetPasswordFormView extends StatefulWidget {
  const _ResetPasswordFormView({this.token});

  final String? token;

  @override
  State<_ResetPasswordFormView> createState() => _ResetPasswordFormViewState();
}

class _ResetPasswordFormViewState extends State<_ResetPasswordFormView> {
  final FormKey<String> _newPasswordKey = const TextFieldKey('newPassword');
  final FormKey<String> _confirmPasswordKey = const TextFieldKey(
    'confirmPassword',
  );
  late FocusNode _newPasswordFn;
  late FocusNode _confirmPasswordFn;

  @override
  void initState() {
    super.initState();
    _newPasswordFn = FocusNode();
    _confirmPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordFn.dispose();
    _confirmPasswordFn.dispose();
    super.dispose();
  }

  Future<void> handleEvent(BuildContext context, AuthState state) async {
    if (state.isFailure) {
      context.showMyToast(state.error?.message, type: ToastType.failed);
    }
    if (state.isSuccess) {
      context.showMyToast(state.message, type: ToastType.success);
      await delay(const Duration(seconds: 1), () {});
      if (context.mounted) {
        context.goNamed(Routes.authSignIn.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = widget.token;
    if (token == null || token.isEmpty) {
      return Column(
        children: [
          Icon(LucideIcons.triangleAlert, size: 48.w, color: Colors.red),
          Gap(16.h),
          DefaultText(
            'Invalid or missing reset token',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          Gap(8.h),
          Button(
            style: const ButtonStyle.primary(),
            onPressed: () => context.goNamed(Routes.authSignIn.name),
            child: const Text('Back to Sign In'),
          ),
        ],
      ).gap(8.h);
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: handleEvent,
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) async {
            if (state.isLoading) return;
            final newPassword = _newPasswordKey[values];
            final confirmPassword = _confirmPasswordKey[values];
            if (newPassword == null || confirmPassword == null) return;

            if (newPassword != confirmPassword) {
              context.showMyToast(
                'Passwords do not match',
                type: ToastType.failed,
              );
              return;
            }

            await context.read<AuthCubit>().resetPassword(
              token: token,
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
                  FormField(
                    key: _newPasswordKey,
                    label: DefaultText(
                      'New Password',
                      fontWeight: FontWeight.w500,
                    ),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _newPasswordFn,
                      placeholder: const Text('********'),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormField(
                    key: _confirmPasswordKey,
                    label: DefaultText(
                      'Confirm Password',
                      fontWeight: FontWeight.w500,
                    ),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _confirmPasswordFn,
                      placeholder: const Text('********'),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
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
                                'Reset Password',
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
                        'Remember your password?',
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
