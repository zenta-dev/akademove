import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantProfileScreen extends StatelessWidget {
  const MerchantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      safeArea: true,
      body: Column(
        spacing: 16.h,
        children: [
          BlocBuilder<MerchantCubit, MerchantState>(
            builder: (context, state) {
              final merchant = state.mine.value;
              return Card(
                child: Column(
                  spacing: 12.h,
                  children: [
                    Row(
                      spacing: 24.w,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/images/fore_logo.png',
                            width: 100.w,
                            height: 100.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          context.l10n.hello(merchant?.name ?? "Merchant"),
                          style: context.typography.small.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (merchant != null) ...[
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: merchant.userId),
                          );
                          context.showMyToast(
                            context.l10n.copied_to_clipboard,
                            type: ToastType.success,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8.w,
                          children: [
                            Icon(
                              LucideIcons.fingerprint,
                              size: 16.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                            Text(
                              context.l10n.label_user_id,
                              style: context.typography.small.copyWith(
                                fontSize: 12.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                            Text(
                              merchant.userId.length > 8
                                  ? '${merchant.userId.substring(0, 8)}...'
                                  : merchant.userId,
                              style: context.typography.p.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              LucideIcons.copy,
                              size: 14.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          Button.card(
            onPressed: () => context.pushNamed(Routes.merchantSetUpOutlet.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.title_set_up_outlet,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(LucideIcons.pencil, size: 14),
              ],
            ),
          ),
          Button.card(
            onPressed: () => context.pushNamed(Routes.merchantEditProfile.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.edit_profile,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(LucideIcons.pencil, size: 14),
              ],
            ),
          ),
          Button.card(
            onPressed: () =>
                context.pushNamed(Routes.merchantChangePassword.name),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.change_password,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(LucideIcons.pencil, size: 14),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Button.card(
              onPressed: () => context.pushNamed(Routes.privacyPolicies.name),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.privacy_policy,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // const DeleteAccountButtonWidget(accountType: 'MERCHANT'),
          const SignOutButtonWidget(),
        ],
      ),
    );
  }
}
