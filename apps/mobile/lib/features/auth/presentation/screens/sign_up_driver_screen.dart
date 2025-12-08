import 'dart:io';

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

enum Step2Docs { photo, studentCard, driverLicense }

enum Step3Docs { vehicleRegistration }

// Form Keys Configuration
class _FormKeys {
  static const FormKey<String> step1Name = TextFieldKey('step-1-name');
  static const FormKey<String> step1Email = TextFieldKey('step-1-email');
  static const FormKey<String> step1StudentId = TextFieldKey(
    'step-1-student_id',
  );
  static const FormKey<String> step1PhoneNumber = TextFieldKey(
    'step-1-phone-number',
  );
  static const FormKey<String> step1Password = TextFieldKey('step-1-password');
  static const FormKey<String> step1ConfirmPassword = TextFieldKey(
    'step-1-confirm_password',
  );
  static const FormKey<String> step3LicensePlate = TextFieldKey(
    'step-3-license-plate',
  );
  static const FormKey<String> step4BankNumber = TextFieldKey(
    'step-4-bank-number',
  );
}

class SignUpDriverScreen extends StatefulWidget {
  const SignUpDriverScreen({super.key});

  @override
  State<SignUpDriverScreen> createState() => _SignUpDriverScreenState();
}

class _SignUpDriverScreenState extends State<SignUpDriverScreen> {
  late final ScrollController _scrollController;
  late final FormController _formController;
  late final StepperController _stepController;

  UserGender _selectedGender = UserGender.MALE;
  BankProvider? _selectedBankProvider;
  CountryCode _selectedCountryCode = CountryCode.ID;
  bool _termsAccepted = false;
  String? _submittedEmail;

  final Map<Step2Docs, File?> _step2Docs = {
    for (var doc in Step2Docs.values) doc: null,
  };

  final Map<Step2Docs, String?> _step2DocsErrors = {
    for (var doc in Step2Docs.values) doc: null,
  };

  final Map<Step3Docs, File?> _step3Docs = {
    for (var doc in Step3Docs.values) doc: null,
  };

  final Map<Step3Docs, String?> _step3DocsErrors = {
    for (var doc in Step3Docs.values) doc: null,
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formController = FormController();
    _stepController = StepperController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _formController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  bool _validateStep(int stepIndex, bool Function() validator) {
    final isValid = validator();
    _stepController.setStatus(stepIndex, isValid ? null : StepState.failed);
    if (!isValid) _stepController.jumpToStep(stepIndex);
    return isValid;
  }

  bool _validateFormFields<T>(List<FormKey<T>> keys) {
    return keys.every((key) => _formController.errors[key] == null);
  }

  bool _validateDocuments<T>(Map<T, File?> docs, Map<T, String?> errors) {
    errors.updateAll((key, value) => null);
    docs.forEach((key, file) {
      if (file == null) errors[key] = context.l10n.error_file_required;
    });
    return !errors.values.any((error) => error != null);
  }

  bool get _isStep1Valid => _validateStep(
    0,
    () => _validateFormFields([
      _FormKeys.step1Name,
      _FormKeys.step1Email,
      _FormKeys.step1StudentId,
      _FormKeys.step1PhoneNumber,
      _FormKeys.step1Password,
      _FormKeys.step1ConfirmPassword,
    ]),
  );

  bool get _isStep2Valid =>
      _validateStep(1, () => _validateDocuments(_step2Docs, _step2DocsErrors));

  bool get _isStep3Valid => _validateStep(2, () {
    final hasFileErrors = !_validateDocuments(_step3Docs, _step3DocsErrors);
    final hasFormError =
        _formController.errors[_FormKeys.step3LicensePlate] != null;
    return !hasFileErrors && !hasFormError;
  });

  bool get _isStep4Valid =>
      _validateStep(3, () => _validateFormFields([_FormKeys.step4BankNumber]));

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _handleSignUpSuccess(
    BuildContext context,
    String? message,
    String email,
  ) {
    context.showMyToast(
      message ?? context.l10n.sign_up_success,
      type: ToastType.success,
    );
    context.read<AuthCubit>().reset();
    // Redirect to driver quiz (required before accessing driver features)
    // Driver must complete and pass quiz before being approved by operator
    context.pushReplacementNamed(Routes.driverQuiz.name);
  }

  void _handleSignUpFailure(BuildContext context, String? error) {
    context.showMyToast(error ?? context.l10n.an_error_occurred);
    // Reset immediately - delay was ineffective (unawaited Future)
    context.read<AuthCubit>().reset();
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    if (!_isStep4Valid) return;
    final cubit = context.read<AuthCubit>();
    if (cubit.state.user.isLoading) return;

    final formData = _extractFormData(values);
    if (formData == null) return;

    _submittedEmail = formData['email'];

    final photo = _step2Docs[Step2Docs.photo];
    final studentCard = _step2Docs[Step2Docs.studentCard];
    final driverLicense = _step2Docs[Step2Docs.driverLicense];
    final vehicleCertificate = _step3Docs[Step3Docs.vehicleRegistration];
    final bankProvider = _selectedBankProvider;

    if (photo == null ||
        studentCard == null ||
        driverLicense == null ||
        vehicleCertificate == null ||
        bankProvider == null) {
      return;
    }

    cubit.signUpDriver(
      name: formData['name']!,
      email: formData['email']!,
      phone: Phone(
        countryCode: _selectedCountryCode,
        number: int.parse(formData['phoneNumber']!),
      ),
      gender: _selectedGender,
      password: formData['password']!,
      confirmPassword: formData['confirmPassword']!,
      photoPath: photo.path,
      studentId: int.parse(formData['studentId']!),
      licensePlate: formData['licensePlate']!,
      studentCardPath: studentCard.path,
      driverLicensePath: driverLicense.path,
      vehicleCertificatePath: vehicleCertificate.path,
      bankProvider: bankProvider,
      bankNumber: int.parse(formData['bankNumber']!),
    );
  }

  Map<String, String>? _extractFormData<T>(Map<FormKey<T>, dynamic> values) {
    final name = _FormKeys.step1Name[values];
    final email = _FormKeys.step1Email[values];
    final studentId = _FormKeys.step1StudentId[values];
    final phoneNumber = _FormKeys.step1PhoneNumber[values];
    final password = _FormKeys.step1Password[values];
    final confirmPassword = _FormKeys.step1ConfirmPassword[values];
    final licensePlate = _FormKeys.step3LicensePlate[values];
    final bankNumber = _FormKeys.step4BankNumber[values];

    if (!_termsAccepted ||
        name == null ||
        email == null ||
        studentId == null ||
        phoneNumber == null ||
        password == null ||
        confirmPassword == null ||
        _step2Docs.values.any((v) => v == null) ||
        licensePlate == null ||
        _step3Docs.values.any((v) => v == null) ||
        _selectedBankProvider == null ||
        bankNumber == null) {
      return null;
    }

    return {
      'name': name,
      'email': email,
      'studentId': studentId,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'licensePlate': licensePlate,
      'bankNumber': bankNumber,
    };
  }

  void _handleStepNavigation({
    required bool isNext,
    required bool Function() validator,
  }) {
    _scrollToTop();
    if (isNext) {
      if (validator()) _stepController.nextStep();
    } else {
      _stepController.previousStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      controller: _scrollController,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.user.isFailure) {
            _handleSignUpFailure(context, state.user.error?.message);
          }
          if (state.user.isSuccess) {
            final email = _submittedEmail;
            if (email != null) {
              _handleSignUpSuccess(context, state.user.message, email);
            }
          }
        },
        builder: (context, state) {
          return Form(
            controller: _formController,
            onSubmit: _handleFormSubmit,
            child: Column(
              children: [
                Gap(12.h),
                Stepper(
                  controller: _stepController,
                  direction: Axis.horizontal,
                  variant: StepVariant.line,
                  size: StepSize.small,
                  steps: [
                    _buildStep1(context, state),
                    _buildStep2(context, state),
                    _buildStep3(context, state),
                    _buildStep4(context, state),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Step _buildStep1(BuildContext context, AuthState state) {
    return Step(
      title: Text(context.l10n.step_1),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver1.image(height: 200.h),
        title: context.l10n.driver_sign_up_step1,
        content: [
          _buildTextField(
            key: _FormKeys.step1Name,
            label: context.l10n.name,
            placeholder: 'John Doe',
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 3),
            enabled: !state.user.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step1Email,
            label: context.l10n.email,
            placeholder: 'john@gmail.com',
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            keyboardType: TextInputType.emailAddress,
            enabled: !state.user.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step1StudentId,
            label: 'NIM',
            placeholder: '25051204020',
            icon: LucideIcons.hash,
            validator: const LengthValidator(min: 10, max: 20),
            keyboardType: TextInputType.number,
            enabled: !state.user.isLoading,
          ),
          _buildGenderSelect(state),
          _buildPhoneField(context, state),
          _buildTextField(
            key: _FormKeys.step1Password,
            label: context.l10n.password,
            placeholder: '*******',
            icon: LucideIcons.key,
            validator: const SafePasswordValidator(),
            enabled: !state.user.isLoading,
            isPassword: true,
          ),
          _buildTextField(
            key: _FormKeys.step1ConfirmPassword,
            label: context.l10n.confirm_password,
            placeholder: '*******',
            icon: LucideIcons.key,
            // validator: null,
            validator: CompareWith.equal(
              _FormKeys.step1Password,
              message: context.l10n.error_password_mismatch,
            ),
            enabled: !state.user.isLoading,
            isPassword: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: [
              Checkbox(
                state: _termsAccepted
                    ? CheckboxState.checked
                    : CheckboxState.unchecked,
                enabled: !state.user.isLoading,
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
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.back,
            onPressed: () => context.pop(),
          ),
          _buildActionButton(
            icon: LucideIcons.arrowRight,
            label: context.l10n.next,
            isPrimary: true,
            isTrailing: true,
            onPressed: () => _handleStepNavigation(
              isNext: true,
              validator: () => _isStep1Valid,
            ),
          ),
        ],
      ),
    );
  }

  Step _buildStep2(BuildContext context, AuthState state) {
    return Step(
      title: Text(context.l10n.step_2),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver2.image(height: 200.h),
        title: context.l10n.driver_sign_up_step2,
        content: [
          _buildImagePicker(
            context.l10n.photo,
            Step2Docs.photo,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
          _buildImagePicker(
            context.l10n.student_card,
            Step2Docs.studentCard,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
          _buildImagePicker(
            context.l10n.driver_license,
            Step2Docs.driverLicense,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
        ],
        actions: _buildNavigationActions(() => _isStep2Valid),
      ),
    );
  }

  Step _buildStep3(BuildContext context, AuthState state) {
    return Step(
      title: Text(context.l10n.step_3),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver3.image(height: 200.h),
        title: context.l10n.driver_sign_up_step3,
        content: [
          _buildTextField(
            key: _FormKeys.step3LicensePlate,
            label: context.l10n.license_plate,
            placeholder: 'L 1234 AM',
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 6),
            enabled: !state.user.isLoading,
          ),
          _buildImagePicker(
            context.l10n.vehicle_registration,
            Step3Docs.vehicleRegistration,
            _step3Docs,
            _step3DocsErrors,
            context,
          ),
        ],
        actions: _buildNavigationActions(() => _isStep3Valid),
      ),
    );
  }

  Step _buildStep4(BuildContext context, AuthState state) {
    return Step(
      title: Text(context.l10n.step_4),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver4.image(height: 200.h),
        title: context.l10n.driver_sign_up_step4,
        content: [
          _buildBankProviderSelect(state),
          _buildTextField(
            key: _FormKeys.step4BankNumber,
            label: context.l10n.bank_account_number,
            placeholder: '11223344',
            keyboardType: TextInputType.number,
            icon: LucideIcons.wallet,
            validator: const LengthValidator(min: 5),
            enabled: !state.user.isLoading,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          _buildSubmitButton(state),
        ],
      ),
    );
  }

  Widget _buildStepContainer({
    required Widget heroImage,
    required String title,
    required List<Widget> content,
    required List<Widget> actions,
  }) {
    return StepContainer(
      actions: actions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: [
          heroImage,
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.theme.typography.h3.copyWith(fontSize: 20.sp),
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
    bool isTrailing = false,
  }) {
    final iconWidget = Icon(
      icon,
      size: 16.sp,
      color: isPrimary ? Colors.white : null,
    );
    final textWidget = Text(
      label,
      style: isPrimary
          ? context.theme.typography.small.copyWith(color: Colors.white)
          : null,
    );

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: isTrailing
          ? [textWidget, iconWidget]
          : [iconWidget, textWidget],
    );

    return Expanded(
      child: isPrimary
          ? PrimaryButton(onPressed: onPressed, child: content)
          : OutlineButton(onPressed: onPressed, child: content),
    );
  }

  List<Widget> _buildNavigationActions(bool Function() validator) {
    return [
      _buildActionButton(
        icon: LucideIcons.arrowLeft,
        label: context.l10n.back,
        onPressed: () =>
            _handleStepNavigation(isNext: false, validator: () => true),
      ),
      _buildActionButton(
        icon: LucideIcons.arrowRight,
        label: context.l10n.next,
        isPrimary: true,
        isTrailing: true,
        onPressed: () =>
            _handleStepNavigation(isNext: true, validator: validator),
      ),
    ];
  }

  Widget _buildSubmitButton(AuthState state) {
    return Expanded(
      child: FormErrorBuilder(
        builder: (context, errors, child) {
          final hasErrors = errors.isNotEmpty;
          final isLoading = state.user.isLoading;

          return Button(
            style: isLoading || hasErrors
                ? const ButtonStyle.outline()
                : const ButtonStyle.primary(),
            onPressed: (!hasErrors && !isLoading)
                ? () => context.submitForm()
                : null,
            child: isLoading
                ? const Submiting(simpleText: true)
                : Text(
                    context.l10n.submit,
                    style: context.theme.typography.medium.copyWith(
                      color: Colors.white,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildTextField<T>({
    required FormKey<String> key,
    required String label,
    required String placeholder,
    required IconData icon,
    required Validator<T> validator,
    required bool enabled,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return FormField(
      key: key,
      label: Text(label),
      validator: validator,
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: TextField(
        placeholder: Text(placeholder),
        enabled: enabled,
        keyboardType: keyboardType,
        features: [
          InputFeature.leading(Icon(icon)),
          if (isPassword) const InputFeature.passwordToggle(),
        ],
      ),
    );
  }

  Widget _buildGenderSelect(AuthState state) {
    return _buildEnumSelect<UserGender>(
      label: context.l10n.gender,
      placeholder: _selectedGender.value,
      value: _selectedGender,
      items: UserGender.values,
      enabled: !state.user.isLoading,
      onChanged: (value) => setState(() {
        if (value != null) {
          _selectedGender = value;
        }
      }),
    );
  }

  Widget _buildBankProviderSelect(AuthState state) {
    return _buildEnumSelect<BankProvider>(
      label: context.l10n.bank_provider,
      placeholder: context.l10n.hint_bank_provider,
      value: _selectedBankProvider,
      items: BankProvider.values,
      enabled: !state.user.isLoading,
      onChanged: (value) => setState(() => _selectedBankProvider = value),
    );
  }

  Widget _buildEnumSelect<T extends Enum>({
    required String label,
    required String placeholder,
    required T? value,
    required List<T> items,
    required bool enabled,
    required void Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(label),
        SizedBox(
          width: double.infinity,
          child: Select<T>(
            enabled: enabled,
            itemBuilder: (context, item) => Text(item.name),
            value: value,
            placeholder: Text(placeholder),
            onChanged: onChanged,
            popup: SelectPopup<T>(
              items: SelectItemList(
                children: items
                    .map((e) => SelectItemButton(value: e, child: Text(e.name)))
                    .toList(),
              ),
            ).call,
          ),
        ),
        if (value == null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text("Must be selected").xSmall().medium(),
          ),
      ],
    );
  }

  Widget _buildPhoneField(BuildContext context, AuthState state) {
    return FormField(
      key: _FormKeys.step1PhoneNumber,
      label: Text(context.l10n.phone),
      validator: const LengthValidator(min: 10, max: 15),
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
    );
  }

  Widget _buildImagePicker<T>(
    String label,
    T key,
    Map<T, File?> docs,
    Map<T, String?> errors,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(label),
        ImagePickerWidget(
          size: Size(double.infinity, 64.h),
          onValueChanged: (file) => setState(() => docs[key] = file),
        ),
        if (errors[key] != null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(
              errors[key] ?? context.l10n.error_photo_pick_failed,
            ).xSmall().medium(),
          ),
      ],
    );
  }
}
