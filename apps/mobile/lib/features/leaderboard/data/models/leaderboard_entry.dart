import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

/// Represents a leaderboard entry with driver information for UI display.
///
/// This model wraps the API LeaderboardWithDriver model and provides
/// convenient accessors for UI components.
class LeaderboardEntry extends Equatable {
  const LeaderboardEntry({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.driverRating,
    required this.rank,
    required this.score,
    required this.rankChange,
    this.driverImage,
  });

  /// Unique identifier for the leaderboard entry
  final String id;

  /// Driver ID
  final String driverId;

  /// Display name of the driver
  final String driverName;

  /// Profile image URL of the driver
  final String? driverImage;

  /// Customer rating of the driver (e.g., 4.5)
  final double driverRating;

  /// Current rank position (1-10)
  final int rank;

  /// Performance score used for ranking
  final int score;

  /// Rank change compared to the previous period.
  /// Positive = moved up, Negative = moved down, 0 = no change
  final int rankChange;

  /// Create a LeaderboardEntry from API LeaderboardWithDriver model
  factory LeaderboardEntry.fromApi(LeaderboardWithDriver lb) {
    final driver = lb.driver;
    final previousRank = lb.previousRank;

    // Calculate rank change: positive means moved up
    final rankChange = previousRank != null ? previousRank - lb.rank : 0;

    return LeaderboardEntry(
      id: lb.id,
      driverId: lb.driverId ?? lb.userId,
      driverName: driver?.name ?? 'Driver ${lb.userId.substring(0, 8)}',
      driverImage: driver?.image,
      driverRating: driver?.rating.toDouble() ?? 0.0,
      rank: lb.rank,
      score: lb.score,
      rankChange: rankChange,
    );
  }

  @override
  List<Object?> get props => [
    id,
    driverId,
    driverName,
    driverImage,
    driverRating,
    rank,
    score,
    rankChange,
  ];

  /// Creates a LeaderboardEntry from JSON map.
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'] as String,
      driverId: json['driverId'] as String,
      driverName: json['driverName'] as String? ?? 'Unknown Driver',
      driverImage: json['driverImage'] as String?,
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
      'driverId': driverId,
      'driverName': driverName,
      'driverImage': driverImage,
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
