import 'package:akademove/app/router/router.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter/material.dart' show InkWell;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class _SignUpRoutes {
  const _SignUpRoutes({
    required this.name,
    required this.icon,
    required this.route,
    required this.description,
  });

  final String name;
  final SvgGenImage icon;
  final Routes route;
  final String description;
}

class SignUpChoiceScreen extends StatelessWidget {
  const SignUpChoiceScreen({super.key});

  List<_SignUpRoutes> _getRoutes(BuildContext context) => [
    _SignUpRoutes(
      name: context.l10n.user_role,
      icon: Assets.images.character.user,
      route: Routes.authSignUpUser,
      description: context.l10n.description_user_role,
    ),
    _SignUpRoutes(
      name: context.l10n.driver_role,
      icon: Assets.images.character.driver,
      route: Routes.authSignUpDriver,
      description: context.l10n.description_driver_role,
    ),
    _SignUpRoutes(
      name: context.l10n.merchant_role,
      icon: Assets.images.character.merchant,
      route: Routes.authSignUpMerchant,
      description: context.l10n.description_merchant_role,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final routes = _getRoutes(context);
    return Scaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.brand.svg(height: 80.h),
              Text(
                context.l10n.sign_up_choice,
                style: context.theme.typography.h3.copyWith(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: routes.length,
                separatorBuilder: (_, _) => Gap(12.h),
                itemBuilder: (context, index) {
                  final route = routes[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => context.pushNamed(route.route.name),
                    child: Card(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          route.icon.svg(height: 64),
                          const SizedBox(height: 12),
                          Text(
                            route.name,
                            style: context.theme.typography.h4.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            route.description,
                            style: context.theme.typography.textMuted.copyWith(
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          ).muted,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
