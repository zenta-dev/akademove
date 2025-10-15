import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
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
          Assets.images.hero.signUpUser.svg(
            height: 200.h,
          ),
          Text(
            'Sign up now — your next ride or meal is just a tap away 🚴‍♂️🍔',
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
  static const FormKey<UserGenderEnum> _genderKey = SelectKey(
    UserGenderEnum.male,
  );
  static const FormKey<String> _phoneKey = TextFieldKey('phone');
  static const FormKey<String> _passwordKey = TextFieldKey('password');
  static const FormKey<String> _confirmPasswordKey = TextFieldKey(
    'confirm_password',
  );

  UserGenderEnum _selectedGender = UserGenderEnum.male;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.isFailure) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Sign Up Failed',
              message: state.error?.message ?? 'Unknown error',
            ),
            location: ToastLocation.topCenter,
          );
        }
        if (state.isSuccess) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Sign Up Success',
              message: state.message ?? 'Successfully signed up',
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
            final phone = _phoneKey[values];
            final password = _passwordKey[values];
            final confirmPassword = _confirmPasswordKey[values];
            if (name == null ||
                email == null ||
                phone == null ||
                password == null ||
                confirmPassword == null) {
              return;
            }

            context.read<SignUpCubit>().signUpUser(
              name: name,
              email: email,
              phone: phone,
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
                label: const Text('Name'),
                validator: const LengthValidator(min: 3),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: const Text('John Doe'),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.user)),
                  ],
                ),
              ),
              FormField(
                key: _emailKey,
                label: const Text('Email'),
                validator: const EmailValidator(),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: const Text('john@gmail.com'),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.mail)),
                  ],
                ),
              ),
              FormField(
                key: _genderKey,
                label: const Text('Gender'),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Select<UserGenderEnum>(
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
                    popup: SelectPopup<UserGenderEnum>(
                      items: SelectItemList(
                        children: UserGenderEnum.values
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
                key: _phoneKey,
                label: const Text('Phone'),
                validator: const LengthValidator(min: 10),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: ComponentTheme(
                  data: PhoneInputTheme(
                    maxWidth: 216 * context.theme.scaling,
                    flagWidth: 22.w,
                  ),
                  child: const PhoneInput(
                    initialCountry: Country.indonesia,
                    countries: [Country.indonesia],
                  ),
                ),
              ),
              FormField(
                key: _passwordKey,
                label: const Text('Password'),
                validator: const SafePasswordValidator(),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: const Text('*******'),
                  enabled: !state.isLoading,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.key)),
                    InputFeature.passwordToggle(),
                  ],
                ),
              ),
              FormField(
                key: _confirmPasswordKey,
                label: const Text('Confirm Password'),
                validator: const CompareWith<String>.equal(_passwordKey),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  placeholder: const Text('*******'),
                  enabled: !state.isLoading,
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
                            'Sign Up',
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
