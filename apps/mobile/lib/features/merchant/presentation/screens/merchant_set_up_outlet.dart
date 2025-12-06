import 'dart:io';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Dummy Outlet Category Enum
enum OutletCategoryEnum {
  restaurant,
  cafe,
  fastFood,
  bakery,
  streetFood,
  foodTruck,
  bar,
  coffeeshop,
  dessertShop,
  juiceBar,
}

// Setup Menu Category Enum (local to this screen)
enum _SetupMenuCategoryEnum {
  appetizer,
  mainCourse,
  dessert,
  beverage,
  snack,
  breakfast,
  lunch,
  dinner,
  salad,
  soup,
  seafood,
  vegetarian,
  vegan,
  pasta,
  pizza,
  burger,
  sandwich,
  rice,
  noodle,
  grill,
}

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
}

enum _Step1Docs { outletPhotoProfile }

enum _Step3Docs { menuPhoto }

class DailySchedule {
  DailySchedule({
    required this.day,
    this.isEnabled = false,
    this.is24Hours = false,
    this.startTime = '10:00',
    this.endTime = '22:00',
  });
  final String day;
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
      isEnabled: isEnabled ?? this.isEnabled,
      is24Hours: is24Hours ?? this.is24Hours,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
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

  OutletCategoryEnum? _selectedOutletCategory;
  _SetupMenuCategoryEnum? _selectedMenuCategory;

  // Image picker state
  final Map<_Step1Docs, File?> _step1Docs = {};
  final Map<_Step1Docs, String?> _step1DocsErrors = {};
  final Map<_Step3Docs, File?> _step3Docs = {};
  final Map<_Step3Docs, String?> _step3DocsErrors = {};

  List<DailySchedule> _weeklySchedule = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formController = FormController();
    _stepController = StepperController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_weeklySchedule.isEmpty) {
      _weeklySchedule = [
        DailySchedule(day: context.l10n.day_monday),
        DailySchedule(day: context.l10n.day_tuesday),
        DailySchedule(day: context.l10n.day_wednesday),
        DailySchedule(day: context.l10n.day_thursday),
        DailySchedule(day: context.l10n.day_friday),
        DailySchedule(day: context.l10n.day_saturday),
        DailySchedule(day: context.l10n.day_sunday),
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
      _FormKeys.step3MenuDescription,
      _FormKeys.step3MenuPrice,
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

    // Validate menu category
    final hasMenuCategory = _selectedMenuCategory != null;

    return formValid && hasMenuPhoto && hasMenuCategory;
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

    // TODO: Integrate with MerchantCubit.updateOutletSetup when API is available
    // The following data should be sent to the API:
    // - Step 1: _step1Docs[_Step1Docs.outletPhotoProfile], _selectedOutletCategory
    // - Step 2: _weeklySchedule (operating hours)
    // - Step 3: _selectedMenuCategory, _step3Docs[_Step3Docs.menuPhoto], menu details

    // For now, simulate API call
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
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
          _buildEnumSelect<OutletCategoryEnum>(
            label: context.l10n.label_outlet_category,
            key: _FormKeys.step1OutletCategory,
            placeholder: context.l10n.placeholder_outlet_category,
            icon: LucideIcons.pizza,
            value: _selectedOutletCategory,
            items: OutletCategoryEnum.values,
            enabled: true,
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
          _buildEnumSelect<_SetupMenuCategoryEnum>(
            label: context.l10n.label_menu_category,
            key: _FormKeys.step3MenuCategory,
            placeholder: context.l10n.placeholder_menu_category,
            icon: LucideIcons.utensils,
            value: _selectedMenuCategory,
            items: _SetupMenuCategoryEnum.values,
            enabled: true,
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
            key: _FormKeys.step3MenuDescription,
            label: context.l10n.label_menu_description,
            placeholder: context.l10n.placeholder_menu_description,
            icon: LucideIcons.fileText,
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
            onPressed: _handleSaveAndNavigateHome,
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

  Widget _buildEnumSelect<T extends Enum>({
    required String label,
    required FormKey<String> key,
    required String placeholder,
    required IconData icon,
    required T? value,
    required List<T> items,
    required bool enabled,
    required void Function(T?) onChanged,
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
          child: Select<T>(
            enabled: enabled,
            itemBuilder: (context, item) => Text(_getLocalizedEnumName(item)),
            value: value,
            placeholder: Text(placeholder),
            onChanged: onChanged,
            popup: SelectPopup<T>(
              items: SelectItemList(
                children: items
                    .map(
                      (e) => SelectItemButton(
                        value: e,
                        child: Text(_getLocalizedEnumName(e)),
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

  // Helper method to get localized enum names
  String _getLocalizedEnumName(Enum enumValue) {
    if (enumValue is OutletCategoryEnum) {
      switch (enumValue) {
        case OutletCategoryEnum.restaurant:
          return context.l10n.outlet_category_restaurant;
        case OutletCategoryEnum.cafe:
          return context.l10n.outlet_category_cafe;
        case OutletCategoryEnum.fastFood:
          return context.l10n.outlet_category_fast_food;
        case OutletCategoryEnum.bakery:
          return context.l10n.outlet_category_bakery;
        case OutletCategoryEnum.streetFood:
          return context.l10n.outlet_category_street_food;
        case OutletCategoryEnum.foodTruck:
          return context.l10n.outlet_category_food_truck;
        case OutletCategoryEnum.bar:
          return context.l10n.outlet_category_bar;
        case OutletCategoryEnum.coffeeshop:
          return context.l10n.outlet_category_coffeeshop;
        case OutletCategoryEnum.dessertShop:
          return context.l10n.outlet_category_dessert_shop;
        case OutletCategoryEnum.juiceBar:
          return context.l10n.outlet_category_juice_bar;
      }
    } else if (enumValue is _SetupMenuCategoryEnum) {
      switch (enumValue) {
        case _SetupMenuCategoryEnum.appetizer:
          return context.l10n.menu_category_appetizer;
        case _SetupMenuCategoryEnum.mainCourse:
          return context.l10n.menu_category_main_course;
        case _SetupMenuCategoryEnum.dessert:
          return context.l10n.menu_category_dessert;
        case _SetupMenuCategoryEnum.beverage:
          return context.l10n.menu_category_beverage;
        case _SetupMenuCategoryEnum.snack:
          return context.l10n.menu_category_snack;
        case _SetupMenuCategoryEnum.breakfast:
          return context.l10n.menu_category_breakfast;
        case _SetupMenuCategoryEnum.lunch:
          return context.l10n.menu_category_lunch;
        case _SetupMenuCategoryEnum.dinner:
          return context.l10n.menu_category_dinner;
        case _SetupMenuCategoryEnum.salad:
          return context.l10n.menu_category_salad;
        case _SetupMenuCategoryEnum.soup:
          return context.l10n.menu_category_soup;
        case _SetupMenuCategoryEnum.seafood:
          return context.l10n.menu_category_seafood;
        case _SetupMenuCategoryEnum.vegetarian:
          return context.l10n.menu_category_vegetarian;
        case _SetupMenuCategoryEnum.vegan:
          return context.l10n.menu_category_vegan;
        case _SetupMenuCategoryEnum.pasta:
          return context.l10n.menu_category_pasta;
        case _SetupMenuCategoryEnum.pizza:
          return context.l10n.menu_category_pizza;
        case _SetupMenuCategoryEnum.burger:
          return context.l10n.menu_category_burger;
        case _SetupMenuCategoryEnum.sandwich:
          return context.l10n.menu_category_sandwich;
        case _SetupMenuCategoryEnum.rice:
          return context.l10n.menu_category_rice;
        case _SetupMenuCategoryEnum.noodle:
          return context.l10n.menu_category_noodle;
        case _SetupMenuCategoryEnum.grill:
          return context.l10n.menu_category_grill;
      }
    }
    // Fallback to formatted enum name if not found
    final result = enumValue.name.replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.trim().substring(0, 1).toUpperCase() +
        result.trim().substring(1);
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
