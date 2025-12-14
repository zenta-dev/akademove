import 'package:equatable/equatable.dart';

/// Represents a leaderboard entry with driver information.
///
/// This model extends the API Leaderboard model with additional
/// driver-specific fields needed for the UI display.
class LeaderboardEntry extends Equatable {
  const LeaderboardEntry({
    required this.id,
    required this.userId,
    required this.driverName,
    required this.driverRating,
    required this.rank,
    required this.score,
    required this.rankChange,
  });

  /// Unique identifier for the leaderboard entry
  final String id;

  /// User ID of the driver
  final String userId;

  /// Display name of the driver
  final String driverName;

  /// Customer rating of the driver (e.g., 4.5)
  final double driverRating;

  /// Current rank position (1-10)
  final int rank;

  /// Performance score used for ranking
  final int score;

  /// Rank change compared to the previous period.
  /// Positive = moved up, Negative = moved down, 0 = no change
  final int rankChange;

  @override
  List<Object?> get props => [
    id,
    userId,
    driverName,
    driverRating,
    rank,
    score,
    rankChange,
  ];

  /// Creates a LeaderboardEntry from JSON map.
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'] as String,
      userId: json['userId'] as String,
      driverName: json['driverName'] as String? ?? 'Unknown Driver',
      driverRating: (json['driverRating'] as num?)?.toDouble() ?? 0.0,
      rank: json['rank'] as int,
      score: json['score'] as int,
      rankChange: json['rankChange'] as int? ?? 0,
    );
  }

  /// Converts the LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'driverName': driverName,
      'driverRating': driverRating,
      'rank': rank,
      'score': score,
      'rankChange': rankChange,
    };
  }
}

/// Represents the rank change direction for UI display
enum RankChangeDirection {
  up,
  down,
  neutral;

  static RankChangeDirection fromChange(int change) {
    if (change > 0) return RankChangeDirection.up;
    if (change < 0) return RankChangeDirection.down;
    return RankChangeDirection.neutral;
  }
}
