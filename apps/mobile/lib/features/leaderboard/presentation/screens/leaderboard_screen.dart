import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart' as api_client;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LeaderboardCubit>()..init(),
      child: const _LeaderboardView(),
    );
  }
}

class _LeaderboardView extends StatefulWidget {
  const _LeaderboardView();

  @override
  State<_LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<_LeaderboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.leaderboard_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message ?? 'Failed to load data',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<LeaderboardCubit>().init(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<LeaderboardCubit>().refresh(),
            child: Column(
              children: [
                // Tab Bar
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: context.l10n.tab_rankings),
                    Tab(text: context.l10n.tab_badges),
                  ],
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildLeaderboardTab(state),
                      _buildBadgesTab(state),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeaderboardTab(LeaderboardState state) {
    final leaderboards = state.leaderboards.value ?? [];

    if (leaderboards.isEmpty) {
      return Center(child: Text(context.l10n.text_no_rankings_yet));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: leaderboards.length,
      itemBuilder: (context, index) {
        final leaderboard = leaderboards[index];
        return _LeaderboardCard(leaderboard: leaderboard);
      },
    );
  }

  Widget _buildBadgesTab(LeaderboardState state) {
    final badges = state.badges.value ?? [];
    final userBadges = state.userBadges.value ?? [];

    if (badges.isEmpty) {
      return Center(child: Text(context.l10n.leaderboard_no_badges));
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.85,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
        final isEarned = userBadges.any((ub) => ub.badgeId == badge.id);
        return _BadgeCard(badge: badge, isEarned: isEarned);
      },
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  const _LeaderboardCard({required this.leaderboard});

  final api_client.Leaderboard leaderboard;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.l10n.text_category_value(
                      leaderboard.category.value,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.l10n.text_period_value(leaderboard.period.value),
                    style: Theme.of(context).textTheme.bodySmall,
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  context.l10n.leaderboard_pts,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(BuildContext context) {
    Color badgeColor;
    IconData icon;

    if (leaderboard.rank == 1) {
      badgeColor = const Color(0xFFFFD700); // Gold
      icon = Icons.emoji_events;
    } else if (leaderboard.rank == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
      icon = Icons.military_tech;
    } else if (leaderboard.rank == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
      icon = Icons.workspace_premium;
    } else {
      badgeColor = Theme.of(context).colorScheme.secondary;
      icon = Icons.person;
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

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge, required this.isEarned});

  final api_client.Badge badge;
  final bool isEarned;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isEarned ? 4 : 1,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: _getBadgeLevelColor(badge.level).withAlpha(51),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getBadgeLevelColor(badge.level),
                  width: isEarned ? 3 : 1,
                ),
              ),
              child: Center(
                child: Builder(
                  builder: (context) {
                    final icon = badge.icon;
                    if (icon != null) {
                      return Text(icon, style: TextStyle(fontSize: 40.sp));
                    }
                    return Icon(
                      Icons.emoji_events,
                      size: 40.sp,
                      color: _getBadgeLevelColor(badge.level),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Badge Name
            Text(
              badge.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),

            // Badge Level
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _getBadgeLevelColor(badge.level).withAlpha(51),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                badge.level.value,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: _getBadgeLevelColor(badge.level),
                ),
              ),
            ),

            // Earned Status
            if (isEarned) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(51),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12.sp, color: Colors.green),
                    SizedBox(width: 4.w),
                    Text(
                      context.l10n.text_earned,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBadgeLevelColor(api_client.BadgeLevel level) {
    switch (level) {
      case api_client.BadgeLevel.BRONZE:
        return const Color(0xFFCD7F32);
      case api_client.BadgeLevel.SILVER:
        return const Color(0xFFC0C0C0);
      case api_client.BadgeLevel.GOLD:
        return const Color(0xFFFFD700);
      case api_client.BadgeLevel.PLATINUM:
        return const Color(0xFFE5E4E2);
      case api_client.BadgeLevel.DIAMOND:
        return const Color(0xFFB9F2FF);
    }
  }
}
