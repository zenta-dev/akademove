import "package:flutter/scheduler.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A wrapper around [RefreshTrigger] that prevents the
/// "Build scheduled during frame" error.
///
/// This error occurs when [RefreshTrigger] internally calls setState
/// during scroll notifications while a frame is being rendered. This
/// specifically happens during ballistic scroll (inertial scrolling after
/// the user lifts their finger) when layout dimensions change.
///
/// This widget only blocks scroll notifications during the layout phase
/// (persistentCallbacks) to prevent the error, while allowing normal
/// user-initiated scroll notifications through for smooth pull-to-refresh.
///
/// Usage:
/// ```dart
/// SafeRefreshTrigger(
///   onRefresh: () async {
///     // Refresh logic
///   },
///   child: SingleChildScrollView(
///     child: YourContent(),
///   ),
/// )
/// ```
class SafeRefreshTrigger extends StatefulWidget {
  const SafeRefreshTrigger({
    required this.onRefresh,
    required this.child,
    super.key,
  });

  /// Callback triggered when user pulls to refresh.
  final Future<void> Function() onRefresh;

  /// The scrollable child widget.
  final Widget child;

  @override
  State<SafeRefreshTrigger> createState() => _SafeRefreshTriggerState();
}

class _SafeRefreshTriggerState extends State<SafeRefreshTrigger> {
  @override
  Widget build(BuildContext context) {
    // The key insight: notifications propagate UPWARD in Flutter.
    // RefreshTrigger has its own NotificationListener that calls setState.
    // We need to wrap the CHILD with our NotificationListener so we can
    // intercept notifications BEFORE they reach RefreshTrigger.
    return RefreshTrigger(
      onRefresh: widget.onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Only block during persistentCallbacks phase (layout/paint).
          // This is specifically when the "Build scheduled during frame"
          // error occurs - during ballistic scroll when dimensions change.
          //
          // We explicitly allow notifications during:
          // - idle: normal state between frames
          // - transientCallbacks: animation ticks (needed for smooth scrolling)
          // - postFrameCallbacks: after frame is done
          // - midFrameMicrotasks: microtasks during frame
          //
          // The error only happens during persistentCallbacks when
          // BallisticScrollActivity.applyNewDimensions triggers a notification
          // during layout.
          final phase = WidgetsBinding.instance.schedulerPhase;
          if (phase == SchedulerPhase.persistentCallbacks) {
            return true; // Absorb to prevent error
          }
          return false; // Let it through for normal operation
        },
        child: widget.child,
      ),
    );
  }
}
