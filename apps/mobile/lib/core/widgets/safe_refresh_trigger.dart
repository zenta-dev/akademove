import "package:shadcn_flutter/shadcn_flutter.dart";

/// A wrapper around [RefreshTrigger] that prevents the
/// "Build scheduled during frame" error.
///
/// This error occurs when [RefreshTrigger] internally calls setState
/// during scroll notifications on the first frame of rendering.
/// This widget absorbs all scroll notifications during the first frame
/// to prevent the error.
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
  /// Flag to prevent "Build scheduled during frame" error from RefreshTrigger.
  /// During the first frame, we absorb all scroll notifications.
  bool _isFirstFrame = true;

  @override
  void initState() {
    super.initState();
    // Allow scroll notifications after first frame to prevent
    // "Build scheduled during frame" error from RefreshTrigger
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isFirstFrame = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // Absorb scroll notifications during first frame to prevent
      // "Build scheduled during frame" error from RefreshTrigger
      onNotification: _isFirstFrame ? (_) => true : null,
      child: RefreshTrigger(onRefresh: widget.onRefresh, child: widget.child),
    );
  }
}
