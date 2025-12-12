import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ReportUserScreen extends StatefulWidget {
  const ReportUserScreen({
    required this.targetUserId,
    required this.targetUserName,
    this.orderId,
    super.key,
  });

  final String targetUserId;
  final String targetUserName;
  final String? orderId;

  @override
  State<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends State<ReportUserScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  ReportCategory? _selectedCategory;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    return _selectedCategory != null &&
        _descriptionController.text.trim().length >= 10;
  }

  void _submitReport() {
    if (!_canSubmit) return;

    final category = _selectedCategory;
    if (category == null) return;

    context.read<ReportCubit>().submitReport(
      targetUserId: widget.targetUserId,
      category: category,
      description: _descriptionController.text.trim(),
      orderId: widget.orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.report_user)],
      child: BlocListener<ReportCubit, ReportState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.showMyToast(
              context.l10n.toast_report_submitted,
              type: ToastType.success,
            );
            context.pop(true);
          } else if (state.status.isFailure) {
            context.showMyToast(
              state.status.error?.message ??
                  context.l10n.toast_failed_submit_report,
              type: ToastType.failed,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.h,
              children: [
                // Target user info
                _buildTargetUserInfo(),

                // Category selector
                _buildCategorySelector(),

                // Description section
                _buildDescriptionSection(),

                // Guidelines
                _buildGuidelines(),

                // Submit button
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTargetUserInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Row(
          children: [
            Avatar(
              size: 56.sp,
              initials: Avatar.getInitials(widget.targetUserName),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    widget.targetUserName,
                    style: context.typography.h4.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.l10n.report_user_description,
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          context.l10n.select_report_category,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: ReportCategory.values.map((category) {
            final isSelected = _selectedCategory == category;

            return Button(
              style: isSelected
                  ? const ButtonStyle.primary(density: ButtonDensity.compact)
                  : const ButtonStyle.outline(density: ButtonDensity.compact),
              onPressed: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.w,
                children: [
                  Icon(_getCategoryIcon(category), size: 16.sp),
                  Text(_getCategoryLabel(category)),
                ],
              ),
            );
          }).toList(),
        ),
        if (_selectedCategory case final selectedCategory?)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              _getCategoryDescription(selectedCategory),
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          context.l10n.report_description,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextArea(
          controller: _descriptionController,
          minLines: 5,
          maxLines: 5,
          maxLength: 1000,
          onChanged: (_) => setState(() {}),
          placeholder: Text(context.l10n.report_description_hint),
        ),
        Text(
          context.l10n.report_description_helper,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelines() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.info,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.report_guidelines_title,
                  style: context.typography.h4.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              context.l10n.report_guidelines_content,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Button.primary(
            enabled: _canSubmit && !state.status.isLoading,
            onPressed: state.status.isLoading ? null : _submitReport,
            child: state.status.isLoading
                ? const Submiting()
                : Text(context.l10n.button_submit_report),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(ReportCategory category) {
    switch (category) {
      case ReportCategory.BEHAVIOR:
        return LucideIcons.frown;
      case ReportCategory.SAFETY:
        return LucideIcons.triangleAlert;
      case ReportCategory.FRAUD:
        return LucideIcons.shieldOff;
      case ReportCategory.OTHER:
        return LucideIcons.ellipsis;
    }
  }

  String _getCategoryLabel(ReportCategory category) {
    switch (category) {
      case ReportCategory.BEHAVIOR:
        return context.l10n.report_category_behavior;
      case ReportCategory.SAFETY:
        return context.l10n.report_category_safety;
      case ReportCategory.FRAUD:
        return context.l10n.report_category_fraud;
      case ReportCategory.OTHER:
        return context.l10n.report_category_other;
    }
  }

  String _getCategoryDescription(ReportCategory category) {
    switch (category) {
      case ReportCategory.BEHAVIOR:
        return context.l10n.report_category_behavior_desc;
      case ReportCategory.SAFETY:
        return context.l10n.report_category_safety_desc;
      case ReportCategory.FRAUD:
        return context.l10n.report_category_fraud_desc;
      case ReportCategory.OTHER:
        return context.l10n.report_category_other_desc;
    }
  }
}
