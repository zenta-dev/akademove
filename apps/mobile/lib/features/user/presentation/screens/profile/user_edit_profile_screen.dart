import 'dart:io' show File;

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' show TextInputAction;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  static const TextFieldKey _nameKey = TextFieldKey('name');
  static const TextFieldKey _emailKey = TextFieldKey('email');
  static const TextFieldKey _phoneKey = TextFieldKey('phone');

  static const Set<FormValidationMode> _showErrors = {
    FormValidationMode.changed,
    FormValidationMode.submitted,
  };

  late FocusNode _nameFn;
  late FocusNode _emailFn;

  static const _emailValidator = EmailValidator();

  CountryCode _selectedCountryCode = CountryCode.ID;

  File? _pickedPhoto;

  @override
  void initState() {
    super.initState();

    _nameFn = FocusNode();
    _emailFn = FocusNode();
  }

  @override
  void dispose() {
    _nameFn.dispose();
    _emailFn.dispose();
    super.dispose();
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    final cubit = context.read<UserProfileCubit>();
    if (cubit.state.isLoading) return;

    final name = _nameKey[values];
    final email = _emailKey[values];
    final phone = _phoneKey[values];
    final parsedPhone = int.tryParse(phone ?? '');

    cubit.updateProfile(
      UpdateProfileRequest(
        name: name,
        email: email,
        photoPath: _pickedPhoto?.path,
        phone: parsedPhone != null
            ? Phone(countryCode: _selectedCountryCode, number: parsedPhone)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.title_edit_profile)],
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return BlocConsumer<UserProfileCubit, UserProfileState>(
            listener: (context, profileState) {
              profileState.whenOr(
                success: (message) {
                  if (profileState.updateProfileResult == null) return;
                  context.showMyToast(message, type: ToastType.success);
                  delay(const Duration(seconds: 3), () {
                    context.read<UserProfileCubit>().reset();
                    context.read<AuthCubit>().authenticate();
                    context.pop();
                  });
                },
                failure: (error) {
                  context.showMyToast(error.message, type: ToastType.failed);
                },
                orElse: noop,
              );
            },
            builder: (context, profileState) {
              return Form(
                onSubmit: _handleFormSubmit,
                child: Column(
                  spacing: 8.h,
                  children: [
                    Column(
                      spacing: 8.h,
                      children: [
                        Text(context.l10n.label_photo_profile).small(),
                        ImagePickerWidget(
                          enabled: !profileState.isLoading,
                          previewUrl: authState.data?.image,
                          value: _pickedPhoto,
                          size: Size(86.h, 86.h),
                          onValueChanged: (file) =>
                              setState(() => _pickedPhoto = file),
                        ),
                      ],
                    ),
                    FormField(
                      key: _nameKey,
                      label: Text(context.l10n.label_name).small(),
                      showErrors: _showErrors,
                      child: TextField(
                        enabled: !profileState.isLoading,
                        focusNode: _nameFn,
                        initialValue: authState.data?.name,
                        placeholder: Text(
                          authState.data?.name ??
                              context.l10n.placeholder_full_name,
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        onSubmitted: (value) {
                          _emailFn.requestFocus();
                        },
                        features: const [
                          InputFeature.leading(Icon(LucideIcons.user)),
                        ],
                      ),
                    ),
                    FormField(
                      key: _emailKey,
                      label: Text(context.l10n.label_email).small(),
                      validator: _emailValidator,
                      showErrors: _showErrors,
                      child: TextField(
                        enabled: !profileState.isLoading,
                        focusNode: _emailFn,
                        initialValue: authState.data?.email,
                        placeholder: Text(
                          authState.data?.email ?? 'john@gmail.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],

                        features: const [
                          InputFeature.leading(Icon(LucideIcons.mail)),
                        ],
                      ),
                    ),
                    FormField(
                      key: _phoneKey,
                      label: Text(context.l10n.label_phone).small(),
                      showErrors: const {
                        FormValidationMode.changed,
                        FormValidationMode.submitted,
                      },
                      child: ComponentTheme(
                        data: PhoneInputTheme(
                          maxWidth: 200 * context.theme.scaling,
                          flagWidth: 22.w,
                        ),
                        child: PhoneInput(
                          initialCountry: Country.indonesia,
                          countries: const [Country.indonesia],
                          initialValue: authState.data?.phone.toPhoneNumber(),
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
                    SizedBox(
                      width: double.infinity,
                      child: FormErrorBuilder(
                        builder: (context, errors, child) {
                          final hasErrors = errors.isNotEmpty;
                          final isLoading = profileState.isLoading;

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
                                    context.l10n.button_save_changes,
                                    style: context.theme.typography.medium
                                        .copyWith(color: Colors.white),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
