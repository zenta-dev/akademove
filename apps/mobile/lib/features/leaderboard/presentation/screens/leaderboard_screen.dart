import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart' as api_client;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LeaderboardView();
  }
}

class _LeaderboardView extends StatefulWidget {
  const _LeaderboardView();

  @override
  State<_LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<_LeaderboardView> {
  Future<void> _onRefresh() async {
    await context.read<DriverLeaderboardCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverLeaderboardCubit, DriverLeaderboardState>(
      builder: (context, state) {
        return Scaffold(
          headers: [DefaultAppBar(title: context.l10n.leaderboard_title)],
          child: state.leaderboards.isLoading
              ? _buildBody(context, state)
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: _buildBody(context, state),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DriverLeaderboardState state) {
    if (state.leaderboards.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.leaderboards.isFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.leaderboards.error?.message ?? 'Failed to load data',
              style: TextStyle(color: context.colorScheme.destructive),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () => context.read<DriverLeaderboardCubit>().init(),
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      );
    }

    return _buildLeaderboardTab(state);
  }

  Widget _buildLeaderboardTab(DriverLeaderboardState state) {
    final leaderboards = state.leaderboards.value ?? [];

    if (leaderboards.isEmpty) {
      return Center(child: Text(context.l10n.text_no_rankings_yet));
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: leaderboards
            .map((leaderboard) => _LeaderboardCard(leaderboard: leaderboard))
            .toList(),
      ),
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  const _LeaderboardCard({required this.leaderboard});

  final api_client.Leaderboard leaderboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Rank Badge
              _buildRankBadge(context),
              SizedBox(width: 16.w),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.text_user_id(
                        leaderboard.userId.substring(0, 8),
                      ),
                      style: context.typography.p.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.text_category_value(
                        leaderboard.category.value,
                      ),
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.text_period_value(leaderboard.period.value),
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),

              // Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    leaderboard.score.toString(),
                    style: context.typography.h4.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(
                    context.l10n.leaderboard_pts,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge(BuildContext context) {
    Color badgeColor;
    IconData icon;

    if (leaderboard.rank == 1) {
      badgeColor = const Color(0xFFFFD700); // Gold
      icon = LucideIcons.trophy;
    } else if (leaderboard.rank == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
      icon = LucideIcons.medal;
    } else if (leaderboard.rank == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
      icon = LucideIcons.award;
    } else {
      badgeColor = context.colorScheme.secondary;
      icon = LucideIcons.user;
    }

    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: badgeColor.withAlpha(51), // ~20% opacity
        shape: BoxShape.circle,
        border: Border.all(color: badgeColor, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: badgeColor, size: 24.sp),
          Text(
            '#${leaderboard.rank}',
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
