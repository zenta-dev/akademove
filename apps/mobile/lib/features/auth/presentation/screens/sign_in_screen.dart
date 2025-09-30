import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  ? Colors.neutral.shade100
                  : Colors.neutral.shade900,
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          showToast(
            context: context,
            builder: (context, overlay) => buildToast(
              context,
              overlay,
              state.error?.message ?? 'Unknown error',
            ),
            location: ToastLocation.topRight,
          );
        }
      },
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) async {
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
                    validator: const EmailValidator(),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: const TextField(
                      placeholder: Text('john@gmail.com'),
                      features: [
                        InputFeature.leading(Icon(LucideIcons.mail)),
                      ],
                    ),
                  ),
                  FormField(
                    key: _passwordKey,
                    label: const Text('Password'),
                    // validator: const SafePasswordValidator(),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: const TextField(
                      placeholder: Text('********'),
                      features: [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormErrorBuilder(
                    builder: (context, errors, child) {
                      return PrimaryButton(
                        onPressed: errors.isEmpty
                            ? () => context.submitForm()
                            : null,
                        child: const Text('Submit'),
                      );
                    },
                  ),
                ],
              ).gap(12.h),
            ],
          ),
        );
      },
    );
  }

  Widget buildToast(
    BuildContext context,
    ToastOverlay overlay,
    String message,
  ) {
    return SurfaceCard(
      child: Basic(
        title: const Text('Sign In Failed'),
        subtitle: Text(message),
        trailingAlignment: Alignment.center,
      ),
    );
  }
}
