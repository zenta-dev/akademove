import 'package:akademove/app/router/router.dart';
import 'package:akademove/app/widgets/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      safeArea: true,
      body: Column(
        spacing: 16.h,
        crossAxisAlignment: .start,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return UserProfileCardWidget(
                user: state.data ?? dummyUser,
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          DefaultText(
            context.l10n.account_settings,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          Button(
            style:
                ButtonStyle.card(
                  density: ButtonDensity(
                    (val) =>
                        EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                  ),
                ).copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
            onPressed: () async {
              await context.pushNamed(Routes.userEditProfile.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(context.l10n.edit_profile, fontSize: 14.sp),
                Icon(LucideIcons.pencil, size: 14.sp),
              ],
            ),
          ),
          Button(
            style:
                ButtonStyle.card(
                  density: ButtonDensity(
                    (val) =>
                        EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                  ),
                ).copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
            onPressed: () async {
              await context.pushNamed(Routes.userChangePassword.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(context.l10n.change_password, fontSize: 14.sp),
                Icon(LucideIcons.pencil, size: 14.sp),
              ],
            ),
          ),
          Button(
            style:
                ButtonStyle.card(
                  density: ButtonDensity(
                    (val) =>
                        EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                  ),
                ).copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
            onPressed: () async {
              await context.pushNamed(Routes.termsOfService.name);
            },
            child: Row(
              children: [
                DefaultText(context.l10n.terms_of_service, fontSize: 14.sp),
              ],
            ),
          ),
          Button(
            style:
                ButtonStyle.card(
                  density: ButtonDensity(
                    (val) =>
                        EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                  ),
                ).copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
            onPressed: () async {
              await context.pushNamed(Routes.privacyPolicies.name);
            },
            child: Row(
              children: [
                DefaultText(context.l10n.privacy_policy, fontSize: 14.sp),
              ],
            ),
          ),
          Button(
            style:
                ButtonStyle.card(
                  density: ButtonDensity(
                    (val) =>
                        EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
                  ),
                ).copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
            onPressed: () async {
              await context.pushNamed(Routes.faq.name);
            },
            child: Row(
              children: [DefaultText(context.l10n.faq, fontSize: 14.sp)],
            ),
          ),
          const DeleteAccountButtonWidget(accountType: 'USER'),
          const SignOutButtonWidget(),
          DefaultText(
            context.l10n.app_settings,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          Column(
            spacing: 8.h,
            children: [
              Column(
                spacing: 4.h,
                crossAxisAlignment: .start,
                children: [
                  DefaultText(context.l10n.language, fontSize: 14.sp),
                  const AppSelectLocaleWidget(),
                ],
              ),
              Column(
                spacing: 4.h,
                crossAxisAlignment: .start,
                children: [
                  DefaultText(context.l10n.theme, fontSize: 14.sp),
                  const AppSelectThemeWidget(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
