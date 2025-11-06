import 'dart:async';
import 'dart:ui' as ui;

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTopUpQRISScreen extends StatefulWidget {
  const UserWalletTopUpQRISScreen({super.key});

  @override
  State<UserWalletTopUpQRISScreen> createState() =>
      _UserWalletTopUpQRISScreenState();
}

class _UserWalletTopUpQRISScreenState extends State<UserWalletTopUpQRISScreen> {
  Timer? _expirationTimer;
  Timer? _tickerTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startExpirationTimer();
    _startTickerTimer();
  }

  @override
  void dispose() {
    _expirationTimer?.cancel();
    _tickerTimer?.cancel();
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
    if (!context.mounted) return;
    final state = context.read<UserWalletTopUpCubit>().state;
    final expiresAt = state.paymentResult?.expiresAt;

    if (expiresAt != null) {
      final now = DateTime.now();
      if (now.isAfter(expiresAt)) {
        setState(() {
          _remainingTime = Duration.zero;
        });
      } else {
        setState(() {
          _remainingTime = expiresAt.difference(now);
        });
      }
    }
  }

  void _startExpirationTimer() {
    if (!mounted) return;
    if (!context.mounted) return;
    final state = context.read<UserWalletTopUpCubit>().state;
    final expiresAt = state.paymentResult?.expiresAt;

    if (expiresAt != null) {
      final now = DateTime.now();
      if (now.isAfter(expiresAt)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleExpiration();
        });
      } else {
        final duration = expiresAt.difference(now);
        _expirationTimer = Timer(duration, _handleExpiration);
      }
    }
  }

  void _cleanup() {
    if (!mounted) return;
    if (!context.mounted) return;
    _expirationTimer?.cancel();
    _tickerTimer?.cancel();
    _expirationTimer = null;
    _tickerTimer = null;
    _remainingTime = Duration.zero;
  }

  void _handleExpiration() {
    _cleanup();
    if (!mounted) return;
    if (!context.mounted) return;

    showToast(
      context: context,
      builder: (context, overlay) => context.buildToast(
        title: 'QR Code Expired',
        message: 'This QR code has expired. Please generate a new one.',
      ),
    );

    Navigator.of(context).pop();
  }

  Future<void> _downloadQR(
    BuildContext context,
    String url,
    String? transactionId,
  ) async {
    void showErrorToast(String message) => context.showMyToast(
      message,
      type: ToastType.error,
      trailing: IconButton(
        icon: const Icon(LucideIcons.refreshCcw),
        variance: const ButtonStyle.ghost(),
        onPressed: () => _downloadQR(context, url, transactionId),
      ),
    );

    try {
      final imageProvider = CachedNetworkImageProvider(url);
      final imageStream = imageProvider.resolve(ImageConfiguration.empty);
      final completer = Completer<ui.Image>();

      imageStream.addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(info.image);
        }),
      );

      final qrImage = await completer.future;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final qrSize = qrImage.width.toDouble();
      const titleHeight = 100.0;
      const padding = 20.0;
      const titleQrGap = 20.0;
      final totalWidth = qrSize + (padding * 2);
      final totalHeight = qrSize + titleHeight + (padding * 2) + titleQrGap;

      final backgroundPaint = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, totalWidth, totalHeight),
        backgroundPaint,
      );

      final textStyle = ui.TextStyle(
        color: Colors.black,
        fontSize: 42,
        fontWeight: FontWeight.bold,
      );
      final paragraphStyle = ui.ParagraphStyle(
        textAlign: TextAlign.center,
      );
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText('Akademove Pay');
      final paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: totalWidth));

      canvas
        ..drawParagraph(
          paragraph,
          const Offset(0, padding),
        )
        ..drawImage(
          qrImage,
          const Offset(
            padding,
            padding + titleHeight + titleQrGap,
          ),
          Paint(),
        );

      final picture = recorder.endRecording();
      final finalImage = await picture.toImage(
        totalWidth.toInt(),
        totalHeight.toInt(),
      );

      final byteData = await finalImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      await Gal.putImageBytes(
        pngBytes,
        name:
            'akademove_top-up_${transactionId ?? DateTime.now().millisecondsSinceEpoch}',
      );

      if (context.mounted) {
        context.showMyToast(
          'QR code saved successfully',
          type: ToastType.success,
        );
      }
    } catch (e) {
      if (e is GalException) {
        switch (e.type) {
          case GalExceptionType.accessDenied:
            showErrorToast(
              'Access denied. Please grant permission in settings.',
            );
          case GalExceptionType.notEnoughSpace:
            showErrorToast('Not enough storage space.');
          case GalExceptionType.notSupportedFormat:
            showErrorToast('Image format not supported.');
          case GalExceptionType.unexpected:
            showErrorToast('Unexpected error: $e');
        }
      } else {
        showErrorToast('Failed to save QR code: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: const [DefaultAppBar(title: 'Top Up QRIS')],
      body: Column(
        spacing: 16.h,
        children: [
          BlocConsumer<UserWalletTopUpCubit, UserWalletTopUpState>(
            listener: (context, state) async {
              if (state.isSuccess &&
                  state.transactionResult != null &&
                  state.transactionResult?.status ==
                      TransactionStatus.success) {
                if (mounted && context.mounted) {
                  context.showMyToast(
                    'Top up success',
                    type: ToastType.success,
                  );
                }
                await Future.delayed(const Duration(seconds: 3), () {
                  if (!mounted && !context.mounted) return;
                  context.read<UserWalletTopUpCubit>().teardownWebsocket();
                  _cleanup();
                  context
                    ..pop()
                    ..pop()
                    ..pop();
                });
              }
            },
            builder: (context, state) {
              final dateStr = (state.paymentResult?.expiresAt ?? DateTime.now())
                  .format('d MMMM yyyy, HH:mm');
              return Column(
                spacing: 8.h,
                children: [
                  DefaultText(
                    'Valid until $dateStr',
                  ).asSkeleton(enabled: state.isLoading),
                  Chip(
                    style: const ButtonStyle.outline(),
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
                          formatter: (value) =>
                              value.toInt().toString().padLeft(2, '0'),
                        ),
                        const DefaultText(':'),
                        NumberTicker(
                          initialNumber: 00,
                          number: _remainingTime.inSeconds % 60,
                          style: context.typography.xSmall.copyWith(
                            color: _remainingTime.inMinutes < 1
                                ? Colors.red
                                : context.colorScheme.primary,
                          ),
                          formatter: (value) =>
                              value.toInt().toString().padLeft(2, '0'),
                        ),
                      ],
                    ),
                  ).asSkeleton(enabled: state.isLoading),
                ],
              );
            },
          ),
          BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
            builder: (context, state) {
              final paymentUrl = state.paymentResult?.paymentUrl;
              return Container(
                decoration: BoxDecoration(
                  color: state.isLoading
                      ? context.colorScheme.mutedForeground
                      : Colors.white,
                ),
                child: paymentUrl != null
                    ? CachedNetworkImage(
                        imageUrl: paymentUrl,
                        width: 0.9.sw,
                        height: 0.9.sw,
                      )
                    : SizedBox(
                        width: 0.9.sw,
                        height: 0.9.sw,
                        child: const Center(child: Text('Loading')),
                      ),
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
            builder: (context, state) {
              final paymentUrl = state.paymentResult?.paymentUrl;
              return Button.primary(
                onPressed: paymentUrl == null
                    ? null
                    : () => _downloadQR(
                        context,
                        paymentUrl,
                        state.paymentResult?.transactionId,
                      ),
                child: const Text('Download'),
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultText('Total'),
                    BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
                      builder: (context, state) {
                        return DefaultText(
                          'Rp ${state.paymentResult?.amount ?? 50_000}',
                        ).asSkeleton(enabled: state.isLoading);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
