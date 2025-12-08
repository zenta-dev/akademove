import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                        context.l10n.lets_sign_in_to_the_akademove,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ).gap(8.h),
                  Gap(16.h),
                  Card(
                    padding: EdgeInsets.all(8.dg),
                    child: SizedBox(
                      width: size.width.w,
                      child: const _SignInFormView(),
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

class _SignInFormView extends StatefulWidget {
  const _SignInFormView();

  @override
  State<_SignInFormView> createState() => _SignInFormViewState();
}

class _SignInFormViewState extends State<_SignInFormView> {
  final FormKey<String> _emailKey = const TextFieldKey('email');
  final FormKey<String> _passwordKey = const TextFieldKey('password');
  late FocusNode _emailFn;
  late FocusNode _passwordFn;

  final _emailValidator = const EmailValidator();

  @override
  void initState() {
    super.initState();
    _emailFn = FocusNode();
    _passwordFn = FocusNode();
  }

  @override
  void dispose() {
    _emailFn.dispose();
    _passwordFn.dispose();
    super.dispose();
  }

  Future<void> handleEvent(BuildContext context, AuthState state) async {
    if (state.user.isFailure) {
      context.showMyToast(state.user.error?.message, type: ToastType.failed);
    }
    if (state.user.isSuccess) {
      context.showMyToast(state.user.message, type: ToastType.success);
      await delay(const Duration(seconds: 1), () {});
      if (context.mounted) {
        switch (state.user.data?.value.role) {
          case UserRole.USER:
            context.pushReplacementNamed(Routes.userHome.name);
          case UserRole.MERCHANT:
            context.pushReplacementNamed(Routes.merchantHome.name);
          case UserRole.DRIVER:
            if (state.driver.data?.value == null) {
              context.pushReplacementNamed(Routes.authSignIn.name);
              return;
            }
            if (state.driver.data?.value?.quizStatus !=
                DriverQuizStatus.PASSED) {
              context.pushReplacementNamed(Routes.driverQuiz.name);
              return;
            }
            context.pushReplacementNamed(Routes.driverHome.name);
          case UserRole.ADMIN:
          case UserRole.OPERATOR:
          case null:
            context.showMyToast(
              context.l10n.unsupported_role_desc,
              type: ToastType.failed,
            );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: handleEvent,
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) async {
            if (state.user.isLoading) return;
            final email = _emailKey[values];
            final password = _passwordKey[values];
            if (email == null || password == null) return;

            await context.read<AuthCubit>().signIn(email, password);
          },

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField(
                    key: _emailKey,
                    label: DefaultText(
                      context.l10n.email,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: _emailValidator,
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _emailFn,
                      placeholder: Text(context.l10n.placeholder_email),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        final err = _emailValidator.validate(
                          context,
                          value,
                          FormValidationMode.submitted,
                        );
                        if (err == null) _passwordFn.requestFocus();
                      },
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.mail)),
                      ],
                    ),
                  ),
                  FormField(
                    key: _passwordKey,
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          context.l10n.password,
                          fontWeight: FontWeight.w500,
                        ),
                        LinkButton(
                          density: ButtonDensity.compact,
                          onPressed: () async {
                            await context.pushNamed(
                              Routes.authForgotPassword.name,
                            );
                          },
                          child: DefaultText(
                            context.l10n.forget_password,
                            fontSize: 14.sp,
                            color: const Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                    // validator: const SafePasswordValidator(),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _passwordFn,
                      placeholder: Text(context.l10n.placeholder_password),
                      textInputAction: TextInputAction.done,
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormErrorBuilder(
                    builder: (context, errors, child) {
                      final hasErrors = errors.isNotEmpty;
                      final isLoading = state.user.isLoading;

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
                                context.l10n.sign_in,
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
                        context.l10n.didnt_have_account,
                        fontSize: 14.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                      Button(
                        style: const ButtonStyle.link(
                          size: ButtonSize.small,
                          density: ButtonDensity.compact,
                        ),
                        onPressed: () async {
                          await context.pushNamed(Routes.authSignUpChoice.name);
                        },
                        child: DefaultText(
                          context.l10n.sign_up,
                          fontSize: 14.sp,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ],
              ).gap(12.h),
            ],
          ),
        );
      },
    );
  }
}
