import 'dart:async';
import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Monitors network connectivity and shows a snackbar when offline
///
/// Wrap your app with this widget to get automatic offline detection:
/// ```dart
/// ConnectivityMonitor(
///   onReconnected: () => print('Network restored'),
///   child: MaterialApp(...),
/// )
/// ```
class ConnectivityMonitor extends StatefulWidget {
  const ConnectivityMonitor({
    required this.child,
    this.onReconnected,
    super.key,
  });

  final Widget child;
  final VoidCallback? onReconnected;

  @override
  State<ConnectivityMonitor> createState() => _ConnectivityMonitorState();
}

class _ConnectivityMonitorState extends State<ConnectivityMonitor> {
  Timer? _checkTimer;
  bool _wasOnline = true;
  bool _isCheckingConnectivity = false;

  @override
  void initState() {
    super.initState();
    // Check connectivity every 10 seconds
    _checkTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _checkConnectivity(),
    );
    // Initial check
    Future.delayed(const Duration(seconds: 2), _checkConnectivity);
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    if (_isCheckingConnectivity) return;

    _isCheckingConnectivity = true;

    try {
      // Try a lightweight network operation
      // We'll check if we can reach any endpoint (this is a simple ping check)
      // In production, you might want to ping a specific health endpoint
      final result = await Future.any([
        Future.delayed(const Duration(seconds: 3), () => false),
        _pingNetwork(),
      ]);

      if (!mounted) return;

      final isOnline = result;

      // Show toast when going offline
      if (_wasOnline && !isOnline) {
        _showOfflineToast();
      }

      // Show toast when coming back online
      if (!_wasOnline && isOnline) {
        _showOnlineToast();
        // Trigger reconnection callback
        widget.onReconnected?.call();
      }

      _wasOnline = isOnline;
    } finally {
      _isCheckingConnectivity = false;
    }
  }

  Future<bool> _pingNetwork() async {
    try {
      // Perform actual DNS lookup to verify network connectivity
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    } catch (e) {
      return false;
    }
  }

  void _showOfflineToast() {
    if (!mounted) return;

    showToast(
      context: context,
      location: ToastLocation.bottomCenter,
      builder: (context, overlay) => context.buildToast(
        title: 'No Internet Connection',
        message: 'Please check your internet connection and try again.',
      ),
    );
  }

  void _showOnlineToast() {
    if (!mounted) return;

    showToast(
      context: context,
      location: ToastLocation.bottomCenter,
      builder: (context, overlay) => context.buildToast(
        title: 'Back Online',
        message: 'Your internet connection has been restored.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
