import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart' as api_client;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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

class _LeaderboardViewState extends State<_LeaderboardView> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        return MyScaffold(
          scrollable: false,
          padding: EdgeInsets.zero,
          headers: [DefaultAppBar(title: context.l10n.leaderboard_title)],
          onRefresh: state.isLoading
              ? null
              : () => context.read<LeaderboardCubit>().refresh(),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, LeaderboardState state) {
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
              style: TextStyle(color: context.colorScheme.destructive),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () => context.read<LeaderboardCubit>().init(),
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Tab Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: TabList(
            index: _tabIndex,
            onChanged: (index) => setState(() => _tabIndex = index),
            children: [
              TabChild(child: Text(context.l10n.tab_rankings)),
              TabChild(child: Text(context.l10n.tab_badges)),
            ],
          ),
        ),

        // Tab Views
        Expanded(
          child: IndexedStack(
            index: _tabIndex,
            children: [_buildLeaderboardTab(state), _buildBadgesTab(state)],
          ),
        ),
      ],
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

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge, required this.isEarned});

  final api_client.Badge badge;
  final bool isEarned;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      LucideIcons.trophy,
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
              style: context.typography.p.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
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
                  color: const Color(0xFF22C55E).withAlpha(51),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.check,
                      size: 12.sp,
                      color: const Color(0xFF22C55E),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      context.l10n.text_earned,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF22C55E),
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
