import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverReviewsDetailScreen extends StatefulWidget {
  const DriverReviewsDetailScreen({super.key});

  @override
  State<DriverReviewsDetailScreen> createState() =>
      _DriverReviewsDetailScreenState();
}

class _DriverReviewsDetailScreenState extends State<DriverReviewsDetailScreen> {
  late DriverReviewCubit _cubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = sl<DriverReviewCubit>();
    _cubit.loadMyReviews(refresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _cubit.loadMoreReviews();
    }
  }

  Future<void> _onRefresh() async {
    await _cubit.refreshReviews();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: Text(context.l10n.my_reviews),
          leading: [
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft),
              onPressed: () => context.pop(),
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      body: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<DriverReviewCubit, DriverReviewState>(
          builder: (context, state) {
            if (state.fetchReviewsResult.isLoading && state.reviews.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.fetchReviewsResult.isFailure && state.reviews.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16.h,
                  children: [
                    Icon(
                      LucideIcons.circleAlert,
                      size: 48.sp,
                      color: context.colorScheme.destructive,
                    ),
                    Text(
                      state.fetchReviewsResult.error?.message ??
                          context.l10n.failed_to_load,
                      style: context.typography.small,
                      textAlign: TextAlign.center,
                    ),
                    PrimaryButton(
                      onPressed: _onRefresh,
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            }

            if (state.reviews.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16.h,
                  children: [
                    Icon(
                      LucideIcons.star,
                      size: 48.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    Text(
                      context.l10n.no_reviews_yet,
                      style: context.typography.p.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshTrigger(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  spacing: 16.h,
                  children: [
                    _buildOverallRating(state.reviews),
                    _buildRatingBreakdown(state.reviews),
                    _buildCategoryBreakdown(state.reviews),
                    _buildRecentReviews(state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverallRating(List<Review> reviews) {
    final averageRating = reviews.isNotEmpty
        ? reviews.fold<num>(0, (sum, r) => sum + r.score) / reviews.length
        : 0.0;
    final totalReviews = reviews.length;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Overall Rating',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.w,
              children: [
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: context.typography.h1.copyWith(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                        color: _getRatingColor(context, averageRating),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < averageRating.round()
                              ? LucideIcons.star
                              : LucideIcons.star,
                          size: 20.sp,
                          color: index < averageRating.round()
                              ? const Color(0xFFFFC107)
                              : context.colorScheme.mutedForeground,
                        );
                      }),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 60.h,
                  color: context.colorScheme.border,
                ),
                Column(
                  children: [
                    Text(
                      totalReviews.toString(),
                      style: context.typography.h2.copyWith(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Reviews',
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBreakdown(List<Review> reviews) {
    final ratingCounts = <int, int>{};
    for (var i = 5; i >= 1; i--) {
      ratingCounts[i] = reviews.where((r) => r.score.round() == i).length;
    }
    final maxCount = ratingCounts.values.isEmpty
        ? 1
        : ratingCounts.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Rating Distribution',
              style: context.typography.h3.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...ratingCounts.entries.map((entry) {
              final percentage = reviews.isNotEmpty
                  ? (entry.value / reviews.length) * 100
                  : 0.0;
              return _buildRatingBar(
                entry.key,
                entry.value,
                percentage,
                maxCount,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(
    int stars,
    int count,
    double percentage,
    int maxCount,
  ) {
    return Row(
      spacing: 8.w,
      children: [
        SizedBox(
          width: 20.w,
          child: Text(
            '$stars',
            style: context.typography.small.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Icon(LucideIcons.star, size: 14.sp, color: const Color(0xFFFFC107)),
        Expanded(
          child: Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: context.colorScheme.muted,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: maxCount > 0 ? count / maxCount : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: _getRatingColor(context, stars.toDouble()),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 50.w,
          child: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBreakdown(List<Review> reviews) {
    final categoryScores = <ReviewCategory, List<num>>{};
    for (final review in reviews) {
      categoryScores.putIfAbsent(review.category, () => []).add(review.score);
    }

    final categoryAverages = categoryScores.map((category, scores) {
      final avg = scores.isNotEmpty
          ? scores.reduce((a, b) => a + b) / scores.length
          : 0.0;
      return MapEntry(category, avg);
    });

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Category Breakdown',
              style: context.typography.h3.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...categoryAverages.entries.map((entry) {
              return _buildCategoryRow(entry.key, entry.value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(ReviewCategory category, num averageScore) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colorScheme.border),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                _getCategoryIcon(category),
                size: 20.sp,
                color: _getCategoryColor(category),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  _formatCategory(context, category),
                  style: context.typography.small.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        LucideIcons.star,
                        size: 12.sp,
                        color: index < averageScore.round()
                            ? const Color(0xFFFFC107)
                            : context.colorScheme.mutedForeground,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _getRatingColor(context, averageScore),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              averageScore.toStringAsFixed(1),
              style: context.typography.small.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReviews(DriverReviewState state) {
    final recentReviews = state.reviews.take(5).toList();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Reviews',
                  style: context.typography.h3.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state.reviews.length > 5)
                  TextButton(
                    onPressed: () {
                      // Show all reviews in a dialog or navigate to full list
                      _showAllReviewsDialog(state.reviews);
                    },
                    child: Text(context.l10n.view_all),
                  ),
              ],
            ),
            ...recentReviews.map((review) => _buildReviewCard(review)),
            if (state.hasMore && state.fetchReviewsResult.isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: context.colorScheme.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      '${context.l10n.text_customer} #${review.fromUserId.substring(0, 8)}',
                      style: context.typography.small.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatCategory(context, review.category),
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getRatingColor(context, review.score),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  spacing: 4.w,
                  children: [
                    Icon(LucideIcons.star, size: 14.sp, color: Colors.white),
                    Text(
                      review.score.toStringAsFixed(1),
                      style: context.typography.small.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment?.isNotEmpty == true)
            Text(
              review.comment!,
              style: context.typography.small,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          Row(
            children: [
              Icon(
                LucideIcons.calendar,
                size: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
              SizedBox(width: 4.w),
              Text(
                DateFormat('MMM dd, yyyy').format(review.createdAt),
                style: context.typography.small.copyWith(
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAllReviewsDialog(List<Review> reviews) {
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.colorScheme.border,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Reviews',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x),
                    onPressed: () => closeDrawer(drawerContext),
                    variance: ButtonVariance.ghost,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return _buildReviewCard(reviews[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(BuildContext context, num score) {
    if (score >= 4.5) {
      return const Color(0xFF4CAF50); // Green
    } else if (score >= 3.5) {
      return const Color(0xFFFF9800); // Orange
    } else {
      return context.colorScheme.destructive;
    }
  }

  Color _getCategoryColor(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return const Color(0xFF2196F3); // Blue
      case ReviewCategory.COURTESY:
        return const Color(0xFF9C27B0); // Purple
      case ReviewCategory.PUNCTUALITY:
        return const Color(0xFF4CAF50); // Green
      case ReviewCategory.SAFETY:
        return const Color(0xFFF44336); // Red
      case ReviewCategory.COMMUNICATION:
        return const Color(0xFFFF9800); // Orange
      case ReviewCategory.OTHER:
        return const Color(0xFF607D8B); // Gray
    }
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
        return LucideIcons.ellipsis;
    }
  }

  String _formatCategory(BuildContext context, ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return context.l10n.cleanliness;
      case ReviewCategory.COURTESY:
        return context.l10n.courtesy;
      case ReviewCategory.PUNCTUALITY:
        return context.l10n.punctuality;
      case ReviewCategory.SAFETY:
        return context.l10n.safety;
      case ReviewCategory.COMMUNICATION:
        return context.l10n.communication;
      case ReviewCategory.OTHER:
        return context.l10n.other;
    }
  }
}
