import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletMyQrScreen extends StatelessWidget {
  const UserWalletMyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.my_qr_code)],
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = state.user.value;

          if (user == null) {
            return Center(
              child: Text(
                context.l10n.error_occurred,
                style: context.typography.small,
              ),
            );
          }

          // Generate QR code data in JSON format
          final qrData = jsonEncode({
            'userId': user.id,
            'name': user.name,
            'image': user.image,
          });

          return Column(
            children: [
              SizedBox(height: 32.h),
              // User info
              UserAvatarWidget(name: user.name, image: user.image, size: 80.w),
              SizedBox(height: 12.h),
              Text(
                user.name,
                style: context.typography.h4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 32.h),
              // QR Code card
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 220.w,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.black,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.scan_to_send_money,
                      style: context.typography.small.copyWith(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.mutedForeground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Instructions
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 20.w,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        context.l10n.share_qr_instruction,
                        style: context.typography.small.copyWith(
                          fontSize: 13.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
