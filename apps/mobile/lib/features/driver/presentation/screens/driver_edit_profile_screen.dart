import 'dart:io' show File;

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverEditProfileScreen extends StatefulWidget {
  const DriverEditProfileScreen({super.key});

  @override
  State<DriverEditProfileScreen> createState() =>
      _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  static const TextFieldKey _nameKey = TextFieldKey('name');
  static const TextFieldKey _emailKey = TextFieldKey('email');
  static const TextFieldKey _phoneKey = TextFieldKey('phone');
  static const TextFieldKey _studentIdKey = TextFieldKey('studentId');
  static const TextFieldKey _licensePlateKey = TextFieldKey('licensePlate');

  static const Set<FormValidationMode> _showErrors = {
    FormValidationMode.changed,
    FormValidationMode.submitted,
  };

  late FocusNode _nameFn;
  late FocusNode _emailFn;
  late FocusNode _phoneFn;
  late FocusNode _studentIdFn;
  late FocusNode _licensePlateFn;

  static const _emailValidator = EmailValidator();

  CountryCode _selectedCountryCode = CountryCode.ID;

  File? _pickedPhoto;
  File? _studentCardFile;
  File? _driverLicenseFile;
  File? _vehicleCertificateFile;

  @override
  void initState() {
    super.initState();

    _nameFn = FocusNode();
    _emailFn = FocusNode();
    _phoneFn = FocusNode();
    _studentIdFn = FocusNode();
    _licensePlateFn = FocusNode();
  }

  @override
  void dispose() {
    _nameFn.dispose();
    _emailFn.dispose();
    _phoneFn.dispose();
    _studentIdFn.dispose();
    _licensePlateFn.dispose();
    super.dispose();
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    final cubit = context.read<DriverProfileCubit>();
    if (cubit.state.updateProfileResult.isLoading) return;

    final name = _nameKey[values];
    final email = _emailKey[values];
    final phone = _phoneKey[values];
    final studentId = _studentIdKey[values];
    final licensePlate = _licensePlateKey[values];

    final parsedPhone = int.tryParse(phone ?? '');
    final parsedStudentId = num.tryParse(studentId ?? '');

    cubit.updateProfile(
      DriverUpdateProfileRequest(
        name: name,
        email: email,
        photoPath: _pickedPhoto?.path,
        phone: parsedPhone != null
            ? Phone(countryCode: _selectedCountryCode, number: parsedPhone)
            : null,
        studentId: parsedStudentId,
        licensePlate: licensePlate,
        studentCardPath: _studentCardFile?.path,
        driverLicensePath: _driverLicenseFile?.path,
        vehicleCertificatePath: _vehicleCertificateFile?.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_edit_profile)],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: BlocConsumer<DriverProfileCubit, DriverProfileState>(
              listener: (context, profileState) {
                profileState.updateProfileResult.whenOr(
                  success: (driver, message) {
                    context.showMyToast(message, type: ToastType.success);
                    delay(const Duration(seconds: 3), () {
                      context.read<DriverProfileCubit>().clearResults();
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
                final isLoading = profileState.updateProfileResult.isLoading;
                final driver = profileState.driver;
                final user = driver?.user;

                return Form(
                  onSubmit: _handleFormSubmit,
                  child: Column(
                    spacing: 8.h,
                    children: [
                      // Profile Photo
                      Column(
                        spacing: 8.h,
                        children: [
                          Text(context.l10n.label_photo_profile).small(),
                          ImagePickerWidget(
                            enabled: !isLoading,
                            previewUrl: user?.image,
                            value: _pickedPhoto,
                            size: Size(86.h, 86.h),
                            onValueChanged: (file) =>
                                setState(() => _pickedPhoto = file),
                          ),
                        ],
                      ),

                      // Basic Information
                      FormField(
                        key: _nameKey,
                        label: Text(context.l10n.label_name).small(),
                        showErrors: _showErrors,
                        child: TextField(
                          enabled: !isLoading,
                          focusNode: _nameFn,
                          initialValue: user?.name,
                          placeholder: Text(
                            user?.name ?? context.l10n.placeholder_full_name,
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
                          enabled: !isLoading,
                          focusNode: _emailFn,
                          initialValue: user?.email,
                          placeholder: Text(user?.email ?? 'john@gmail.com'),
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
                            initialValue: user?.phone.toPhoneNumber(),
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

                      // Driver Specific Information
                      const Divider(),
                      Text(
                        'Driver Information',
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      FormField(
                        key: _studentIdKey,
                        label: Text('Student ID').small(),
                        showErrors: _showErrors,
                        child: TextField(
                          enabled: !isLoading,
                          focusNode: _studentIdFn,
                          initialValue: driver?.studentId.toString(),
                          placeholder: Text('Enter your student ID'),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [],
                          onSubmitted: (value) {
                            _licensePlateFn.requestFocus();
                          },
                          features: const [
                            InputFeature.leading(Icon(LucideIcons.idCard)),
                          ],
                        ),
                      ),

                      FormField(
                        key: _licensePlateKey,
                        label: Text('License Plate').small(),
                        showErrors: _showErrors,
                        child: TextField(
                          enabled: !isLoading,
                          focusNode: _licensePlateFn,
                          initialValue: driver?.licensePlate,
                          placeholder: Text('Enter your license plate'),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [],
                          onSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          features: const [
                            InputFeature.leading(Icon(LucideIcons.car)),
                          ],
                        ),
                      ),

                      // Document Uploads
                      const Divider(),
                      Text(
                        'Documents',
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      _buildDocumentUpload(
                        'Student Card',
                        _studentCardFile,
                        (file) => setState(() => _studentCardFile = file),
                        isLoading,
                      ),

                      _buildDocumentUpload(
                        'Driver License',
                        _driverLicenseFile,
                        (file) => setState(() => _driverLicenseFile = file),
                        isLoading,
                      ),

                      _buildDocumentUpload(
                        'Vehicle Certificate',
                        _vehicleCertificateFile,
                        (file) =>
                            setState(() => _vehicleCertificateFile = file),
                        isLoading,
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
                              onPressed: (!isLoading)
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentUpload(
    String label,
    File? file,
    Function(File?) onFileChanged,
    bool isLoading,
  ) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).small(),
        ImagePickerWidget(
          enabled: !isLoading,
          value: file,
          size: Size(double.infinity, 100.h),
          onValueChanged: onFileChanged,
        ),
      ],
    );
  }
}
