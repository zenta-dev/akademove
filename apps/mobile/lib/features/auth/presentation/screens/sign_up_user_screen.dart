import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/gen/assets.gen.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

class SignUpUserScreen extends StatelessWidget {
  const SignUpUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            spacing: 16.h,
            children: [
              Assets.images.hero.signUpUser.svg(height: 200.h),
              Text(
                context.l10n.user_sign_up,
                textAlign: TextAlign.center,
                style: context.theme.typography.h3.copyWith(fontSize: 20.sp),
              ),
              const _SignUpUserFormView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpUserFormView extends StatefulWidget {
  const _SignUpUserFormView();

  @override
  State<_SignUpUserFormView> createState() => _SignUpUserFormViewState();
}

class _SignUpUserFormViewState extends State<_SignUpUserFormView> {
  static const FormKey<String> _nameKey = TextFieldKey("name");
  static const FormKey<String> _emailKey = TextFieldKey("email");
  static const FormKey<String> _passwordKey = TextFieldKey("password");
  static const FormKey<String> _confirmPasswordKey = TextFieldKey(
    "confirm_password",
  );

  UserGender _selectedGender = UserGender.MALE;
  CountryCode _selectedCountryCode = CountryCode.ID;
  String? _phoneNumber;
  bool _termsAccepted = false;
  String _submittedEmail = "";

  void _handleSignUpSuccess(BuildContext context, AuthState state) {
    context.showMyToast(
      state.user.message ?? context.l10n.success_sign_up,
      type: ToastType.success,
    );
    context.pushReplacementNamed(
      Routes.authEmailVerificationPending.name,
      queryParameters: {"email": _submittedEmail},
    );
  }

  void _handleSignUpFailure(BuildContext context, AuthState state) {
    context.showMyToast(
      state.user.error?.message ?? context.l10n.error_unknown,
      type: ToastType.failed,
    );
  }

  void _handleFormSubmit(
    BuildContext context,
    Map<FormKey<dynamic>, dynamic> values,
    AuthState state,
  ) {
    if (state.user.isLoading) return;

    final name = _nameKey[values];
    final email = _emailKey[values];
    final password = _passwordKey[values];
    final confirmPassword = _confirmPasswordKey[values];
    final phoneNumber = _phoneNumber;

    if (name == null ||
        email == null ||
        password == null ||
        phoneNumber == null ||
        confirmPassword == null ||
        !_termsAccepted) {
      return;
    }

    _submittedEmail = email;
    context.read<AuthCubit>().signUpUser(
      name: name,
      email: email,
      phone: Phone(
        countryCode: _selectedCountryCode,
        number: int.parse(phoneNumber),
      ),
      gender: _selectedGender,
      password: password,
      confirmPassword: confirmPassword,
      photoPath: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.user.isFailure) {
          _handleSignUpFailure(context, state);
        }
        if (state.user.isSuccess) {
          _handleSignUpSuccess(context, state);
        }
      },
      builder: (context, state) {
        final isLoading = state.user.isLoading;

        return Form(
          onSubmit: (context, values) =>
              _handleFormSubmit(context, values, state),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.h,
            children: [
              AuthTextField(
                formKey: _nameKey,
                label: context.l10n.name,
                placeholder: context.l10n.placeholder_name,
                icon: LucideIcons.user,
                validator: const LengthValidator(min: 3),
                enabled: !isLoading,
              ),
              AuthTextField(
                formKey: _emailKey,
                label: context.l10n.email,
                placeholder: context.l10n.placeholder_email,
                icon: LucideIcons.mail,
                validator: const EmailValidator(),
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
              ),
              AuthGenderSelect(
                value: _selectedGender,
                enabled: !isLoading,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGender = value;
                    });
                  }
                },
              ),
              AuthPhoneField(
                enabled: !isLoading,
                onChanged: (countryCode, phoneNumber) {
                  setState(() {
                    _selectedCountryCode = countryCode;
                    _phoneNumber = phoneNumber;
                  });
                },
              ),
              AuthTextField(
                formKey: _passwordKey,
                label: context.l10n.password,
                placeholder: "********",
                icon: LucideIcons.key,
                validator: const SafePasswordValidator(),
                enabled: !isLoading,
                isPassword: true,
              ),
              AuthTextField(
                formKey: _confirmPasswordKey,
                label: context.l10n.confirm_password,
                placeholder: context.l10n.placeholder_confirm_password,
                icon: LucideIcons.key,
                validator: CompareWith.equal(
                  _passwordKey,
                  message: context.l10n.error_password_mismatch,
                ),
                enabled: !isLoading,
                isPassword: true,
              ),
              AuthTermsCheckbox(
                value: _termsAccepted,
                enabled: !isLoading,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value;
                  });
                },
              ),
              AuthSubmitButton(
                label: context.l10n.sign_up,
                isLoading: isLoading,
                isDisabled: !_termsAccepted,
              ),
            ],
          ),
        );
      },
    );
  }
}
