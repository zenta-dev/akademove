import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTransferScanScreen extends StatefulWidget {
  const UserWalletTransferScanScreen({super.key});

  @override
  State<UserWalletTransferScanScreen> createState() =>
      _UserWalletTransferScanScreenState();
}

class _UserWalletTransferScanScreenState
    extends State<UserWalletTransferScanScreen> {
  late MobileScannerController _controller;
  bool _isProcessing = false;
  bool _torchEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: context.l10n.scan_qr,
          trailing: [
            IconButton(
              variance: const ButtonStyle.ghost(),
              icon: Icon(_torchEnabled ? LucideIcons.zapOff : LucideIcons.zap),
              onPressed: _toggleTorch,
            ),
          ],
        ),
      ],
      child: Stack(
        children: [
          // Camera preview
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Overlay with scan area indicator
          _buildScanOverlay(context),
          // Instructions at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 48.h,
            child: _buildInstructions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScanOverlay(BuildContext context) {
    final scanAreaSize = 250.w;

    return ColoredBox(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent overlay with cutout
          ClipPath(
            clipper: _ScannerOverlayClipper(
              scanAreaSize: scanAreaSize,
              borderRadius: 16.r,
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.6)),
          ),
          // Scan area border
          Center(
            child: Container(
              width: scanAreaSize,
              height: scanAreaSize,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                children: [
                  // Corner indicators
                  _buildCorner(Alignment.topLeft),
                  _buildCorner(Alignment.topRight),
                  _buildCorner(Alignment.bottomLeft),
                  _buildCorner(Alignment.bottomRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    final isTop =
        alignment == Alignment.topLeft || alignment == Alignment.topRight;
    final isLeft =
        alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;

    return Positioned(
      top: isTop ? 0 : null,
      bottom: !isTop ? 0 : null,
      left: isLeft ? 0 : null,
      right: !isLeft ? 0 : null,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  )
                : BorderSide.none,
            bottom: !isTop
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  )
                : BorderSide.none,
            left: isLeft
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  )
                : BorderSide.none,
            right: !isLeft
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.card,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.qrCode,
            size: 32.w,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.scan_qr_to_transfer,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            context.l10n.or_enter_manually,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _toggleTorch() {
    _controller.toggleTorch();
    setState(() {
      _torchEnabled = !_torchEnabled;
    });
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Try to parse the QR code data
      final result = await _parseQrCode(rawValue);
      if (result != null && mounted) {
        // Return the result to the transfer screen
        context.pop(result);
      } else if (mounted) {
        _showInvalidQrError();
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        _showInvalidQrError();
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<UserLookupResult?> _parseQrCode(String rawValue) async {
    // Expected QR format:
    // 1. JSON: {"userId": "xxx", "name": "xxx", ...}
    // 2. Simple user ID: "userId:xxx"
    // 3. URL with user ID: "akademove://transfer?userId=xxx"

    try {
      // Try JSON format first
      if (rawValue.startsWith('{')) {
        final json = jsonDecode(rawValue) as Map<String, dynamic>;
        final userId = json['userId'] as String?;
        final name = json['name'] as String?;
        final image = json['image'] as String?;

        if (userId != null && name != null) {
          return UserLookupResult(id: userId, name: name, image: image);
        }
      }

      // Try simple format: "userId:xxx"
      if (rawValue.startsWith('userId:')) {
        final userId = rawValue.substring(7);
        if (userId.isNotEmpty) {
          // Need to look up user details from server
          return _lookupUserById(userId);
        }
      }

      // Try URL format: akademove://transfer?userId=xxx
      final uri = Uri.tryParse(rawValue);
      if (uri != null && uri.queryParameters.containsKey('userId')) {
        final userId = uri.queryParameters['userId'];
        if (userId != null && userId.isNotEmpty) {
          return _lookupUserById(userId);
        }
      }

      // If none of the formats match, try to use rawValue as userId directly
      // This handles simple QR codes that just contain a user ID
      if (rawValue.length >= 20 && rawValue.length <= 50) {
        // Looks like it might be a UUID or similar ID
        return _lookupUserById(rawValue);
      }
    } catch (e) {
      logger.e('Failed to parse QR code', error: e);
    }

    return null;
  }

  Future<UserLookupResult?> _lookupUserById(String userId) async {
    // For now, we'll return a minimal result with just the ID
    // The transfer screen can validate the user ID when making the transfer
    // In a real implementation, you might want to call an API to get user details

    // Return minimal result - the transfer will validate on the server
    return UserLookupResult(
      id: userId,
      name: 'User',
      // The transfer screen will use this ID directly
    );
  }

  void _showInvalidQrError() {
    context.showMyToast(
      'Invalid QR code. Please scan a valid transfer QR code.',
      type: ToastType.failed,
    );
  }
}

/// Custom clipper to create the scan area cutout
class _ScannerOverlayClipper extends CustomClipper<Path> {
  _ScannerOverlayClipper({
    required this.scanAreaSize,
    required this.borderRadius,
  });

  final double scanAreaSize;
  final double borderRadius;

  @override
  Path getClip(Size size) {
    final path = Path();
    // Full screen rect
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Calculate scan area position (centered)
    final left = (size.width - scanAreaSize) / 2;
    final top = (size.height - scanAreaSize) / 2;

    // Subtract the scan area with rounded corners
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
        Radius.circular(borderRadius),
      ),
    );

    // Use evenOdd fill type to create the cutout effect
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(covariant _ScannerOverlayClipper oldClipper) {
    return oldClipper.scanAreaSize != scanAreaSize ||
        oldClipper.borderRadius != borderRadius;
  }
}
