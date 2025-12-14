import 'package:akademove/core/_export.dart';
import 'package:akademove/features/leaderboard/data/models/leaderboard_entry.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Colors;

/// A widget that displays a single leaderboard entry in list format.
///
/// Used for displaying drivers ranked 4-10 in the leaderboard.
/// Shows driver name, rank, and rank change indicator.
class LeaderboardListItem extends StatelessWidget {
  const LeaderboardListItem({super.key, required this.entry});

  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final rankChange = RankChangeDirection.fromChange(entry.rankChange);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Rank number
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  '${entry.rank}',
                  style: context.typography.h4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.secondaryForeground,
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Driver avatar
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.muted,
                border: Border.all(color: context.colorScheme.border, width: 1),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.user,
                  size: 24.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Driver info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.driverName,
                    style: context.typography.p.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.star,
                        size: 14.sp,
                        color: const Color(0xFFFFD700),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        entry.driverRating.toStringAsFixed(1),
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

            // Rank change indicator
            _RankChangeIndicator(
              direction: rankChange,
              changeAmount: entry.rankChange.abs(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that shows the rank change indicator (up/down/neutral arrow)
class _RankChangeIndicator extends StatelessWidget {
  const _RankChangeIndicator({
    required this.direction,
    required this.changeAmount,
  });

  final RankChangeDirection direction;
  final int changeAmount;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (direction) {
      RankChangeDirection.up => (LucideIcons.trendingUp, _upColor),
      RankChangeDirection.down => (LucideIcons.trendingDown, _downColor),
      RankChangeDirection.neutral => (LucideIcons.minus, _neutralColor),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: color),
          if (direction != RankChangeDirection.neutral) ...[
            SizedBox(width: 4.w),
            Text(
              changeAmount.toString(),
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

const Color _upColor = Color(0xFF22C55E); // Green
const Color _downColor = Color(0xFFEF4444); // Red
const Color _neutralColor = Color(0xFF9CA3AF); // Gray
