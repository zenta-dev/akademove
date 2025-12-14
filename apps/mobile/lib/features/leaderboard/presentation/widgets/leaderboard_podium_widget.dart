import 'package:akademove/core/_export.dart';
import 'package:akademove/features/leaderboard/data/models/leaderboard_entry.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Colors;

/// A widget that displays the top 3 drivers in a podium format.
///
/// The podium shows:
/// - Rank 1 in the center with the tallest podium
/// - Rank 2 on the left with a shorter podium
/// - Rank 3 on the right with the shortest podium
class LeaderboardPodiumWidget extends StatelessWidget {
  const LeaderboardPodiumWidget({super.key, required this.topThree});

  /// The top 3 leaderboard entries (must have 1-3 items, sorted by rank)
  final List<LeaderboardEntry> topThree;

  @override
  Widget build(BuildContext context) {
    if (topThree.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get entries for each position (may be null if less than 3 entries)
    final first = topThree.isNotEmpty ? topThree[0] : null;
    final second = topThree.length > 1 ? topThree[1] : null;
    final third = topThree.length > 2 ? topThree[2] : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colorScheme.primary.withValues(alpha: 0.1),
            context.colorScheme.background,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place (Left)
          if (second != null)
            Expanded(
              child: _PodiumItem(
                entry: second,
                podiumHeight: 100.h,
                podiumColor: _silverColor,
                crownIcon: '2',
              ),
            )
          else
            const Expanded(child: SizedBox.shrink()),

          SizedBox(width: 8.w),

          // 1st Place (Center - tallest)
          if (first != null)
            Expanded(
              child: _PodiumItem(
                entry: first,
                podiumHeight: 130.h,
                podiumColor: _goldColor,
                crownIcon: '1',
                isFirst: true,
              ),
            )
          else
            const Expanded(child: SizedBox.shrink()),

          SizedBox(width: 8.w),

          // 3rd Place (Right)
          if (third != null)
            Expanded(
              child: _PodiumItem(
                entry: third,
                podiumHeight: 80.h,
                podiumColor: _bronzeColor,
                crownIcon: '3',
              ),
            )
          else
            const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  const _PodiumItem({
    required this.entry,
    required this.podiumHeight,
    required this.podiumColor,
    required this.crownIcon,
    this.isFirst = false,
  });

  final LeaderboardEntry entry;
  final double podiumHeight;
  final Color podiumColor;
  final String crownIcon;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Driver Avatar with crown/rank badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar circle
            Container(
              width: isFirst ? 80.w : 64.w,
              height: isFirst ? 80.w : 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: podiumColor, width: 3),
                color: context.colorScheme.card,
              ),
              child: Center(
                child: Icon(
                  LucideIcons.user,
                  size: isFirst ? 40.sp : 32.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ),
            // Rank badge
            Positioned(
              bottom: -8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: podiumColor,
                    boxShadow: [
                      BoxShadow(
                        color: podiumColor.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      crownIcon,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Driver Name
        Text(
          entry.driverName,
          style: context.typography.small.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: isFirst ? 14.sp : 12.sp,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: 4.h),

        // Driver Rating
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.star, size: 14.sp, color: _goldColor),
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

        SizedBox(height: 12.h),

        // Podium stand
        Container(
          width: double.infinity,
          height: podiumHeight,
          decoration: BoxDecoration(
            color: podiumColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
            border: Border(
              top: BorderSide(color: podiumColor, width: 3),
              left: BorderSide(color: podiumColor.withValues(alpha: 0.5)),
              right: BorderSide(color: podiumColor.withValues(alpha: 0.5)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${entry.score}',
                style: context.typography.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: podiumColor,
                  fontSize: isFirst ? 24.sp : 20.sp,
                ),
              ),
              Text(
                'pts',
                style: context.typography.small.copyWith(
                  fontSize: 10.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Medal colors
const Color _goldColor = Color(0xFFFFD700);
const Color _silverColor = Color(0xFFC0C0C0);
const Color _bronzeColor = Color(0xFFCD7F32);
