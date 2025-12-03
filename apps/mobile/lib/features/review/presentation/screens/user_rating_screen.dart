import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
  final Map<ReviewCategory, int> _ratings = {};
  final TextEditingController _commentController = TextEditingController();
  ReviewCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize all categories with 0 rating
    for (final category in ReviewCategory.values) {
      _ratings[category] = 0;
    }
    // Default to first category
    _selectedCategory = ReviewCategory.values.first;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    // Check if at least one category has a rating
    return _ratings.values.any((rating) => rating > 0) &&
        _selectedCategory != null;
  }

  Future<void> _submitReview() async {
    if (!_canSubmit) return;

    final category = _selectedCategory;
    if (category == null) return;

    final rating = _ratings[category] ?? 0;
    if (rating == 0) {
      if (mounted) {
        context.showMyToast(
          context.l10n.toast_please_rate_category(category.name),
          type: ToastType.failed,
        );
      }
      return;
    }

    final cubit = context.read<UserReviewCubit>();
    await cubit.submitReview(
      orderId: widget.orderId,
      toUserId: widget.driverId,
      category: category,
      score: rating,
      comment: _commentController.text.trim().isNotEmpty
          ? _commentController.text.trim()
          : null,
    );

    if (!mounted) return;

    final state = cubit.state;
    if (state.isSuccess) {
      context.showMyToast(
        context.l10n.text_thank_you_for_review,
        type: ToastType.success,
      );
      // Pop back to previous screen
      context.pop(true);
    } else if (state.isFailure) {
      context.showMyToast(
        state.error?.message ?? context.l10n.toast_failed_submit_review,
        type: ToastType.failed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.rate_your_driver)],
      body: BlocListener<UserReviewCubit, UserReviewState>(
        listener: (context, state) {
          if (state.isFailure) {
            context.showMyToast(
              state.error?.message ?? context.l10n.toast_failed_submit_review,
              type: ToastType.failed,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.h,
            children: [
              // Driver info
              _buildDriverInfo(),

              // Category selector
              _buildCategorySelector(),

              // Rating stars for selected category
              if (_selectedCategory != null) _buildRatingSection(),

              // Comment section
              _buildCommentSection(),

              // Submit button
              _buildSubmitButton(),
            ],
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

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          context.l10n.text_rate_by_category,
          style: context.typography.h4.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: ReviewCategory.values.map((category) {
            final isSelected = _selectedCategory == category;
            final rating = _ratings[category] ?? 0;

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
                  if (rating > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colorScheme.primaryForeground
                            : context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.primaryForeground,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    final category = _selectedCategory!;
    final rating = _ratings[category] ?? 0;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              _getCategoryDescription(category),
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            // Star rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12.w,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return material.GestureDetector(
                  onTap: () {
                    setState(() {
                      _ratings[category] = starValue;
                    });
                  },
                  child: Icon(
                    starValue <= rating
                        ? material.Icons.star_rounded
                        : material.Icons.star_border_rounded,
                    size: 48.sp,
                    color: starValue <= rating
                        ? const Color(0xFFFFA000)
                        : context.colorScheme.mutedForeground,
                  ),
                );
              }),
            ),
            if (rating > 0)
              Text(
                _getRatingLabel(rating),
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
        material.TextField(
          controller: _commentController,
          maxLines: 4,
          maxLength: 500,
          decoration: material.InputDecoration(
            hintText: context.l10n.placeholder_additional_comments,
            border: const material.OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<UserReviewCubit, UserReviewState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Button.primary(
            enabled: _canSubmit && !state.isLoading,
            onPressed: state.isLoading ? null : _submitReview,
            child: state.isLoading
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
        return material.Icons.cleaning_services_rounded;
      case ReviewCategory.COURTESY:
        return material.Icons.favorite_rounded;
      case ReviewCategory.PUNCTUALITY:
        return material.Icons.schedule_rounded;
      case ReviewCategory.SAFETY:
        return material.Icons.security_rounded;
      case ReviewCategory.COMMUNICATION:
        return material.Icons.chat_bubble_rounded;
      case ReviewCategory.OTHER:
        return material.Icons.star_rounded;
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

  String _getCategoryDescription(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return context.l10n.category_desc_cleanliness;
      case ReviewCategory.COURTESY:
        return context.l10n.category_desc_courtesy;
      case ReviewCategory.PUNCTUALITY:
        return context.l10n.category_desc_punctuality;
      case ReviewCategory.SAFETY:
        return context.l10n.category_desc_safety;
      case ReviewCategory.COMMUNICATION:
        return context.l10n.category_desc_communication;
      case ReviewCategory.OTHER:
        return context.l10n.category_desc_overall;
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
