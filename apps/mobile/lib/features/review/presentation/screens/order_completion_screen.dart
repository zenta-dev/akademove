import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/l10n/l10n.dart";
import "package:akademove/locator.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// The role of the viewer for the order completion screen.
/// Determines who is rating whom.
enum OrderCompletionViewerRole {
  /// User (customer) rating driver (and optionally merchant for FOOD orders)
  user,

  /// Driver rating user (customer)
  driver,

  /// Merchant rating user (customer) - for FOOD orders only
  merchant,
}

/// Order completion screen shown after an order is completed.
/// Displays fare summary and allows rating based on viewer role:
/// - USER: rates driver (and merchant for FOOD orders)
/// - DRIVER: rates user (customer)
/// - MERCHANT: rates user (customer)
class OrderCompletionScreen extends StatefulWidget {
  const OrderCompletionScreen({
    required this.orderId,
    required this.orderType,
    required this.order,
    this.viewerRole = OrderCompletionViewerRole.user,
    this.driver,
    this.user,
    this.merchant,
    this.payment,
    super.key,
  });

  final String orderId;
  final OrderType orderType;
  final Order order;

  /// The role of the viewer (who is rating)
  final OrderCompletionViewerRole viewerRole;

  /// Driver info - required when viewerRole is user
  final Driver? driver;

  /// User (customer) info - required when viewerRole is driver or merchant
  final User? user;

  final Merchant? merchant;
  final Payment? payment;

  @override
  State<OrderCompletionScreen> createState() => _OrderCompletionScreenState();
}

class _OrderCompletionScreenState extends State<OrderCompletionScreen> {
  // Primary rating state (driver for USER, customer for DRIVER/MERCHANT)
  int _primaryRating = 0;
  final Set<ReviewCategory> _primaryCategories = {};
  final TextEditingController _primaryCommentController =
      TextEditingController();

  // Secondary rating state (merchant for FOOD orders when USER is viewing)
  int _secondaryRating = 0;
  final Set<ReviewCategory> _secondaryCategories = {};
  final TextEditingController _secondaryCommentController =
      TextEditingController();

  bool _isSubmitting = false;
  bool _hasSubmittedReview = false;

  @override
  void dispose() {
    _primaryCommentController.dispose();
    _secondaryCommentController.dispose();
    super.dispose();
  }

  /// Whether to show a secondary rating section (merchant rating for USER viewing FOOD orders)
  bool get _showSecondaryRating =>
      widget.viewerRole == OrderCompletionViewerRole.user &&
      widget.orderType == OrderType.FOOD &&
      widget.merchant != null;

  bool get _canSubmit {
    // Must have primary rating with at least one category
    if (_primaryRating == 0 || _primaryCategories.isEmpty) return false;

    // If showing secondary rating, must also have it filled
    if (_showSecondaryRating) {
      if (_secondaryRating == 0 || _secondaryCategories.isEmpty) return false;
    }

    return true;
  }

  void _togglePrimaryCategory(ReviewCategory category) {
    setState(() {
      if (_primaryCategories.contains(category)) {
        _primaryCategories.remove(category);
      } else {
        _primaryCategories.add(category);
      }
    });
  }

  void _toggleSecondaryCategory(ReviewCategory category) {
    setState(() {
      if (_secondaryCategories.contains(category)) {
        _secondaryCategories.remove(category);
      } else {
        _secondaryCategories.add(category);
      }
    });
  }

  /// Get the target user ID for the primary rating based on viewer role
  String? get _primaryTargetUserId {
    switch (widget.viewerRole) {
      case OrderCompletionViewerRole.user:
        // User rates driver
        return widget.driver?.userId;
      case OrderCompletionViewerRole.driver:
      case OrderCompletionViewerRole.merchant:
        // Driver/Merchant rates user (customer)
        return widget.user?.id ?? widget.order.userId;
    }
  }

  /// Get the target user name for the primary rating based on viewer role
  String get _primaryTargetName {
    switch (widget.viewerRole) {
      case OrderCompletionViewerRole.user:
        return widget.driver?.user?.name ?? context.l10n.text_driver;
      case OrderCompletionViewerRole.driver:
      case OrderCompletionViewerRole.merchant:
        return widget.user?.name ??
            widget.order.user?.name ??
            context.l10n.text_customer;
    }
  }

  /// Get the avatar initials for the primary rating target
  String get _primaryAvatarInitials {
    switch (widget.viewerRole) {
      case OrderCompletionViewerRole.user:
        return Avatar.getInitials(
          widget.driver?.user?.name ?? context.l10n.text_driver,
        );
      case OrderCompletionViewerRole.driver:
      case OrderCompletionViewerRole.merchant:
        return Avatar.getInitials(
          widget.user?.name ??
              widget.order.user?.name ??
              context.l10n.text_customer,
        );
    }
  }

  /// Get the avatar image for the primary rating target
  String? get _primaryAvatarImage {
    switch (widget.viewerRole) {
      case OrderCompletionViewerRole.user:
        return widget.driver?.user?.image;
      case OrderCompletionViewerRole.driver:
      case OrderCompletionViewerRole.merchant:
        return widget.user?.image ?? widget.order.user?.image;
    }
  }

  /// Get the rating title based on viewer role
  String get _primaryRatingTitle {
    switch (widget.viewerRole) {
      case OrderCompletionViewerRole.user:
        return context.l10n.rate_your_driver;
      case OrderCompletionViewerRole.driver:
      case OrderCompletionViewerRole.merchant:
        return context.l10n.rate_customer;
    }
  }

  Future<void> _submitReviews() async {
    if (!_canSubmit || _isSubmitting) return;

    final primaryTargetId = _primaryTargetUserId;
    if (primaryTargetId == null) {
      context.showMyToast(
        context.l10n.toast_failed_submit_review,
        type: ToastType.failed,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Use the appropriate cubit based on viewer role
      if (widget.viewerRole == OrderCompletionViewerRole.user) {
        final cubit = context.read<UserReviewCubit>();

        // Submit primary review (driver)
        await cubit.submitReview(
          orderId: widget.orderId,
          toUserId: primaryTargetId,
          categories: _primaryCategories.toList(),
          score: _primaryRating,
          comment: _primaryCommentController.text.trim().isNotEmpty
              ? _primaryCommentController.text.trim()
              : null,
        );

        // Submit secondary review (merchant) if applicable
        if (_showSecondaryRating && widget.merchant != null) {
          await cubit.submitReview(
            orderId: widget.orderId,
            toUserId: widget.merchant!.userId,
            categories: _secondaryCategories.toList(),
            score: _secondaryRating,
            comment: _secondaryCommentController.text.trim().isNotEmpty
                ? _secondaryCommentController.text.trim()
                : null,
          );
        }
      } else if (widget.viewerRole == OrderCompletionViewerRole.driver) {
        // Driver submitting review for customer
        final cubit = context.read<DriverReviewCubit>();

        await cubit.submitReview(
          orderId: widget.orderId,
          toUserId: primaryTargetId,
          categories: _primaryCategories.toList(),
          score: _primaryRating,
          comment: _primaryCommentController.text.trim().isNotEmpty
              ? _primaryCommentController.text.trim()
              : null,
        );
      } else {
        // Merchant submitting review for customer
        final cubit = context.read<MerchantReviewCubit>();

        await cubit.submitReview(
          orderId: widget.orderId,
          toUserId: primaryTargetId,
          categories: _primaryCategories.toList(),
          score: _primaryRating,
          comment: _primaryCommentController.text.trim().isNotEmpty
              ? _primaryCommentController.text.trim()
              : null,
        );
      }

      if (mounted) {
        _hasSubmittedReview = true;
        context.showMyToast(
          context.l10n.text_thank_you_for_review,
          type: ToastType.success,
        );
        // For driver role, clear active order and navigate to home
        if (widget.viewerRole == OrderCompletionViewerRole.driver) {
          context.read<DriverOrderCubit>().clearActiveOrder();
          context.popUntilRoot();
        } else if (widget.viewerRole == OrderCompletionViewerRole.merchant) {
          // For merchant role, navigate back to order list
          context.popUntilRoot();
        } else {
          context.pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(
          context.l10n.toast_failed_submit_review,
          type: ToastType.failed,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _navigateToReport(String targetUserId, String targetUserName) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider(
          create: (_) => sl<SharedReportCubit>(),
          child: ReportUserScreen(
            targetUserId: targetUserId,
            targetUserName: targetUserName,
            orderId: widget.orderId,
          ),
        ),
      ),
    );
  }

  /// Build the appropriate BlocListener based on viewer role
  Widget _buildBlocListener({required Widget child}) {
    if (widget.viewerRole == OrderCompletionViewerRole.user) {
      return BlocListener<UserReviewCubit, UserReviewState>(
        listenWhen: (previous, current) =>
            previous.submittedReview != current.submittedReview,
        listener: (context, state) {
          if (state.submittedReview.isFailure) {
            context.showMyToast(
              state.submittedReview.error?.message ??
                  context.l10n.toast_failed_submit_review,
              type: ToastType.failed,
            );
          }
        },
        child: child,
      );
    } else if (widget.viewerRole == OrderCompletionViewerRole.driver) {
      // Driver role
      return BlocListener<DriverReviewCubit, DriverReviewState>(
        listenWhen: (previous, current) =>
            previous.submitReviewResult != current.submitReviewResult,
        listener: (context, state) {
          if (state.submitReviewResult.isFailure) {
            context.showMyToast(
              state.submitReviewResult.error?.message ??
                  context.l10n.toast_failed_submit_review,
              type: ToastType.failed,
            );
          }
        },
        child: child,
      );
    } else {
      // Merchant role
      return BlocListener<MerchantReviewCubit, MerchantReviewState>(
        listenWhen: (previous, current) =>
            previous.submitReviewResult != current.submitReviewResult,
        listener: (context, state) {
          if (state.submitReviewResult.isFailure) {
            context.showMyToast(
              state.submitReviewResult.error?.message ??
                  context.l10n.toast_failed_submit_review,
              type: ToastType.failed,
            );
          }
        },
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // For driver role, clear active order when navigating away
        // (if review was not submitted)
        if (didPop &&
            widget.viewerRole == OrderCompletionViewerRole.driver &&
            !_hasSubmittedReview) {
          context.read<DriverOrderCubit>().clearActiveOrder();
        }
      },
      child: Scaffold(
        headers: [DefaultAppBar(title: context.l10n.order_completed)],
        child: _buildBlocListener(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20.h,
                    children: [
                      // Order completed header with date/time/id
                      _OrderCompletedHeader(order: widget.order),

                      // Fare summary card
                      _FareSummaryCard(
                        order: widget.order,
                        payment: widget.payment,
                      ),

                      // Primary rating section (driver for USER, customer for DRIVER/MERCHANT)
                      _RatingSection(
                        title: _primaryRatingTitle,
                        subtitle: _primaryTargetName,
                        avatarInitials: _primaryAvatarInitials,
                        avatarImage: _primaryAvatarImage,
                        rating: _primaryRating,
                        onRatingChanged: (rating) {
                          setState(() {
                            _primaryRating = rating;
                          });
                        },
                        selectedCategories: _primaryCategories,
                        onCategoryToggle: _togglePrimaryCategory,
                        commentController: _primaryCommentController,
                        onReport: () {
                          final targetId = _primaryTargetUserId;
                          if (targetId != null) {
                            _navigateToReport(targetId, _primaryTargetName);
                          }
                        },
                      ),

                      // Secondary rating section (merchant for FOOD orders when USER is viewing)
                      if (_showSecondaryRating && widget.merchant != null)
                        _RatingSection(
                          title: context.l10n.rate_merchant_title,
                          subtitle: widget.merchant!.name,
                          avatarInitials: Avatar.getInitials(
                            widget.merchant!.name,
                          ),
                          avatarImage: widget.merchant!.image,
                          rating: _secondaryRating,
                          onRatingChanged: (rating) {
                            setState(() {
                              _secondaryRating = rating;
                            });
                          },
                          selectedCategories: _secondaryCategories,
                          onCategoryToggle: _toggleSecondaryCategory,
                          commentController: _secondaryCommentController,
                          onReport: () => _navigateToReport(
                            widget.merchant!.userId,
                            widget.merchant!.name,
                          ),
                        ),

                      Gap(60.h), // Space for the fixed button
                    ],
                  ),
                ),
              ),

              // Fixed submit button at bottom
              _SubmitButton(
                canSubmit: _canSubmit,
                isSubmitting: _isSubmitting,
                onSubmit: _submitReviews,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Order completed header with date, time, and order ID
class _OrderCompletedHeader extends StatelessWidget {
  const _OrderCompletedHeader({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final completedAt = order.updatedAt;
    final dateFormat = DateFormat("dd MMM yyyy");
    final timeFormat = DateFormat("HH:mm");

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Success icon
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                LucideIcons.circleCheck,
                size: 32.sp,
                color: context.colorScheme.primary,
              ),
            ),
            Gap(12.h),
            DefaultText(
              context.l10n.order_completed,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            Gap(8.h),
            // Date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.w,
              children: [
                Row(
                  spacing: 4.w,
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    DefaultText(
                      dateFormat.format(completedAt),
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ],
                ),
                Row(
                  spacing: 4.w,
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    DefaultText(
                      timeFormat.format(completedAt),
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ],
                ),
              ],
            ),
            Gap(4.h),
            // Order ID
            DefaultText(
              "Order #${order.id.substring(0, 8).toUpperCase()}",
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

/// Fare summary card showing breakdown of charges
class _FareSummaryCard extends StatelessWidget {
  const _FareSummaryCard({required this.order, this.payment});

  final Order order;
  final Payment? payment;

  @override
  Widget build(BuildContext context) {
    // Calculate fare breakdown
    final baseFare = order.basePrice;
    final discount = order.discountAmount ?? 0;
    final total = order.totalPrice;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.receipt,
                  size: 18.sp,
                  color: context.colorScheme.primary,
                ),
                DefaultText(
                  context.l10n.order_detail_summary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const Divider(),
            // Base fare
            _FareRow(
              label: context.l10n.label_base_fare,
              value: context.formatCurrency(baseFare),
            ),
            // Discount
            if (discount > 0)
              _FareRow(
                label: context.l10n.label_discount,
                value: "-${context.formatCurrency(discount)}",
                isDiscount: true,
              ),
            const Divider(),
            // Total
            _FareRow(
              label: context.l10n.label_total_price,
              value: context.formatCurrency(total),
              isBold: true,
            ),
            // Payment method
            if (payment != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      context.l10n.label_payment_method_lower,
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          _getPaymentIcon(payment!.method),
                          size: 14.sp,
                          color: context.colorScheme.primary,
                        ),
                        DefaultText(
                          _getPaymentMethodName(payment!),
                          fontSize: 12.sp,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.wallet:
        return LucideIcons.wallet;
      case PaymentMethod.QRIS:
        return LucideIcons.qrCode;
      case PaymentMethod.BANK_TRANSFER:
        return LucideIcons.building2;
    }
  }

  String _getPaymentMethodName(Payment payment) {
    switch (payment.method) {
      case PaymentMethod.wallet:
        return "Wallet";
      case PaymentMethod.QRIS:
        return "QRIS";
      case PaymentMethod.BANK_TRANSFER:
        final bankName = payment.bankProvider?.name ?? "";
        return "Bank Transfer${bankName.isNotEmpty ? " ($bankName)" : ""}";
    }
  }
}

/// Individual fare row
class _FareRow extends StatelessWidget {
  const _FareRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isDiscount = false,
  });

  final String label;
  final String value;
  final bool isBold;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          label,
          fontSize: isBold ? 14.sp : 13.sp,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
        DefaultText(
          value,
          fontSize: isBold ? 14.sp : 13.sp,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          color: isDiscount ? Colors.green : null,
        ),
      ],
    );
  }
}

/// Rating section for driver or merchant
class _RatingSection extends StatelessWidget {
  const _RatingSection({
    required this.title,
    required this.subtitle,
    required this.avatarInitials,
    required this.rating,
    required this.onRatingChanged,
    required this.selectedCategories,
    required this.onCategoryToggle,
    required this.commentController,
    required this.onReport,
    this.avatarImage,
  });

  final String title;
  final String subtitle;
  final String avatarInitials;
  final String? avatarImage;
  final int rating;
  final ValueChanged<int> onRatingChanged;
  final Set<ReviewCategory> selectedCategories;
  final ValueChanged<ReviewCategory> onCategoryToggle;
  final TextEditingController commentController;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            // Header with avatar and title
            Row(
              children: [
                Avatar(
                  size: 48.w,
                  initials: avatarInitials,
                  provider: avatarImage != null
                      ? CachedNetworkImageProvider(avatarImage!)
                      : null,
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.h,
                    children: [
                      DefaultText(
                        title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      DefaultText(
                        subtitle,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                // Report button
                IconButton(
                  icon: const Icon(LucideIcons.flag),
                  onPressed: onReport,
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),

            // Star rating
            _StarRating(rating: rating, onRatingChanged: onRatingChanged),

            // Rating label
            if (rating > 0)
              Center(
                child: DefaultText(
                  _getRatingLabel(context, rating),
                  fontSize: 14.sp,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),

            // Category chips
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                DefaultText(
                  context.l10n.text_select_categories,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                DefaultText(
                  context.l10n.text_select_categories_hint,
                  fontSize: 11.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: ReviewCategory.values.map((category) {
                    final isSelected = selectedCategories.contains(category);
                    return Button(
                      style: isSelected
                          ? const ButtonStyle.primary(
                              density: ButtonDensity.compact,
                            )
                          : const ButtonStyle.outline(
                              density: ButtonDensity.compact,
                            ),
                      onPressed: () => onCategoryToggle(category),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          Icon(_getCategoryIcon(category), size: 14.sp),
                          Text(
                            _getCategoryLabel(context, category),
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          if (isSelected)
                            Icon(
                              LucideIcons.check,
                              size: 12.sp,
                              color: context.colorScheme.primaryForeground,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Comment field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                DefaultText(
                  context.l10n.label_additional_comments,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                TextArea(
                  controller: commentController,
                  minLines: 3,
                  maxLines: 3,
                  maxLength: 500,
                  placeholder: Text(
                    context.l10n.placeholder_additional_comments,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

  String _getCategoryLabel(BuildContext context, ReviewCategory category) {
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

  String _getRatingLabel(BuildContext context, int rating) {
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
        return "";
    }
  }
}

/// Star rating widget
class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating, required this.onRatingChanged});

  final int rating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12.w,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return GestureDetector(
          onTap: () => onRatingChanged(starValue),
          child: Icon(
            LucideIcons.star,
            size: 36.sp,
            color: starValue <= rating
                ? const Color(0xFFFFA000)
                : context.colorScheme.mutedForeground,
            fill: starValue <= rating ? 1.0 : 0.0,
          ),
        );
      }),
    );
  }
}

/// Fixed submit button at bottom
class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.canSubmit,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool canSubmit;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: Button.primary(
            enabled: canSubmit && !isSubmitting,
            onPressed: isSubmitting ? null : onSubmit,
            child: isSubmitting
                ? const Submiting()
                : Text(context.l10n.button_submit_review),
          ),
        ),
      ),
    );
  }
}
