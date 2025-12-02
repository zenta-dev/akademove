import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/presentation/cubits/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for submitting a review after completing an order
class ReviewSubmissionDialog extends material.StatefulWidget {
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
  material.State<ReviewSubmissionDialog> createState() =>
      _ReviewSubmissionDialogState();
}

class _ReviewSubmissionDialogState
    extends material.State<ReviewSubmissionDialog> {
  ReviewCategory _selectedCategory = ReviewCategory.COURTESY;
  double _score = 5.0;
  final _commentController = material.TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final reviewCubit = context.read<DriverReviewCubit>();

    await reviewCubit.submitReview(
      orderId: widget.orderId,
      toUserId: widget.toUserId,
      category: _selectedCategory,
      score: _score,
      comment: _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim(),
    );

    if (!mounted) return;

    final state = reviewCubit.state;

    if (state.isSuccess && state.submitted != null) {
      material.Navigator.of(context).pop(true);
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: 'Success',
          message: state.message ?? 'Review submitted successfully',
        ),
      );
    } else if (state.isFailure) {
      setState(() => _isSubmitting = false);
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: 'Error',
          message: state.error?.message ?? 'Failed to submit review',
        ),
      );
    }
  }

  @override
  material.Widget build(material.BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Rate Customer'),
      content: material.SingleChildScrollView(
        child: material.SizedBox(
          width: material.MediaQuery.of(context).size.width * 0.8,
          child: material.Column(
            mainAxisSize: material.MainAxisSize.min,
            crossAxisAlignment: material.CrossAxisAlignment.start,
            children: [
              // Customer name
              Text(
                'How was your experience with ${widget.toUserName}?',
                style: theme.typography.small,
              ),
              const material.SizedBox(height: 24),

              // Category selector
              Text('Review Category', style: theme.typography.semiBold),
              const material.SizedBox(height: 8),
              material.Wrap(
                spacing: 8,
                children: ReviewCategory.values.map((category) {
                  final label = switch (category) {
                    ReviewCategory.CLEANLINESS => 'Cleanliness',
                    ReviewCategory.COURTESY => 'Courtesy',
                    ReviewCategory.OTHER => 'Other',
                  };
                  return OutlineButton(
                    size: ButtonSize.small,
                    onPressed: () {
                      setState(() => _selectedCategory = category);
                    },
                    child: Text(label),
                  );
                }).toList(),
              ),
              const material.SizedBox(height: 24),

              // Score slider
              Text(
                'Rating: ${_score.toStringAsFixed(1)} / 5.0',
                style: theme.typography.semiBold,
              ),
              const material.SizedBox(height: 8),
              material.Row(
                children: [
                  const Icon(LucideIcons.star, size: 16),
                  material.Expanded(
                    child: material.Slider(
                      value: _score,
                      min: 1.0,
                      max: 5.0,
                      divisions: 8,
                      label: _score.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() => _score = value);
                      },
                    ),
                  ),
                  const Icon(LucideIcons.star, size: 20),
                ],
              ),
              const material.SizedBox(height: 24),

              // Comment field
              Text('Comment (Optional)', style: theme.typography.semiBold),
              const material.SizedBox(height: 8),
              material.TextField(
                controller: _commentController,
                maxLines: 3,
                maxLength: 500,
                decoration: const material.InputDecoration(
                  hintText: 'Share your experience...',
                  border: material.OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlineButton(
          onPressed: _isSubmitting
              ? null
              : () => material.Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        material.SizedBox(
          width: 120,
          child: PrimaryButton(
            onPressed: _isSubmitting ? null : _submitReview,
            child: _isSubmitting
                ? const material.SizedBox(
                    width: 16,
                    height: 16,
                    child: material.CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          material.AlwaysStoppedAnimation<material.Color>(
                            material.Colors.white,
                          ),
                    ),
                  )
                : const Text('Submit'),
          ),
        ),
      ],
    );
  }
}

/// Helper function to show the review dialog
Future<bool?> showReviewDialog({
  required material.BuildContext context,
  required String orderId,
  required String toUserId,
  required String toUserName,
}) {
  return material.showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReviewSubmissionDialog(
      orderId: orderId,
      toUserId: toUserId,
      toUserName: toUserName,
    ),
  );
}
