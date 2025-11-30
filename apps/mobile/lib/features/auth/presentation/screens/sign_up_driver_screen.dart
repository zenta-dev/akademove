import 'dart:io';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
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
  static const step1Gender = SelectKey<UserGender>('step-1-gender');
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
  static const step4BankProvider = SelectKey<BankProvider>(
    'step-4-bank-provider',
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
      if (file == null) errors[key] = "File shouldn't be empty";
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

  bool get _isStep4Valid => _validateStep(
    3,
    () => _validateFormFields([
      _FormKeys.step4BankProvider,
      _FormKeys.step4BankNumber,
    ]),
  );

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showToast(BuildContext context, String title, String message) {
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  void _handleSignUpSuccess(BuildContext context, String? message) {
    _showToast(context, 'Sign Up Success', message ?? 'Successfully signed up');
    context.read<SignUpCubit>().reset();
    context.pushReplacementNamed(Routes.authSignIn.name);
  }

  void _handleSignUpFailure(BuildContext context, String? error) {
    _showToast(context, 'Sign Up Failed', error ?? 'Unknown error');
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    if (!_isStep4Valid) return;
    final cubit = context.read<SignUpCubit>();
    if (cubit.state.isLoading) return;

    final formData = _extractFormData(values);
    if (formData == null) return;

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
      photoPath: _step2Docs[Step2Docs.photo]!.path,
      studentId: int.parse(formData['studentId']!),
      licensePlate: formData['licensePlate']!,
      studentCardPath: _step2Docs[Step2Docs.studentCard]!.path,
      driverLicensePath: _step2Docs[Step2Docs.driverLicense]!.path,
      vehicleCertificatePath: _step3Docs[Step3Docs.vehicleRegistration]!.path,
      bankProvider: _selectedBankProvider!,
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

    if (name == null ||
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
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.isFailure) {
            _handleSignUpFailure(context, state.error?.message);
          }
          if (state.isSuccess) _handleSignUpSuccess(context, state.message);
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

  Step _buildStep1(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 1'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver1.image(height: 200.h),
        title: 'Tell us a bit about yourself to get started!',
        content: [
          _buildTextField(
            key: _FormKeys.step1Name,
            label: 'Name',
            placeholder: 'John Doe',
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 3),
            enabled: !state.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step1Email,
            label: 'Email',
            placeholder: 'john@gmail.com',
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            keyboardType: TextInputType.emailAddress,
            enabled: !state.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step1StudentId,
            label: 'NIM',
            placeholder: '25051204020',
            icon: LucideIcons.hash,
            validator: const LengthValidator(min: 10, max: 20),
            keyboardType: TextInputType.number,
            enabled: !state.isLoading,
          ),
          _buildGenderSelect(state),
          _buildPhoneField(context, state),
          _buildTextField(
            key: _FormKeys.step1Password,
            label: 'Password',
            placeholder: '*******',
            icon: LucideIcons.key,
            validator: const SafePasswordValidator(),
            enabled: !state.isLoading,
            isPassword: true,
          ),
          _buildTextField(
            key: _FormKeys.step1ConfirmPassword,
            label: 'Confirm Password',
            placeholder: '*******',
            icon: LucideIcons.key,
            // validator: null,
            validator: const CompareWith.equal(
              _FormKeys.step1Password,
              message: 'Confirm password not same',
            ),
            enabled: !state.isLoading,
            isPassword: true,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: 'Back',
            onPressed: () => context.pop(),
          ),
          _buildActionButton(
            icon: LucideIcons.arrowRight,
            label: 'Next',
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

  Step _buildStep2(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 2'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver2.image(height: 200.h),
        title: 'Upload your photo and documents to verify your account!',
        content: [
          _buildImagePicker(
            'Photo',
            Step2Docs.photo,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
          _buildImagePicker(
            'Student Card (KTM)',
            Step2Docs.studentCard,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
          _buildImagePicker(
            'Driver License (SIM)',
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

  Step _buildStep3(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 3'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver3.image(height: 200.h),
        title: 'Enter your vehicle details so we can set you up on the road!',
        content: [
          _buildTextField(
            key: _FormKeys.step3LicensePlate,
            label: 'License Plate',
            placeholder: 'B 1234 AM',
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 6),
            enabled: !state.isLoading,
          ),
          _buildImagePicker(
            'Vehicle Registration (STNK)',
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

  Step _buildStep4(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 4'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpDriver4.image(height: 200.h),
        title: 'Add your bank account to receive your earnings securely!',
        content: [
          _buildBankProviderSelect(state),
          _buildTextField(
            key: _FormKeys.step4BankNumber,
            label: 'Bank Account',
            placeholder: '11223344',
            keyboardType: TextInputType.number,
            icon: LucideIcons.wallet,
            validator: const LengthValidator(min: 5),
            enabled: !state.isLoading,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: 'Back',
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
        label: 'Back',
        onPressed: () =>
            _handleStepNavigation(isNext: false, validator: () => true),
      ),
      _buildActionButton(
        icon: LucideIcons.arrowRight,
        label: 'Next',
        isPrimary: true,
        isTrailing: true,
        onPressed: () =>
            _handleStepNavigation(isNext: true, validator: validator),
      ),
    ];
  }

  Widget _buildSubmitButton(SignUpState state) {
    return Expanded(
      child: FormErrorBuilder(
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
                ? const Submiting(simpleText: true)
                : Text(
                    'Sign Up',
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

  Widget _buildGenderSelect(SignUpState state) {
    return _buildEnumSelect<UserGender>(
      key: _FormKeys.step1Gender,
      label: 'Gender',
      placeholder: 'Pick your gender',
      value: _selectedGender,
      items: UserGender.values,
      enabled: !state.isLoading,
      onChanged: (value) => setState(() {
        if (value != null) {
          _selectedGender = value;
        }
      }),
    );
  }

  Widget _buildBankProviderSelect(SignUpState state) {
    return _buildEnumSelect<BankProvider>(
      key: _FormKeys.step4BankProvider,
      label: 'Bank Provider',
      placeholder: 'Pick your bank provider',
      value: _selectedBankProvider,
      items: BankProvider.values,
      enabled: !state.isLoading,
      onChanged: (value) => setState(() => _selectedBankProvider = value),
    );
  }

  Widget _buildEnumSelect<T extends Enum>({
    required FormKey<T> key,
    required String label,
    required String placeholder,
    required T? value,
    required List<T> items,
    required bool enabled,
    required void Function(T?) onChanged,
  }) {
    return FormField(
      key: key,
      label: Text(label),
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      validator: NonNullValidator<T>(),
      child: SizedBox(
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
    );
  }

  Widget _buildPhoneField(BuildContext context, SignUpState state) {
    return FormField(
      key: _FormKeys.step1PhoneNumber,
      label: const Text('Phone'),
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
              errors[key] ?? 'Failed to pick photo',
            ).xSmall().medium(),
          ),
      ],
    );
  }
}
