import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserChangePasswordScreen extends StatefulWidget {
  const UserChangePasswordScreen({super.key});

  @override
  State<UserChangePasswordScreen> createState() =>
      _UserChangePasswordScreenState();
}

class _UserChangePasswordScreenState extends State<UserChangePasswordScreen> {
  static const TextFieldKey _oldPasswordKey = TextFieldKey('oldPassword');
  static const TextFieldKey _newPasswordKey = TextFieldKey('newPassword');
  static const TextFieldKey _confirmNewPasswordKey = TextFieldKey(
    'confirmNewPassword',
  );

  late FocusNode _oldPasswordFn;
  late FocusNode _newPasswordFn;
  late FocusNode _confirmNewPasswordFn;

  @override
  void initState() {
    super.initState();
    _oldPasswordFn = FocusNode();
    _newPasswordFn = FocusNode();
    _confirmNewPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _oldPasswordFn.dispose();
    _newPasswordFn.dispose();
    _confirmNewPasswordFn.dispose();
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    final cubit = context.read<UserProfileCubit>();
    if (cubit.state.updatePasswordResult.isLoading) return;

    final oldPassword = _oldPasswordKey[values];
    final newPassword = _newPasswordKey[values];
    final confirmNewPassword = _confirmNewPasswordKey[values];

    if (oldPassword == null ||
        newPassword == null ||
        confirmNewPassword == null) {
      return;
    }

    cubit.updatePassword(
      UserMeChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.title_change_password)],
      body: Form(
        onSubmit: _handleFormSubmit,
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            state.updatePasswordResult.whenOr(
              success: (result, message) {
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
          builder: (context, state) {
            final isLoading = state.updatePasswordResult.isLoading;
            return Column(
              spacing: 8.h,
              children: [
                FormField(
                  key: _oldPasswordKey,
                  label: Text(context.l10n.label_old_password).small(),
                  validator: const LengthValidator(min: 8),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    enabled: !isLoading,
                    focusNode: _oldPasswordFn,
                    placeholder: Text(context.l10n.placeholder_old_password),
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.password],
                    onSubmitted: (value) {
                      _newPasswordFn.requestFocus();
                    },
                    features: const [
                      InputFeature.leading(Icon(LucideIcons.key)),
                      InputFeature.passwordToggle(),
                    ],
                  ),
                ),
                FormField(
                  key: _newPasswordKey,
                  label: Text(context.l10n.label_new_password).small(),
                  validator: const LengthValidator(min: 8),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    enabled: !isLoading,
                    focusNode: _newPasswordFn,
                    placeholder: Text(context.l10n.placeholder_new_password),
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    onSubmitted: (value) {
                      _confirmNewPasswordFn.requestFocus();
                    },
                    features: const [
                      InputFeature.leading(Icon(LucideIcons.key)),
                      InputFeature.passwordToggle(),
                    ],
                  ),
                ),
                FormField(
                  key: _confirmNewPasswordKey,
                  label: Text(context.l10n.label_confirm_new_password).small(),
                  validator: const LengthValidator(min: 8),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    enabled: !isLoading,
                    focusNode: _confirmNewPasswordFn,
                    placeholder: Text(
                      context.l10n.placeholder_confirm_new_password,
                    ),
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    features: const [
                      InputFeature.leading(Icon(LucideIcons.key)),
                      InputFeature.passwordToggle(),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FormErrorBuilder(
                    builder: (context, errors, child) {
                      final hasErrors = errors.isNotEmpty;

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
                                style: context.theme.typography.medium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
