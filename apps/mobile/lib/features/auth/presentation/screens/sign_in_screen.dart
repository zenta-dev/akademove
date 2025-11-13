import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
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
                      const Text("Let's Sign In to the AkadeMove!").h4,
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Sign In Failed',
              message: state.error?.message ?? 'Unknown error',
            ),
            location: ToastLocation.topCenter,
          );
        }
        if (state.isSuccess) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Sign In Success',
              message: state.message ?? 'Successfully signed in',
            ),
            location: ToastLocation.topCenter,
          );
          switch (state.data?.role) {
            case UserRole.user:
              context.pushReplacementNamed(Routes.userHome.name);
            case UserRole.merchant:
              context.pushReplacementNamed(Routes.merchantHome.name);
            case UserRole.driver:
              context.pushReplacementNamed(Routes.driverHome.name);
            case UserRole.admin:
            case UserRole.operator_:
            case null:
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        }
      },
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) async {
            if (state.isLoading) return;
            final email = _emailKey[values];
            final password = _passwordKey[values];
            if (email == null || password == null) return;

            await context.read<SignInCubit>().signIn(email, password);
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
                    label: const Text('Email'),
                    validator: _emailValidator,
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _emailFn,
                      placeholder: const Text('john@gmail.com'),
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
                        const Text('Password'),
                        Button.link(
                          onPressed: () {
                            context.pushNamed(Routes.authForgotPassword.name);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: context.theme.typography.small.copyWith(
                              color: const Color(0xFF3B82F6),
                            ),
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
                      placeholder: const Text('********'),
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
                            : Text(
                                'Sign In',
                                style: context.theme.typography.medium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4.w,
                    children: [
                      const Text("Didn't have an account?").small.muted,
                      Button(
                        style: const ButtonStyle.link(
                          size: ButtonSize.small,
                          density: ButtonDensity.compact,
                        ),
                        onPressed: () {
                          context.pushNamed(Routes.authSignUpChoice.name);
                        },
                        child: Text(
                          'Sign Up',
                          style: context.theme.typography.small.copyWith(
                            color: const Color(0xFF3B82F6),
                          ),
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
