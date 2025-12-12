import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverReviewsScreen extends StatefulWidget {
  const DriverReviewsScreen({super.key});

  @override
  State<DriverReviewsScreen> createState() => _DriverReviewsScreenState();
}

class _DriverReviewsScreenState extends State<DriverReviewsScreen> {
  final _scrollController = ScrollController();

  DriverReviewCubit get _cubit => context.read<DriverReviewCubit>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
      headers: [AppBar(title: Text(context.l10n.my_reviews))],
      body: BlocBuilder<DriverReviewCubit, DriverReviewState>(
        builder: (context, state) {
          if (state.fetchReviewsResult.isLoading && state.reviews.isEmpty) {
            return Center(child: CircularProgressIndicator());
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
                    color: context.colorScheme.muted,
                  ),
                  Text(
                    context.l10n.no_reviews_yet,
                    style: context.typography.small,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshTrigger(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.dg),
              itemCount: state.reviews.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.reviews.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final review = state.reviews[index];
                return _ReviewCard(review: review);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
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
                        style: context.typography.semiBold,
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
                _buildRating(context, review.score),
              ],
            ),
            if (review.comment?.isNotEmpty == true)
              Text(review.comment ?? '', style: context.typography.small),
            Row(
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 4.w),
                Text(
                  DateFormat('MMM dd, yyyy').format(review.createdAt.toLocal()),
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, num score) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getRatingColor(context, score),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        spacing: 4.w,
        children: [
          Icon(LucideIcons.star, size: 14.sp, color: Colors.white),
          Text(
            score.toStringAsFixed(1),
            style: context.typography.small.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(BuildContext context, num score) {
    if (score >= 4.5) {
      return context.colorScheme.primary;
    } else if (score >= 3.5) {
      return Colors.orange;
    } else {
      return context.colorScheme.destructive;
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
