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

enum _Step1Docs { outletPhotoProfile }

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

  // Image picker state
  final Map<_Step1Docs, File?> _step1Docs = {};
  final Map<_Step1Docs, String?> _step1DocsErrors = {};

  List<DailySchedule> _weeklySchedule = [];

  bool _isLoading = false;

  // Track setup flow stage: 0 = idle, 1 = outlet setup in progress, 2 = operating hours setup in progress
  int _setupStage = 0;

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

  bool get _isStep1Valid {
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

    return hasOutletPhoto && hasOutletCategory;
  }

  bool get _isStep2Valid {
    // Check if at least one day is enabled
    return _weeklySchedule.any((schedule) => schedule.isEnabled);
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

    if (!_validateStep(2, () => _isStep2Valid)) {
      _showToast(
        context,
        context.l10n.toast_validation_error,
        context.l10n.toast_complete_required_fields,
      );
      return;
    }

    final merchantState = context.read<MerchantCubit>().state;
    final merchant = merchantState.mine.data?.value;

    if (merchant == null) {
      _showToast(
        context,
        context.l10n.toast_error,
        'Merchant data not found. Please try again.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _setupStage = 1; // Start outlet setup
    });

    // Step 1: Trigger outlet setup - listener will handle the response and chain step 2
    final outletImage = await _fileToMultipart(
      _step1Docs[_Step1Docs.outletPhotoProfile],
    );

    context.read<MerchantCubit>().setupOutlet(
      merchantId: merchant.id,
      category: _selectedOutletCategory,
      image: outletImage,
    );
  }

  /// Continue to step 2 of setup flow (called from listener after step 1 succeeds)
  void _continueToOperatingHoursSetup() {
    final merchantState = context.read<MerchantCubit>().state;
    final merchant = merchantState.mine.data?.value;

    if (merchant == null) {
      setState(() {
        _isLoading = false;
        _setupStage = 0;
      });
      _showToast(
        context,
        context.l10n.toast_error,
        'Merchant data not found. Please try again.',
      );
      return;
    }

    setState(() => _setupStage = 2); // Start operating hours setup

    final operatingHours = _weeklySchedule
        .map((schedule) => schedule.toCreateRequest())
        .toList();

    context.read<MerchantCubit>().setupOperatingHours(
      merchantId: merchant.id,
      hours: operatingHours,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantCubit, MerchantState>(
      listener: (context, state) {
        // Handle setup outlet result (stage 1)
        if (_setupStage == 1) {
          if (state.setupOutlet.isSuccess) {
            // Step 1 succeeded, continue to step 2
            _continueToOperatingHoursSetup();
          } else if (state.setupOutlet.isFailed) {
            setState(() {
              _isLoading = false;
              _setupStage = 0;
            });
            _showToast(
              context,
              context.l10n.toast_error,
              state.setupOutlet.error?.message ?? 'Failed to setup outlet',
            );
          }
        }

        // Handle operating hours result (stage 2)
        if (_setupStage == 2) {
          if (state.setupOperatingHours.isSuccess) {
            setState(() {
              _isLoading = false;
              _setupStage = 0;
            });
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
          } else if (state.setupOperatingHours.isFailed) {
            setState(() {
              _isLoading = false;
              _setupStage = 0;
            });
            _showToast(
              context,
              context.l10n.toast_error,
              state.setupOperatingHours.error?.message ??
                  'Failed to save operating hours',
            );
          }
        }
      },
      child: Stack(
        children: [
          Scaffold(
            headers: [DefaultAppBar(title: context.l10n.title_set_up_outlet)],
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: Form(
                controller: _formController,
                child: Column(
                  children: [
                    Gap(12.h),
                    Stepper(
                      controller: _stepController,
                      direction: Axis.horizontal,
                      variant: StepVariant.line,
                      size: StepSize.small,
                      steps: [_buildStep1(context), _buildStep2(context)],
                    ),
                  ],
                ),
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
          AuthImagePicker(
            label: context.l10n.label_outlet_photo_profile,
            height: 200.h,
            error: _step1DocsErrors[_Step1Docs.outletPhotoProfile],
            onChanged: (file) {
              setState(() {
                _step1Docs[_Step1Docs.outletPhotoProfile] = file;
                _step1DocsErrors[_Step1Docs.outletPhotoProfile] = null;
              });
            },
          ),
          AuthEnumSelect<MerchantCategory>(
            label: context.l10n.label_outlet_category,
            placeholder: context.l10n.placeholder_outlet_category,
            value: _selectedOutletCategory,
            items: MerchantCategory.values,
            itemBuilder: (context, item) =>
                Text(_getMerchantCategoryLabel(item)),
            onChanged: (value) =>
                setState(() => _selectedOutletCategory = value),
          ),
        ],
        actions: [
          AuthActionButton(
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
          AuthActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.button_back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          AuthActionButton(
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
}
