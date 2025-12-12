import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/presentation/cubits/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for submitting a review after completing an order
class ReviewSubmissionDialog extends StatefulWidget {
  const ReviewSubmissionDialog({
    required this.orderId,
    required this.toUserId,
    required this.toUserName,
    super.key,
  });

  final String orderId;
  final String toUserId;
  final String toUserName;

  @override
  State<ReviewSubmissionDialog> createState() => _ReviewSubmissionDialogState();
}

class _ReviewSubmissionDialogState extends State<ReviewSubmissionDialog> {
  ReviewCategory _selectedCategory = ReviewCategory.COURTESY;
  double _score = 5.0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    // BlocListener handles state changes
    context.read<DriverReviewCubit>().submitReview(
      orderId: widget.orderId,
      toUserId: widget.toUserId,
      category: _selectedCategory,
      score: _score,
      comment: _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim(),
    );
  }

  void _onReviewStateChanged(DriverReviewState state) {
    if (state.submitReviewResult.isSuccess && state.submitted != null) {
      Navigator.of(context).pop(true);
      context.showMyToast(
        context.l10n.toast_review_submitted,
        type: ToastType.success,
      );
    } else if (state.submitReviewResult.isFailure) {
      setState(() => _isSubmitting = false);
      context.showMyToast(
        state.submitReviewResult.error?.message ??
            context.l10n.toast_review_failed,
        type: ToastType.failed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverReviewCubit, DriverReviewState>(
      listenWhen: (previous, current) =>
          previous.submitReviewResult != current.submitReviewResult,
      listener: (context, state) => _onReviewStateChanged(state),
      child: AlertDialog(
        title: Text(context.l10n.title_rate_customer),
        content: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuerySize.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // Customer name
                Text(
                  context.l10n.text_experience_with_user(widget.toUserName),
                  style: context.typography.small,
                ),
                SizedBox(height: 8.h),

                // Category selector
                Text(
                  context.l10n.label_review_category,
                  style: context.typography.semiBold,
                ),
                SizedBox(height: 4.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: ReviewCategory.values.map((category) {
                    final isSelected = _selectedCategory == category;
                    final label = switch (category) {
                      ReviewCategory.CLEANLINESS =>
                        context.l10n.category_cleanliness,
                      ReviewCategory.COURTESY => context.l10n.category_courtesy,
                      ReviewCategory.PUNCTUALITY =>
                        context.l10n.category_punctuality,
                      ReviewCategory.SAFETY => context.l10n.category_safety,
                      ReviewCategory.COMMUNICATION =>
                        context.l10n.category_communication,
                      ReviewCategory.OTHER => context.l10n.category_other,
                    };
                    return isSelected
                        ? PrimaryButton(
                            size: ButtonSize.small,
                            onPressed: () {
                              setState(() => _selectedCategory = category);
                            },
                            child: Text(label),
                          )
                        : OutlineButton(
                            size: ButtonSize.small,
                            onPressed: () {
                              setState(() => _selectedCategory = category);
                            },
                            child: Text(label),
                          );
                  }).toList(),
                ),
                SizedBox(height: 8.h),

                // Score slider
                Text(
                  context.l10n.label_rating_score(_score.toStringAsFixed(1)),
                  style: context.typography.semiBold,
                ),
                SizedBox(height: 4.h),
                Row(
                  spacing: 8.w,
                  children: [
                    Icon(LucideIcons.star, size: 16.sp),
                    Expanded(
                      child: Slider(
                        value: SliderValue.single(_score),
                        min: 1.0,
                        max: 5.0,
                        divisions: 8,
                        // label: _score.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() => _score = value.value);
                        },
                      ),
                    ),
                    Icon(LucideIcons.star, size: 20.sp),
                  ],
                ),
                SizedBox(height: 8.h),

                // Comment field
                Text(
                  context.l10n.label_comment_optional,
                  style: context.typography.semiBold,
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  maxLength: 500,
                  placeholder: Text(context.l10n.placeholder_share_experience),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlineButton(
            enabled: !_isSubmitting,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.button_cancel),
          ),
          SizedBox(
            width: 120.w,
            child: PrimaryButton(
              enabled: !_isSubmitting,
              onPressed: _submitReview,
              child: _isSubmitting
                  ? const Submiting()
                  : Text(context.l10n.button_submit),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper function to show the review dialog
Future<bool?> showReviewDialog({
  required BuildContext context,
  required String orderId,
  required String toUserId,
  required String toUserName,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReviewSubmissionDialog(
      orderId: orderId,
      toUserId: toUserId,
      toUserName: toUserName,
    ),
  );
}
