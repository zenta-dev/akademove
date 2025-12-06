import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantChangePasswordScreen extends StatelessWidget {
  const MerchantChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => sl<UserProfileCubit>(),
      child: MyScaffold(
        headers: [DefaultAppBar(title: context.l10n.title_change_password)],
        body: Card(
          padding: EdgeInsets.all(8.dg),
          child: SizedBox(
            width: size.width.w,
            child: const _ChangePasswordFormView(),
          ),
        ).intrinsic(),
      ),
    );
  }
}

class _ChangePasswordFormView extends StatefulWidget {
  const _ChangePasswordFormView();

  @override
  State<_ChangePasswordFormView> createState() =>
      _ChangePasswordFormViewState();
}

class _ChangePasswordFormViewState extends State<_ChangePasswordFormView> {
  final FormKey<String> _oldPasswordKey = const TextFieldKey('oldPassword');
  final FormKey<String> _newPasswordKey = const TextFieldKey('newPassword');
  final FormKey<String> _confirmPasswordKey = const TextFieldKey(
    'confirmPassword',
  );

  late FormController _formController;
  late FocusNode _oldPasswordFn;
  late FocusNode _newPasswordFn;
  late FocusNode _confirmPasswordFn;

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _oldPasswordFn = FocusNode();
    _newPasswordFn = FocusNode();
    _confirmPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    _formController.dispose();
    _oldPasswordFn.dispose();
    _newPasswordFn.dispose();
    _confirmPasswordFn.dispose();
    super.dispose();
  }

  Future<void> _handleChangePassword() async {
    // Validate form
    if (_formController.errors.isNotEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    final values = _formController.values;
    final oldPassword = _oldPasswordKey[values];
    final newPassword = _newPasswordKey[values];
    final confirmPassword = _confirmPasswordKey[values];

    if (oldPassword == null || oldPassword.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.label_old_password,
      );
      return;
    }

    if (newPassword == null || newPassword.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.label_new_password,
      );
      return;
    }

    if (confirmPassword == null || confirmPassword.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.label_confirm_password,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_password_mismatch,
      );
      return;
    }

    // Call the cubit to update password
    final cubit = context.read<UserProfileCubit>();
    await cubit.updatePassword(
      UserMeChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmPassword,
      ),
    );

    if (!mounted) return;

    final state = cubit.state;
    if (state.isSuccess) {
      _showToast(
        context.l10n.success,
        state.message ?? context.l10n.toast_success,
      );
      // Navigate back after successful password change
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          context.pop();
        }
      });
    } else if (state.isFailure) {
      _showToast(
        context.l10n.error,
        state.error?.message ?? context.l10n.an_error_occurred,
      );
    }
  }

  void _showToast(String title, String message) {
    if (!mounted) return;
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        final isLoading = state.isLoading;

        return Form(
          controller: _formController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField(
                    key: _oldPasswordKey,
                    label: Text(context.l10n.label_old_password),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _oldPasswordFn,
                      placeholder: Text(context.l10n.placeholder_old_password),
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                      onSubmitted: (_) => _newPasswordFn.requestFocus(),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormField(
                    key: _newPasswordKey,
                    label: Text(context.l10n.label_new_password),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _newPasswordFn,
                      placeholder: Text(context.l10n.placeholder_new_password),
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                      onSubmitted: (_) => _confirmPasswordFn.requestFocus(),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                  FormField(
                    key: _confirmPasswordKey,
                    label: Text(context.l10n.label_confirm_password),
                    validator: const LengthValidator(min: 8),
                    showErrors: const {
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: TextField(
                      focusNode: _confirmPasswordFn,
                      placeholder: Text(
                        context.l10n.placeholder_confirm_password,
                      ),
                      textInputAction: TextInputAction.done,
                      enabled: !isLoading,
                      onSubmitted: (_) => _handleChangePassword(),
                      features: const [
                        InputFeature.leading(Icon(LucideIcons.key)),
                        InputFeature.passwordToggle(),
                      ],
                    ),
                  ),
                ],
              ).gap(12.h),
              SizedBox(height: 24.h),
              Button.primary(
                onPressed: isLoading ? null : _handleChangePassword,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        context.l10n.save_changes,
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
