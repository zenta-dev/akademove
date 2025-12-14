import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Driver Leaderboard Screen
///
/// Displays the top 10 drivers:
/// - Top section: Podium showing ranks 1-3
/// - Bottom section: Scrollable list showing ranks 4-10
///
/// Data refreshes every 24 hours from the backend.
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
          child: state.leaderboardEntries.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: _buildBody(context, state),
                ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DriverLeaderboardState state) {
    if (state.leaderboardEntries.isFailure) {
      return _buildErrorState(context, state);
    }

    final entries = state.leaderboardEntries.value ?? [];
    if (entries.isEmpty) {
      return _buildEmptyState(context);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Podium Section (Top 3)
          if (state.topThree.isNotEmpty)
            LeaderboardPodiumWidget(topThree: state.topThree),

          // Daily refresh info
          _buildRefreshInfo(context),

          // Other Rankings Section (4-10)
          if (state.otherRankings.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                context.l10n.leaderboard_other_rankings,
                style: context.typography.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            _buildRankingsList(state),
          ],

          // Bottom padding
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildRefreshInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.clock,
            size: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          SizedBox(width: 8.w),
          Text(
            context.l10n.leaderboard_refreshes_daily,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingsList(DriverLeaderboardState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: state.otherRankings.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: LeaderboardListItem(entry: entry),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.trophy,
              size: 64.sp,
              color: context.colorScheme.mutedForeground,
            ),
            SizedBox(height: 16.h),
            Text(
              context.l10n.leaderboard_empty_state,
              style: context.typography.p.copyWith(
                color: context.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, DriverLeaderboardState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.circleAlert,
              size: 64.sp,
              color: context.colorScheme.destructive,
            ),
            SizedBox(height: 16.h),
            Text(
              state.leaderboardEntries.error?.message ??
                  context.l10n.failed_to_load,
              style: context.typography.p.copyWith(
                color: context.colorScheme.destructive,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () => context.read<DriverLeaderboardCubit>().init(),
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
