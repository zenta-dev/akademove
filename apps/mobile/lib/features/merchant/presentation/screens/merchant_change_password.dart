import 'package:akademove/core/_export.dart';

import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantChangePasswordScreen extends StatelessWidget {
  const MerchantChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyScaffold(
      headers: const [
        DefaultAppBar(title: 'Change Password'),
      ],
      body: Card(
        padding: EdgeInsets.all(8.dg),
        child: SizedBox(
          width: size.width.w,
          child: const _ChangePasswordFormView(),
        ),
      ).intrinsic(),
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

  late FocusNode _oldPasswordFn;
  late FocusNode _newPasswordFn;
  late FocusNode _confirmPasswordFn;

  @override
  void initState() {
    super.initState();
    _oldPasswordFn = FocusNode();
    _newPasswordFn = FocusNode();
    _confirmPasswordFn = FocusNode();
  }

  @override
  void dispose() {
    _oldPasswordFn.dispose();
    _newPasswordFn.dispose();
    _confirmPasswordFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormField(
                key: _oldPasswordKey,
                label: const Text('Old Password'),
                validator: const LengthValidator(min: 8),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  focusNode: _oldPasswordFn,
                  placeholder: const Text('Enter your old password'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _newPasswordFn.requestFocus(),
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.key)),
                    InputFeature.passwordToggle(),
                  ],
                ),
              ),
              FormField(
                key: _newPasswordKey,
                label: const Text('New Password'),
                validator: const LengthValidator(min: 8),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  focusNode: _newPasswordFn,
                  placeholder: const Text('Enter your new password'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _confirmPasswordFn.requestFocus(),
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.key)),
                    InputFeature.passwordToggle(),
                  ],
                ),
              ),
              FormField(
                key: _confirmPasswordKey,
                label: const Text('Confirm Password'),
                validator: const LengthValidator(min: 8),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  focusNode: _confirmPasswordFn,
                  placeholder: const Text('Confirm your new password'),
                  textInputAction: TextInputAction.done,
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
            onPressed: () {},
            child: Text(
              'Save changes',
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
