import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SignUpUserScreen extends StatelessWidget {
  const SignUpUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
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
    );
  }
}

class _SignUpUserFormView extends StatefulWidget {
  const _SignUpUserFormView();

  @override
  State<_SignUpUserFormView> createState() => _SignUpUserFormViewState();
}

class _SignUpUserFormViewState extends State<_SignUpUserFormView> {
  static const FormKey<String> _nameKey = TextFieldKey('name');
  static const FormKey<String> _emailKey = TextFieldKey('email');
  static const FormKey<UserGender> _genderKey = SelectKey(UserGender.MALE);
  static const FormKey<String> _phoneNumberKey = TextFieldKey('phone-number');
  static const FormKey<String> _passwordKey = TextFieldKey('password');
  static const FormKey<String> _confirmPasswordKey = TextFieldKey(
    'confirm_password',
  );

  UserGender _selectedGender = UserGender.MALE;
  CountryCode _selectedCountryCode = CountryCode.ID;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.isFailure) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: context.l10n.sign_up_failed,
              message: state.error?.message ?? context.l10n.error_unknown,
            ),
            location: ToastLocation.topCenter,
          );
        }
        if (state.isSuccess) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: context.l10n.sign_up_success,
              message: state.message ?? context.l10n.success_sign_up,
            ),
            location: ToastLocation.topCenter,
          );
          context.read<SignUpCubit>().reset();
          context.pushReplacementNamed(Routes.authSignIn.name);
        }
      },
      builder: (context, state) {
        return Form(
          onSubmit: (context, values) {
            if (state.isLoading) return;
            final name = _nameKey[values];
            final email = _emailKey[values];
            final phoneNumber = _phoneNumberKey[values];
            final password = _passwordKey[values];
            final confirmPassword = _confirmPasswordKey[values];
            if (name == null ||
                email == null ||
                phoneNumber == null ||
                password == null ||
                confirmPassword == null ||
                !_termsAccepted) {
              return;
            }

            context.read<SignUpCubit>().signUpUser(
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
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.h,
            children: [
              FormField(
                key: _nameKey,
                label: Text(context.l10n.name),
                validator: const LengthValidator(min: 3),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: Text(context.l10n.placeholder_password),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.user)),
                  ],
                ),
              ),
              FormField(
                key: _emailKey,
                label: Text(context.l10n.email),
                validator: const EmailValidator(),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: Text(context.l10n.placeholder_email),
                  enabled: !state.isLoading,
                  keyboardType: TextInputType.emailAddress,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.mail)),
                  ],
                ),
              ),
              FormField(
                key: _genderKey,
                label: Text(context.l10n.gender),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Select<UserGender>(
                    enabled: !state.isLoading,
                    itemBuilder: (context, item) {
                      return Text(item.name);
                    },
                    value: _selectedGender,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedGender = value;
                        });
                      }
                    },
                    popup: SelectPopup<UserGender>(
                      items: SelectItemList(
                        children: UserGender.values
                            .map(
                              (e) => SelectItemButton(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                    ).call,
                  ),
                ),
              ),
              FormField(
                key: _phoneNumberKey,
                label: Text(context.l10n.phone),
                validator: const LengthValidator(min: 10),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: ComponentTheme(
                  data: PhoneInputTheme(
                    maxWidth: 212 * context.theme.scaling,
                    flagWidth: 22.w,
                  ),
                  child: PhoneInput(
                    initialCountry: Country.indonesia,
                    countries: const [Country.indonesia],
                    onChanged: (value) {
                      switch (value.country) {
                        case Country.indonesia:
                          _selectedCountryCode = CountryCode.ID;
                        default:
                      }
                    },
                  ),
                ),
              ),
              FormField(
                key: _passwordKey,
                label: Text(context.l10n.password),
                validator: const SafePasswordValidator(),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: Text("********"),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.key)),
                    InputFeature.passwordToggle(),
                  ],
                ),
              ),
              FormField(
                key: _confirmPasswordKey,
                label: Text(context.l10n.confirm_password),
                // validator: const CompareWith<String>.equal(_passwordKey),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: Text(context.l10n.placeholder_confirm_password),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.key)),
                    InputFeature.passwordToggle(),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.w,
                children: [
                  Checkbox(
                    state: _termsAccepted
                        ? CheckboxState.checked
                        : CheckboxState.unchecked,
                    enabled: !state.isLoading,
                    onChanged: (checkboxState) {
                      setState(() {
                        _termsAccepted = checkboxState == CheckboxState.checked;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await context.pushNamed(Routes.termsOfService.name);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: context.theme.typography.small.copyWith(
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(text: context.l10n.i_agree_to_the),
                            TextSpan(
                              text: ' ${context.l10n.terms_and_conditions}',
                              style: TextStyle(
                                color: context.theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                            context.l10n.sign_up,
                            style: context.theme.typography.medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
