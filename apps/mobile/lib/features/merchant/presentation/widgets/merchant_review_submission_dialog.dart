import 'package:akademove/core/_export.dart';
import 'package:akademove/features/merchant/presentation/cubits/_export.dart';
import 'package:akademove/features/merchant/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for merchants to submit a review after completing an order
/// Supports rating both customers and drivers
class MerchantReviewSubmissionDialog extends StatefulWidget {
  const MerchantReviewSubmissionDialog({
    required this.orderId,
    required this.toUserId,
    required this.toUserName,
    required this.isDriverReview,
    super.key,
  });

  final String orderId;
  final String toUserId;
  final String toUserName;
  final bool isDriverReview;

  @override
  State<MerchantReviewSubmissionDialog> createState() =>
      _MerchantReviewSubmissionDialogState();
}

class _MerchantReviewSubmissionDialogState
    extends State<MerchantReviewSubmissionDialog> {
  /// Selected categories (multi-select)
  final Set<ReviewCategory> _selectedCategories = {ReviewCategory.COURTESY};

  /// Overall rating score (1-5)
  int _score = 5;

  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    return _selectedCategories.isNotEmpty && _score > 0;
  }

  void _toggleCategory(ReviewCategory category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _submitReview() {
    if (_isSubmitting || !_canSubmit) return;

    setState(() => _isSubmitting = true);

    // BlocListener handles state changes
    context.read<MerchantReviewCubit>().submitReview(
      orderId: widget.orderId,
      toUserId: widget.toUserId,
      categories: _selectedCategories.toList(),
      score: _score,
      comment: _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim(),
      isDriverReview: widget.isDriverReview,
    );
  }

  void _onReviewStateChanged(MerchantReviewState state) {
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
    final dialogTitle = widget.isDriverReview
        ? context.l10n.rate_your_driver
        : context.l10n.title_rate_customer;

    return BlocListener<MerchantReviewCubit, MerchantReviewState>(
      listenWhen: (previous, current) =>
          previous.submitReviewResult != current.submitReviewResult,
      listener: (context, state) => _onReviewStateChanged(state),
      child: AlertDialog(
        title: Text(dialogTitle),
        content: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuerySize.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // User name
                Text(
                  context.l10n.text_experience_with_user(widget.toUserName),
                  style: context.typography.small,
                ),
                SizedBox(height: 8.h),

                // Overall rating (star rating)
                Text(
                  context.l10n.text_rate_overall_experience,
                  style: context.typography.semiBold,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.w,
                  children: List.generate(5, (index) {
                    final starValue = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _score = starValue;
                        });
                      },
                      child: Icon(
                        LucideIcons.star,
                        size: 28.sp,
                        color: starValue <= _score
                            ? const Color(0xFFFFA000)
                            : context.colorScheme.mutedForeground,
                        fill: starValue <= _score ? 1.0 : 0.0,
                      ),
                    );
                  }),
                ),
                if (_score > 0)
                  Center(
                    child: Text(
                      _getRatingLabel(_score),
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                SizedBox(height: 8.h),

                // Category selector (multi-select)
                Text(
                  context.l10n.text_select_categories,
                  style: context.typography.semiBold,
                ),
                SizedBox(height: 4.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: ReviewCategory.values.map((category) {
                    final isSelected = _selectedCategories.contains(category);
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
                            onPressed: () => _toggleCategory(category),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 4.w,
                              children: [
                                Text(label),
                                Icon(LucideIcons.check, size: 12.sp),
                              ],
                            ),
                          )
                        : OutlineButton(
                            size: ButtonSize.small,
                            onPressed: () => _toggleCategory(category),
                            child: Text(label),
                          );
                  }).toList(),
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
              enabled: !_isSubmitting && _canSubmit,
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

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return context.l10n.rating_poor;
      case 2:
        return context.l10n.rating_below_average;
      case 3:
        return context.l10n.rating_average;
      case 4:
        return context.l10n.rating_good;
      case 5:
        return context.l10n.rating_excellent;
      default:
        return '';
    }
  }
}

/// Helper function to show the merchant review dialog
Future<bool?> showMerchantReviewDialog({
  required BuildContext context,
  required String orderId,
  required String toUserId,
  required String toUserName,
  required bool isDriverReview,
}) {
  // Capture the cubit before showDialog since the dialog context
  // won't have access to BlocProviders in the calling widget tree
  final reviewCubit = context.read<MerchantReviewCubit>();

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => BlocProvider.value(
      value: reviewCubit,
      child: MerchantReviewSubmissionDialog(
        orderId: orderId,
        toUserId: toUserId,
        toUserName: toUserName,
        isDriverReview: isDriverReview,
      ),
    ),
  );
}
