import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:akademove/l10n/l10n.dart';

class UserRatingScreen extends StatefulWidget {
  const UserRatingScreen({
    required this.orderId,
    required this.driverId,
    required this.driverName,
    super.key,
  });

  final String orderId;
  final String driverId;
  final String driverName;

  @override
  State<UserRatingScreen> createState() => _UserRatingScreenState();
}

class _UserRatingScreenState extends State<UserRatingScreen> {
  /// Selected categories (multi-select)
  final Set<ReviewCategory> _selectedCategories = {};

  /// Overall rating for the review (1-5)
  int _rating = 0;

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    // Must have at least one category selected and a rating > 0
    return _selectedCategories.isNotEmpty && _rating > 0;
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
    if (!_canSubmit) return;

    // BlocListener handles state changes
    context.read<UserReviewCubit>().submitReview(
      orderId: widget.orderId,
      toUserId: widget.driverId,
      categories: _selectedCategories.toList(),
      score: _rating,
      comment: _commentController.text.trim().isNotEmpty
          ? _commentController.text.trim()
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.rate_your_driver)],
      child: BlocListener<UserReviewCubit, UserReviewState>(
        listenWhen: (previous, current) =>
            previous.submittedReview != current.submittedReview,
        listener: (context, state) {
          if (state.submittedReview.isSuccess) {
            context.showMyToast(
              context.l10n.text_thank_you_for_review,
              type: ToastType.success,
            );
            // Pop back to previous screen
            context.pop(true);
          } else if (state.submittedReview.isFailure) {
            context.showMyToast(
              state.submittedReview.error?.message ??
                  context.l10n.toast_failed_submit_review,
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
                // Driver info
                _buildDriverInfo(),

                // Overall rating section
                _buildOverallRatingSection(),

                // Category selector (multi-select)
                _buildCategorySelector(),

                // Comment section
                _buildCommentSection(),

                // Submit button
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Row(
          children: [
            Avatar(
              size: 64.sp,
              initials: Avatar.getInitials(widget.driverName),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    widget.driverName,
                    style: context.typography.h4.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.l10n.how_was_your_experience,
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

  Widget _buildOverallRatingSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              context.l10n.text_rate_overall_experience,
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            // Star rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12.w,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = starValue;
                    });
                  },
                  child: Icon(
                    LucideIcons.star,
                    size: 32.sp,
                    color: starValue <= _rating
                        ? const Color(0xFFFFA000)
                        : context.colorScheme.mutedForeground,
                    fill: starValue <= _rating ? 1.0 : 0.0,
                  ),
                );
              }),
            ),
            if (_rating > 0)
              Text(
                _getRatingLabel(_rating),
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  color: context.colorScheme.primary,
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
          context.l10n.text_select_categories,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          context.l10n.text_select_categories_hint,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: ReviewCategory.values.map((category) {
            final isSelected = _selectedCategories.contains(category);

            return Button(
              style: isSelected
                  ? const ButtonStyle.primary(density: ButtonDensity.compact)
                  : const ButtonStyle.outline(density: ButtonDensity.compact),
              onPressed: () => _toggleCategory(category),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.w,
                children: [
                  Icon(_getCategoryIcon(category), size: 16.sp),
                  Text(_getCategoryLabel(category)),
                  if (isSelected)
                    Icon(
                      LucideIcons.check,
                      size: 14.sp,
                      color: context.colorScheme.primaryForeground,
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          context.l10n.label_additional_comments,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextArea(
          controller: _commentController,
          minLines: 4,
          maxLines: 4,
          maxLength: 500,
          placeholder: Text(context.l10n.placeholder_additional_comments),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<UserReviewCubit, UserReviewState>(
      builder: (context, state) {
        final isLoading = state.submittedReview.isLoading;
        return SizedBox(
          width: double.infinity,
          child: Button.primary(
            enabled: _canSubmit && !isLoading,
            onPressed: isLoading ? null : _submitReview,
            child: isLoading
                ? const Submiting()
                : Text(context.l10n.button_submit_review),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return LucideIcons.sparkles;
      case ReviewCategory.COURTESY:
        return LucideIcons.heart;
      case ReviewCategory.PUNCTUALITY:
        return LucideIcons.clock;
      case ReviewCategory.SAFETY:
        return LucideIcons.shield;
      case ReviewCategory.COMMUNICATION:
        return LucideIcons.messageCircle;
      case ReviewCategory.OTHER:
        return LucideIcons.star;
    }
  }

  String _getCategoryLabel(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return context.l10n.category_cleanliness;
      case ReviewCategory.COURTESY:
        return context.l10n.category_courtesy;
      case ReviewCategory.PUNCTUALITY:
        return context.l10n.category_punctuality;
      case ReviewCategory.SAFETY:
        return context.l10n.category_safety;
      case ReviewCategory.COMMUNICATION:
        return context.l10n.category_communication;
      case ReviewCategory.OTHER:
        return context.l10n.category_overall;
    }
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
