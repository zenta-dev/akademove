import 'dart:async';
import 'dart:ui' as ui;

import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class QRISPaymentWidget extends StatefulWidget {
  const QRISPaymentWidget({
    required this.payment,
    required this.transactionType,
    required this.onExpired,
    super.key,
  });

  final Payment payment;
  final TransactionType transactionType;
  final void Function() onExpired;

  @override
  State<QRISPaymentWidget> createState() => _QRISPaymentWidgetState();
}

class _QRISPaymentWidgetState extends State<QRISPaymentWidget> {
  Future<void> _downloadQR(
    BuildContext context,
    String url,
    String? transactionId,
  ) async {
    void showErrorToast(String message) => context.showMyToast(
      message,
      type: ToastType.failed,
      trailing: IconButton(
        icon: const Icon(LucideIcons.refreshCcw),
        variance: const ButtonStyle.ghost(),
        onPressed: () => _downloadQR(context, url, transactionId),
      ),
    );

    try {
      // Load image
      final imageProvider = CachedNetworkImageProvider(url);
      final imageStream = imageProvider.resolve(ImageConfiguration.empty);
      final completer = Completer<ui.Image>();

      imageStream.addListener(
        ImageStreamListener((info, _) => completer.complete(info.image)),
      );

      final qrImage = await completer.future;

      // Canvas setup
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      const padding = 20.0;
      const titleHeight = 100.0;
      const titleQrGap = 20.0;
      final qrSize = qrImage.width.toDouble();
      final totalWidth = qrSize + (padding * 2);
      final totalHeight = qrSize + titleHeight + titleQrGap + (padding * 2);

      // Draw background
      canvas.drawRect(
        Rect.fromLTWH(0, 0, totalWidth, totalHeight),
        Paint()..color = Colors.white,
      );

      // Draw title
      final paragraph =
          (ui.ParagraphBuilder(
                  ui.ParagraphStyle(textAlign: TextAlign.center),
                )
                ..pushStyle(
                  ui.TextStyle(
                    color: Colors.black,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                )
                ..addText('Akademove Pay'))
              .build()
            ..layout(ui.ParagraphConstraints(width: totalWidth));

      canvas
        ..drawParagraph(paragraph, const Offset(0, padding))
        ..drawImage(
          qrImage,
          const Offset(padding, padding + titleHeight + titleQrGap),
          Paint(),
        );

      // Convert to PNG
      final picture = recorder.endRecording();
      final finalImage = await picture.toImage(
        totalWidth.toInt(),
        totalHeight.toInt(),
      );
      final byteData = await finalImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      // Generate filename
      final timestamp =
          transactionId ?? DateTime.now().millisecondsSinceEpoch.toString();
      final fileName = 'akademove_pay_${widget.transactionType}_$timestamp';

      // Save to gallery
      await Gal.putImageBytes(pngBytes, name: fileName);

      if (context.mounted) {
        context.showMyToast(
          'QR code saved successfully',
          type: ToastType.success,
        );
      }
    } on GalException catch (e) {
      final message = switch (e.type) {
        GalExceptionType.accessDenied =>
          'Access denied. Please grant permission in settings.',
        GalExceptionType.notEnoughSpace => 'Not enough storage space.',
        GalExceptionType.notSupportedFormat => 'Image format not supported.',
        GalExceptionType.unexpected => 'Unexpected error: $e',
      };
      showErrorToast(message);
    } catch (e) {
      showErrorToast('Failed to save QR code: $e');
    }
  }

  Future<void> _copyQRUrl(BuildContext context, String url) async {
    try {
      await Clipboard.setData(ClipboardData(text: url));
      if (context.mounted) {
        context.showMyToast(
          'QR URL copied to clipboard',
          type: ToastType.success,
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showMyToast(
          'Failed to copy QR URL: $e',
          type: ToastType.failed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiresAt = widget.payment.expiresAt ?? DateTime.now();
    final dateStr = expiresAt.format('d MMM yyyy, HH:mm');
    final width = 0.9.sw.round();
    final imageUrl =
        widget.payment.paymentUrl ??
        '${UrlConstants.randomImageUrl}/$width/$width';

    return Column(
      spacing: 16.h,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: width.toDouble(),
          height: width.toDouble(),
        ),
        SizedBox(
          width: double.infinity,
          child: Card(
            padding: EdgeInsets.all(8.dg),
            child: Column(
              spacing: 8.h,
              children: [
                Text('Valid until $dateStr').muted(fontSize: 14.sp),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.w,
                  children: [
                    const Text('Remaining Time :').muted(fontSize: 14.sp),
                    TimeTickerWidget(
                      expiresAt: widget.payment.expiresAt,
                      onExpired: widget.onExpired,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: width.toDouble(),
          child: Button.primary(
            onPressed: () => _downloadQR(context, imageUrl, widget.payment.id),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.download, size: 16.sp),
                const Text('Download QR').small,
              ],
            ),
          ),
        ),
        SizedBox(
          width: width.toDouble(),
          child: Button.secondary(
            onPressed: () => _copyQRUrl(context, imageUrl),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.copy, size: 16.sp),
                const Text('Copy QR URL').small,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimeTickerWidget extends StatefulWidget {
  const TimeTickerWidget({required this.onExpired, super.key, this.expiresAt});
  final DateTime? expiresAt;
  final void Function() onExpired;

  @override
  State<TimeTickerWidget> createState() => _TimeTickerWidgetState();
}

class _TimeTickerWidgetState extends State<TimeTickerWidget> {
  Timer? _tickerTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTickerTimer();
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _remainingTime = Duration.zero;
    super.dispose();
  }

  void _startTickerTimer() {
    _updateRemainingTime();
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    if (!mounted) return;

    final expiresAt = widget.expiresAt;
    if (expiresAt == null) return;

    final now = DateTime.now();
    final newRemainingTime = now.isAfter(expiresAt)
        ? Duration.zero
        : expiresAt.difference(now);

    if (_remainingTime.inSeconds != newRemainingTime.inSeconds) {
      setState(() {
        _remainingTime = newRemainingTime;
      });

      if (newRemainingTime.inSeconds <= 0) {
        _handleExpiration();
      }
    }
  }

  void _handleExpiration() {
    _tickerTimer?.cancel();

    setState(() {
      _tickerTimer = null;
      _remainingTime = Duration.zero;
    });

    widget.onExpired();
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      style: const ButtonStyle.outline(
        density: ButtonDensity.dense,
      ),
      child: Row(
        spacing: 4.w,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          NumberTicker(
            initialNumber: 15,
            number: _remainingTime.inMinutes,
            style: context.typography.xSmall.copyWith(
              color: _remainingTime.inMinutes < 1
                  ? Colors.red
                  : context.colorScheme.primary,
            ),
            formatter: (value) => value.toInt().toString().padLeft(2, '0'),
          ),
          const DefaultText(':'),
          NumberTicker(
            initialNumber: 0,
            number: _remainingTime.inSeconds % 60,
            style: context.typography.xSmall.copyWith(
              color: _remainingTime.inMinutes < 1
                  ? Colors.red
                  : context.colorScheme.primary,
            ),
            formatter: (value) => value.toInt().toString().padLeft(2, '0'),
          ),
        ],
      ),
    );
  }
}
