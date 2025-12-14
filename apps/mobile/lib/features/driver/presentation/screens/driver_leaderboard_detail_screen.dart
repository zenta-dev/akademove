import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverLeaderboardDetailScreen extends StatefulWidget {
  const DriverLeaderboardDetailScreen({super.key});

  @override
  State<DriverLeaderboardDetailScreen> createState() =>
      _DriverLeaderboardDetailScreenState();
}

class _DriverLeaderboardDetailScreenState
    extends State<DriverLeaderboardDetailScreen> {
  DriverLeaderboardCubit get _cubit => context.read<DriverLeaderboardCubit>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyRankings();
    });
  }

  Future<void> _loadMyRankings() async {
    setState(() => _isLoading = true);

    try {
      // Get current user ID from DriverProfileCubit
      final userId = context.read<DriverProfileCubit>().driver?.user?.id ?? '';

      if (userId.isEmpty) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }

      await _cubit.loadMyRankings();

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast('Failed to load rankings', type: ToastType.failed);
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadMyRankings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: Text(context.l10n.leaderboard_title),
          leading: [
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft),
              onPressed: () => context.pop(),
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      child: SafeRefreshTrigger(
        onRefresh: _onRefresh,
        child: BlocBuilder<DriverLeaderboardCubit, DriverLeaderboardState>(
          builder: (context, state) {
            final myRankingsResult = state.myRankings;

            if (_isLoading && myRankingsResult.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (myRankingsResult.isFailure) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
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
                            myRankingsResult.error?.message ??
                                'Failed to load rankings',
                            style: context.typography.small,
                            textAlign: TextAlign.center,
                          ),
                          PrimaryButton(
                            onPressed: _onRefresh,
                            child: Text(context.l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            final myRankings = myRankingsResult.value ?? [];

            if (myRankings.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16.h,
                        children: [
                          Icon(
                            LucideIcons.trophy,
                            size: 48.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                          Text(
                            context.l10n.text_no_rankings_yet,
                            style: context.typography.p.copyWith(
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                          PrimaryButton(
                            onPressed: _onRefresh,
                            child: Text(context.l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  spacing: 16.h,
                  children: [
                    _buildOverallStats(myRankings),
                    _buildRankingsByCategory(myRankings),
                    _buildPerformanceMetrics(myRankings),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverallStats(List<LeaderboardWithDriver> rankings) {
    final bestRank = rankings.isNotEmpty
        ? rankings.reduce((a, b) => a.rank < b.rank ? a : b)
        : null;
    final categories = rankings.map((r) => r.category.value).toSet().toList();
    final totalScore = rankings.fold<num>(0, (sum, r) => sum + r.score);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Overall Performance',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Best Rank',
                    bestRank?.rank.toString() ?? '-',
                    LucideIcons.trophy,
                    const Color(0xFFFFD700), // Gold
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    'Categories',
                    categories.length.toString(),
                    LucideIcons.layers,
                    context.colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    'Total Score',
                    totalScore.toString(),
                    LucideIcons.star,
                    const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          Icon(icon, color: color, size: 24.sp),
          Text(
            label,
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            value,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingsByCategory(List<LeaderboardWithDriver> rankings) {
    final rankingsByCategory = <String, List<LeaderboardWithDriver>>{};
    for (final ranking in rankings) {
      rankingsByCategory
          .putIfAbsent(ranking.category.value, () => [])
          .add(ranking);
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Rankings by Category',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...rankingsByCategory.entries.map((entry) {
              return _buildCategoryRanking(entry.key, entry.value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRanking(
    String category,
    List<LeaderboardWithDriver> rankings,
  ) {
    final bestRanking = rankings.isNotEmpty
        ? rankings.reduce((a, b) => a.rank < b.rank ? a : b)
        : null;

    return Container(
      padding: EdgeInsets.all(12.dg),
      margin: EdgeInsets.only(bottom: 8.h),
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
              child: Text(
                _getCategoryIcon(category),
                style: TextStyle(
                  fontSize: 20.sp,
                  color: _getCategoryColor(category),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  category,
                  style: context.typography.h4.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Best Rank: #${bestRanking?.rank ?? '-'}',
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.h,
            children: [
              Text(
                bestRanking?.score.toString() ?? '0',
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                context.l10n.leaderboard_pts,
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

  Widget _buildPerformanceMetrics(List<LeaderboardWithDriver> rankings) {
    if (rankings.isEmpty) return const SizedBox.shrink();

    final periods = rankings.map((r) => r.period.value).toSet().toList();
    final recentRankings = rankings
        .where(
          (r) =>
              r.period.value.contains('monthly') ||
              r.period.value.contains('weekly'),
        )
        .toList();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Performance Metrics',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Active Periods',
                    periods.length,
                    LucideIcons.calendar,
                    context.colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: _buildMetricCard(
                    'Recent Rankings',
                    recentRankings.length,
                    LucideIcons.trendingUp,
                    const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            if (recentRankings.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                'Recent Performance',
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...recentRankings
                  .take(3)
                  .map((ranking) => _buildRecentRankingCard(ranking)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, int value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          Icon(icon, color: color, size: 20.sp),
          Text(
            label,
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            value.toString(),
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRankingCard(LeaderboardWithDriver ranking) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: context.colorScheme.card,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colorScheme.border),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: _getRankColor(ranking.rank).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#${ranking.rank}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: _getRankColor(ranking.rank),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  ranking.category.value,
                  style: context.typography.small.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ranking.period.value,
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.h,
            children: [
              Text(
                ranking.score.toString(),
                style: context.typography.h4.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                context.l10n.leaderboard_pts,
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'trips':
        return const Color(0xFF2196F3);
      case 'earnings':
        return const Color(0xFF4CAF50);
      case 'rating':
        return const Color(0xFFFF9800);
      case 'reliability':
        return const Color(0xFF9C27B0);
      default:
        return context.colorScheme.primary;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'trips':
        return '🚗';
      case 'earnings':
        return '💰';
      case 'rating':
        return '⭐';
      case 'reliability':
        return '🛡️';
      default:
        return '📊';
    }
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700); // Gold
    if (rank == 2) return const Color(0xFFC0C0C0); // Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Bronze
    return context.colorScheme.primary;
  }
}
