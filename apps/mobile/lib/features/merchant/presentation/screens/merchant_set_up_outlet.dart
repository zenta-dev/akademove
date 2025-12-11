import 'dart:io';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class _FormKeys {
  static const FormKey<String> step1OutletPhotoProfile = TextFieldKey(
    'step-1-outlet-photo-profile',
  );
  static const FormKey<String> step1OutletCategory = TextFieldKey(
    'step-1-outlet-category',
  );
  static const FormKey<String> step3MenuCategory = TextFieldKey(
    'step-3-menu-category',
  );
  static const FormKey<String> step3MenuName = TextFieldKey('step-3-menu-name');
  static const FormKey<String> step3MenuDescription = TextFieldKey(
    'step-3-menu-description',
  );
  static const FormKey<String> step3MenuPrice = TextFieldKey(
    'step-3-menu-price',
  );
  static const FormKey<String> step3MenuStock = TextFieldKey(
    'step-3-menu-stock',
  );
}

enum _Step1Docs { outletPhotoProfile }

enum _Step3Docs { menuPhoto }

class DailySchedule {
  DailySchedule({
    required this.day,
    required this.dayOfWeek,
    this.isEnabled = false,
    this.is24Hours = false,
    this.startTime = '10:00',
    this.endTime = '22:00',
  });
  final String day;
  final DayOfWeek dayOfWeek;
  bool isEnabled;
  bool is24Hours;
  String startTime;
  String endTime;

  DailySchedule copyWith({
    bool? isEnabled,
    bool? is24Hours,
    String? startTime,
    String? endTime,
  }) {
    return DailySchedule(
      day: day,
      dayOfWeek: dayOfWeek,
      isEnabled: isEnabled ?? this.isEnabled,
      is24Hours: is24Hours ?? this.is24Hours,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  /// Convert to API request model
  MerchantOperatingHoursCreateRequest toCreateRequest() {
    return MerchantOperatingHoursCreateRequest(
      dayOfWeek: dayOfWeek,
      isOpen: isEnabled,
      is24Hours: is24Hours,
      openTime: is24Hours ? null : _parseTime(startTime),
      closeTime: is24Hours ? null : _parseTime(endTime),
    );
  }

  /// Parse time string (HH:mm) to Time object
  static Time? _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return Time(h: h, m: m);
  }
}

class MerchantSetUpOutletScreen extends StatefulWidget {
  const MerchantSetUpOutletScreen({super.key});

  @override
  State<MerchantSetUpOutletScreen> createState() =>
      _MerchantSetUpOutletScreenState();
}

class _MerchantSetUpOutletScreenState extends State<MerchantSetUpOutletScreen> {
  late final ScrollController _scrollController;
  late final FormController _formController;
  late final StepperController _stepController;

  MerchantCategory? _selectedOutletCategory;
  String? _selectedMenuCategory;

  // Image picker state
  final Map<_Step1Docs, File?> _step1Docs = {};
  final Map<_Step1Docs, String?> _step1DocsErrors = {};
  final Map<_Step3Docs, File?> _step3Docs = {};
  final Map<_Step3Docs, String?> _step3DocsErrors = {};

  List<DailySchedule> _weeklySchedule = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formController = FormController();
    _stepController = StepperController();

    // Load merchant data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MerchantCubit>().getMine();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_weeklySchedule.isEmpty) {
      _weeklySchedule = [
        DailySchedule(
          day: context.l10n.day_monday,
          dayOfWeek: DayOfWeek.MONDAY,
        ),
        DailySchedule(
          day: context.l10n.day_tuesday,
          dayOfWeek: DayOfWeek.TUESDAY,
        ),
        DailySchedule(
          day: context.l10n.day_wednesday,
          dayOfWeek: DayOfWeek.WEDNESDAY,
        ),
        DailySchedule(
          day: context.l10n.day_thursday,
          dayOfWeek: DayOfWeek.THURSDAY,
        ),
        DailySchedule(
          day: context.l10n.day_friday,
          dayOfWeek: DayOfWeek.FRIDAY,
        ),
        DailySchedule(
          day: context.l10n.day_saturday,
          dayOfWeek: DayOfWeek.SATURDAY,
        ),
        DailySchedule(
          day: context.l10n.day_sunday,
          dayOfWeek: DayOfWeek.SUNDAY,
        ),
      ];
    }
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

  bool get _isStep1Valid {
    // Validate form fields
    final formValid =
        _formController.errors[_FormKeys.step1OutletPhotoProfile] == null;

    // Validate outlet photo
    final hasOutletPhoto = _step1Docs[_Step1Docs.outletPhotoProfile] != null;
    if (!hasOutletPhoto) {
      setState(() {
        _step1DocsErrors[_Step1Docs.outletPhotoProfile] =
            context.l10n.error_outlet_photo_required;
      });
    } else {
      setState(() {
        _step1DocsErrors[_Step1Docs.outletPhotoProfile] = null;
      });
    }

    // Validate outlet category
    final hasOutletCategory = _selectedOutletCategory != null;

    return formValid && hasOutletPhoto && hasOutletCategory;
  }

  bool get _isStep2Valid {
    // Check if at least one day is enabled
    return _weeklySchedule.any((schedule) => schedule.isEnabled);
  }

  bool get _isStep3Valid {
    // Validate form fields
    final formValid = _validateFormFields([
      _FormKeys.step3MenuName,
      _FormKeys.step3MenuPrice,
      _FormKeys.step3MenuStock,
    ]);

    // Validate menu photo
    final hasMenuPhoto = _step3Docs[_Step3Docs.menuPhoto] != null;
    if (!hasMenuPhoto) {
      setState(() {
        _step3DocsErrors[_Step3Docs.menuPhoto] =
            context.l10n.error_menu_photo_required;
      });
    } else {
      setState(() {
        _step3DocsErrors[_Step3Docs.menuPhoto] = null;
      });
    }

    return formValid && hasMenuPhoto;
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showToast(BuildContext context, String title, String message) {
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  Future<MultipartFile?> _fileToMultipart(File? file) async {
    if (file == null) return null;
    return MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
  }

  Future<void> _handleSaveAndNavigateHome() async {
    _scrollToTop();

    if (!_validateStep(2, () => _isStep3Valid)) {
      _showToast(
        context,
        context.l10n.toast_validation_error,
        context.l10n.toast_complete_required_fields,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final merchantState = context.read<MerchantCubit>().state;
      final merchant = merchantState.mine.data?.value;

      if (merchant == null) {
        _showToast(
          context,
          context.l10n.toast_error,
          'Merchant data not found. Please try again.',
        );
        setState(() => _isLoading = false);
        return;
      }

      // Step 1: Update merchant profile (image and category)
      final outletImage = await _fileToMultipart(
        _step1Docs[_Step1Docs.outletPhotoProfile],
      );

      await context.read<MerchantCubit>().setupOutlet(
        merchantId: merchant.id,
        category: _selectedOutletCategory,
        image: outletImage,
      );

      // Check if outlet setup was successful
      final setupState = context.read<MerchantCubit>().state.setupOutlet;
      if (setupState.isFailed) {
        _showToast(
          context,
          context.l10n.toast_error,
          setupState.error?.message ?? 'Failed to update outlet',
        );
        setState(() => _isLoading = false);
        return;
      }

      // Step 2: Save operating hours
      final operatingHours = _weeklySchedule
          .map((schedule) => schedule.toCreateRequest())
          .toList();

      await context.read<MerchantCubit>().setupOperatingHours(
        merchantId: merchant.id,
        hours: operatingHours,
      );

      // Check if operating hours setup was successful
      final operatingHoursState = context
          .read<MerchantCubit>()
          .state
          .setupOperatingHours;
      if (operatingHoursState.isFailed) {
        _showToast(
          context,
          context.l10n.toast_error,
          operatingHoursState.error?.message ??
              'Failed to save operating hours',
        );
        setState(() => _isLoading = false);
        return;
      }

      // Step 3: Create initial menu item
      final menuImage = await _fileToMultipart(
        _step3Docs[_Step3Docs.menuPhoto],
      );
      final menuName =
          (_formController.values[_FormKeys.step3MenuName] as String?) ?? '';
      final menuPriceStr =
          (_formController.values[_FormKeys.step3MenuPrice] as String?) ?? '0';
      final menuStockStr =
          (_formController.values[_FormKeys.step3MenuStock] as String?) ?? '0';
      final menuPrice = num.tryParse(menuPriceStr) ?? 0;
      final menuStock = int.tryParse(menuStockStr) ?? 0;

      await context.read<MerchantMenuCubit>().createMenu(
        merchantId: merchant.id,
        name: menuName,
        price: menuPrice,
        stock: menuStock,
        category: _selectedMenuCategory,
        image: menuImage,
      );

      setState(() => _isLoading = false);

      _showToast(
        context,
        context.l10n.toast_success,
        context.l10n.toast_success_set_up_merchant,
      );

      // Navigate to home after a short delay to show the toast
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          context.goNamed(Routes.merchantHome.name);
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showToast(context, context.l10n.toast_error, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantCubit, MerchantState>(
      listener: (context, state) {
        if (state.setupOutlet.isFailed) {
          _showToast(
            context,
            context.l10n.toast_error,
            state.setupOutlet.error?.message ?? 'Failed to setup outlet',
          );
        }
        if (state.setupOperatingHours.isFailed) {
          _showToast(
            context,
            context.l10n.toast_error,
            state.setupOperatingHours.error?.message ??
                'Failed to save operating hours',
          );
        }
      },
      child: Stack(
        children: [
          MyScaffold(
            controller: _scrollController,
            headers: [DefaultAppBar(title: context.l10n.title_set_up_outlet)],
            body: Form(
              controller: _formController,
              child: Column(
                children: [
                  Gap(12.h),
                  Stepper(
                    controller: _stepController,
                    direction: Axis.horizontal,
                    variant: StepVariant.line,
                    size: StepSize.small,
                    steps: [
                      _buildStep1(context),
                      _buildStep2(context),
                      _buildStep3(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Step _buildStep1(BuildContext context) {
    return Step(
      title: Text(context.l10n.step_1),
      contentBuilder: (context) => _buildStepContainer(
        content: [
          _buildImagePicker(
            context.l10n.label_outlet_photo_profile,
            _Step1Docs.outletPhotoProfile,
            _step1Docs,
            _step1DocsErrors,
          ),
          _buildMerchantCategorySelect(
            label: context.l10n.label_outlet_category,
            placeholder: context.l10n.placeholder_outlet_category,
            value: _selectedOutletCategory,
            onChanged: (value) =>
                setState(() => _selectedOutletCategory = value),
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowRight,
            label: context.l10n.button_next,
            isPrimary: true,
            isTrailing: true,
            onPressed: () => _handleStepNavigation(
              isNext: true,
              validator: () => _validateStep(0, () => _isStep1Valid),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildStep2(BuildContext context) {
    return Step(
      title: Text(context.l10n.step_2),
      contentBuilder: (context) => _buildStepContainer(
        content: [
          Text(
            context.l10n.label_outlet_operating_hours,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          Gap(8.h),
          // Weekly schedule list
          ...List.generate(
            _weeklySchedule.length,
            (index) => _buildDayScheduleRow(_weeklySchedule[index], index),
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.button_back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          _buildActionButton(
            icon: LucideIcons.arrowRight,
            label: context.l10n.button_next,
            isPrimary: true,
            isTrailing: true,
            onPressed: () => _handleStepNavigation(
              isNext: true,
              validator: () => _validateStep(1, () => _isStep2Valid),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayScheduleRow(DailySchedule schedule, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          // Day name and toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                schedule.day,
                style: context.typography.semiBold.copyWith(fontSize: 16.sp),
              ),
              Switch(
                value: schedule.isEnabled,
                onChanged: (value) {
                  setState(() {
                    _weeklySchedule[index] = schedule.copyWith(
                      isEnabled: value,
                    );
                  });
                },
              ),
            ],
          ),

          if (schedule.isEnabled) ...[
            // 24 Hours checkbox
            GestureDetector(
              onTap: () {
                setState(() {
                  _weeklySchedule[index] = schedule.copyWith(
                    is24Hours: !schedule.is24Hours,
                  );
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    state: schedule.is24Hours
                        ? CheckboxState.checked
                        : CheckboxState.unchecked,
                    onChanged: (state) {
                      setState(() {
                        _weeklySchedule[index] = schedule.copyWith(
                          is24Hours: state == CheckboxState.checked,
                        );
                      });
                    },
                  ),
                  Gap(8.w),
                  Text(
                    context.l10n.label_24_hours,
                    style: context.typography.p.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            if (!schedule.is24Hours) ...[
              // Time input fields
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        Text(
                          context.l10n.label_start,
                          style: context.typography.small.copyWith(
                            color: context.theme.colorScheme.mutedForeground,
                          ),
                        ),
                        TextField(
                          initialValue: schedule.startTime,
                          placeholder: Text(
                            context.l10n.placeholder_start_time,
                          ),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            _weeklySchedule[index] = schedule.copyWith(
                              startTime: value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        Text(
                          context.l10n.label_end,
                          style: context.typography.small.copyWith(
                            color: context.theme.colorScheme.mutedForeground,
                          ),
                        ),
                        TextField(
                          initialValue: schedule.endTime,
                          placeholder: Text(context.l10n.placeholder_end_time),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            _weeklySchedule[index] = schedule.copyWith(
                              endTime: value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }

  Step _buildStep3(BuildContext context) {
    return Step(
      title: Text(context.l10n.step_3),
      contentBuilder: (context) => _buildStepContainer(
        content: [
          _buildMenuCategoryInput(
            label: context.l10n.label_menu_category,
            placeholder: context.l10n.placeholder_menu_category,
            value: _selectedMenuCategory,
            onChanged: (value) => setState(() => _selectedMenuCategory = value),
          ),
          _buildImagePicker(
            context.l10n.label_menu_photo,
            _Step3Docs.menuPhoto,
            _step3Docs,
            _step3DocsErrors,
          ),
          _buildTextField(
            key: _FormKeys.step3MenuName,
            label: context.l10n.label_menu_name,
            placeholder: context.l10n.placeholder_menu_name,
            icon: LucideIcons.utensils,
            validator: const LengthValidator(min: 3),
          ),
          _buildTextField(
            key: _FormKeys.step3MenuPrice,
            label: context.l10n.label_menu_price,
            placeholder: context.l10n.placeholder_menu_price,
            icon: LucideIcons.dollarSign,
            validator: const LengthValidator(min: 1),
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            key: _FormKeys.step3MenuStock,
            label: context.l10n.label_menu_stock,
            placeholder: context.l10n.placeholder_menu_stock,
            icon: LucideIcons.package,
            validator: const LengthValidator(min: 1),
            keyboardType: TextInputType.number,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.button_back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          _buildActionButton(
            icon: LucideIcons.check,
            label: context.l10n.button_save,
            isPrimary: true,
            isTrailing: true,
            onPressed: _isLoading ? () {} : _handleSaveAndNavigateHome,
          ),
        ],
      ),
    );
  }

  Widget _buildStepContainer({
    required List<Widget> content,
    required List<Widget> actions,
  }) {
    return StepContainer(
      actions: actions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: content,
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
      style: context.typography.p.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
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

  void _handleStepNavigation({
    required bool isNext,
    required bool Function() validator,
  }) {
    _scrollToTop();
    if (isNext) {
      if (validator()) {
        _stepController.nextStep();
      } else {
        _showToast(
          context,
          context.l10n.toast_validation_error,
          context.l10n.toast_complete_required_fields,
        );
      }
    } else {
      _stepController.previousStep();
    }
  }

  Widget _buildTextField({
    required FormKey<String> key,
    required String label,
    required String placeholder,
    required IconData icon,
    required Validator<String> validator,
    bool enabled = true,
    TextInputType? keyboardType,
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
      ),
    );
  }

  Widget _buildMerchantCategorySelect({
    required String label,
    required String placeholder,
    required MerchantCategory? value,
    required void Function(MerchantCategory?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.typography.semiBold.copyWith(fontSize: 14.sp),
        ),
        SizedBox(
          width: double.infinity,
          child: Select<MerchantCategory>(
            itemBuilder: (context, item) =>
                Text(_getMerchantCategoryLabel(item)),
            value: value,
            placeholder: Text(placeholder),
            onChanged: onChanged,
            popup: SelectPopup<MerchantCategory>(
              items: SelectItemList(
                children: MerchantCategory.values
                    .map(
                      (e) => SelectItemButton(
                        value: e,
                        child: Text(_getMerchantCategoryLabel(e)),
                      ),
                    )
                    .toList(),
              ),
            ).call,
          ),
        ),
      ],
    );
  }

  String _getMerchantCategoryLabel(MerchantCategory category) {
    switch (category) {
      case MerchantCategory.ATK:
        return context.l10n.merchant_category_atk;
      case MerchantCategory.printing:
        return context.l10n.merchant_category_printing;
      case MerchantCategory.food:
        return context.l10n.merchant_category_food;
    }
  }

  Widget _buildMenuCategoryInput({
    required String label,
    required String placeholder,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.typography.semiBold.copyWith(fontSize: 14.sp),
        ),
        TextField(
          initialValue: value,
          placeholder: Text(placeholder),
          onChanged: onChanged,
        ),
        Text(
          context.l10n.hint_menu_category,
          style: context.typography.small.copyWith(
            color: context.theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker<T>(
    String label,
    T key,
    Map<T, File?> docs,
    Map<T, String?> errors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.typography.semiBold.copyWith(fontSize: 14.sp),
        ),
        ImagePickerWidget(
          size: Size(double.infinity, 200.h),
          onValueChanged: (file) {
            setState(() {
              docs[key] = file;
              errors[key] = null; // Clear error when image is picked
            });
          },
        ),
        if (errors[key] != null)
          DefaultTextStyle.merge(
            style: TextStyle(
              color: context.theme.colorScheme.destructive,
              fontSize: 12.sp,
            ),
            child: Text(errors[key]!),
          ),
      ],
    );
  }
}
