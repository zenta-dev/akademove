import 'package:shadcn_flutter/shadcn_flutter.dart';

/// App-wide color constants for consistent theming
///
/// Use these constants instead of hardcoded Color values to ensure
/// consistent styling across the app and easier theme changes.
abstract final class AppColors {
  AppColors._();

  // ============================================================
  // Status Colors (for order status, availability, etc.)
  // ============================================================

  /// Success/positive status color (e.g., completed, open, online)
  static const Color statusSuccess = Colors.green;

  /// Error/negative status color (e.g., cancelled, closed, offline)
  static const Color statusError = Colors.red;

  /// Warning status color (e.g., on break, pending)
  static const Color statusWarning = Colors.orange;

  /// Info status color (e.g., in progress, active orders)
  static const Color statusInfo = Colors.blue;

  /// Neutral status color (e.g., unknown, loading)
  static const Color statusNeutral = Colors.neutral;

  /// Maintenance/caution status color
  static const Color statusMaintenance = Colors.amber;

  // ============================================================
  // Store Operating Status Colors
  // ============================================================

  /// Store is open and accepting orders
  static const Color storeOpen = Colors.green;

  /// Store is on break (temporarily not accepting)
  static const Color storeBreak = Colors.orange;

  /// Store is under maintenance
  static const Color storeMaintenance = Colors.amber;

  /// Store is closed
  static const Color storeClosed = Colors.red;

  // ============================================================
  // Order Status Colors
  // ============================================================

  /// Order requested/pending
  static const Color orderRequested = Colors.blue;

  /// Order matching with driver
  static const Color orderMatching = Colors.amber;

  /// Order accepted by driver
  static const Color orderAccepted = Colors.green;

  /// Driver arriving
  static const Color orderArriving = Colors.teal;

  /// Order in trip/progress
  static const Color orderInTrip = Colors.blue;

  /// Order preparing (food orders)
  static const Color orderPreparing = Colors.orange;

  /// Order ready for pickup
  static const Color orderReady = Colors.green;

  /// Order completed
  static const Color orderCompleted = Colors.green;

  /// Order cancelled
  static const Color orderCancelled = Colors.red;

  // ============================================================
  // Helper Methods
  // ============================================================

  /// Get color for merchant operating status
  static Color getStoreStatusColor(String? status, {bool isOnline = true}) {
    if (!isOnline) return statusError;
    return switch (status) {
      'OPEN' => storeOpen,
      'BREAK' => storeBreak,
      'MAINTENANCE' => storeMaintenance,
      'CLOSED' => storeClosed,
      _ => statusNeutral,
    };
  }

  /// Get color for order status
  static Color getOrderStatusColor(String? status) {
    return switch (status) {
      'REQUESTED' => orderRequested,
      'MATCHING' => orderMatching,
      'ACCEPTED' => orderAccepted,
      'ARRIVING' => orderArriving,
      'IN_TRIP' => orderInTrip,
      'PREPARING' => orderPreparing,
      'READY_FOR_PICKUP' => orderReady,
      'COMPLETED' => orderCompleted,
      'CANCELLED' => orderCancelled,
      _ => statusNeutral,
    };
  }

  /// Get color with opacity for backgrounds
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}
