import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                        context.l10n.forgot_password,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Text(
                        context.l10n.description_forgot_password,
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
                      child: const _ForgotPasswordFormView(),
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

class _ForgotPasswordFormView extends StatefulWidget {
  const _ForgotPasswordFormView();

  @override
  State<_ForgotPasswordFormView> createState() =>
      _ForgotPasswordFormViewState();
}

class _ForgotPasswordFormViewState extends State<_ForgotPasswordFormView> {
  final FormKey<String> _emailKey = const TextFieldKey('email');
  late FocusNode _emailFn;

  final _emailValidator = const EmailValidator();

  @override
  void initState() {
    super.initState();
    _emailFn = FocusNode();
  }

  @override
  void dispose() {
    _emailFn.dispose();
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
        context.pop();
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
            if (state.isLoading) return;
            final email = _emailKey[values];
            if (email == null) return;

            await context.read<AuthCubit>().forgotPassword(email);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.mail)),
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
                                context.l10n.send_reset_link,
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
