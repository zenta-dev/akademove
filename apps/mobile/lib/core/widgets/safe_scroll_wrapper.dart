import "package:flutter/scheduler.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A mixin that provides safe scroll notification handling.
///
/// This mixin helps prevent the "Build scheduled during frame" error
/// by checking if the app is currently in a build phase before allowing
/// scroll notifications to propagate.
mixin SafeScrollMixin<T extends StatefulWidget> on State<T> {
  /// Flag to track if we're still in the first frame.
  bool _isFirstFrame = true;

  /// Whether the widget is in its first frame of rendering.
  bool get isFirstFrame => _isFirstFrame;

  /// Call this in initState to set up first frame detection.
  void initSafeScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isFirstFrame = false);
      }
    });
  }

  /// Check if we're currently in the middle of a frame (layout/build phase).
  ///
  /// This catches the "Build scheduled during frame" error that can occur
  /// during ballistic scroll when dimensions change.
  bool get isInBuildPhase {
    final binding = WidgetsBinding.instance;
    // During layout/build phase, schedulerPhase is typically persistentCallbacks
    // or transientCallbacks. We should only allow notifications during idle.
    return binding.schedulerPhase != SchedulerPhase.idle &&
        binding.schedulerPhase != SchedulerPhase.postFrameCallbacks;
  }

  /// Returns true if scroll notifications should be absorbed.
  ///
  /// Use this in NotificationListener.onNotification to prevent
  /// "Build scheduled during frame" errors.
  bool shouldAbsorbScrollNotification() {
    return _isFirstFrame || isInBuildPhase;
  }
}

/// A wrapper widget that absorbs scroll notifications during unsafe phases
/// to prevent the "Build scheduled during frame" error.
///
/// This is useful when you have a scrollable widget that might trigger
/// state changes during scroll, which can cause Flutter framework errors.
///
/// The widget also supports an optional [blockWhen] callback to conditionally
/// block scroll notifications (e.g., when dragging a map marker).
///
/// Usage:
/// ```dart
/// SafeScrollWrapper(
///   child: SingleChildScrollView(
///     child: YourContent(),
///   ),
/// )
/// ```
///
/// With conditional blocking:
/// ```dart
/// SafeScrollWrapper(
///   blockWhen: () => _isDraggingMarker,
///   child: SingleChildScrollView(
///     child: YourContent(),
///   ),
/// )
/// ```
class SafeScrollWrapper extends StatefulWidget {
  const SafeScrollWrapper({required this.child, this.blockWhen, super.key});

  /// The scrollable child widget.
  final Widget child;

  /// Optional callback to conditionally block scroll notifications.
  ///
  /// When this returns true, scroll notifications will be absorbed.
  /// This is useful for scenarios like blocking scroll while dragging
  /// a map marker.
  final bool Function()? blockWhen;

  @override
  State<SafeScrollWrapper> createState() => _SafeScrollWrapperState();
}

class _SafeScrollWrapperState extends State<SafeScrollWrapper>
    with SafeScrollMixin {
  @override
  void initState() {
    super.initState();
    initSafeScroll();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Check custom blocking condition first
        if (widget.blockWhen?.call() ?? false) {
          return true;
        }
        // Then check build phase safety
        if (shouldAbsorbScrollNotification()) {
          return true;
        }
        return false;
      },
      child: widget.child,
    );
  }
}
