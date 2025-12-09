import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.user.isFailure) {
            context.goNamed(Routes.authSignIn.name);
          }
          if (state.user.isSuccess) {
            final user = state.user.value;

            // Check if email is verified first
            if (user != null && !user.emailVerified) {
              context.pushReplacementNamed(
                Routes.authEmailVerificationPending.name,
                queryParameters: {"email": user.email},
              );
              return;
            }

            switch (user?.role) {
              case UserRole.USER:
                context.pushReplacementNamed(Routes.userHome.name);
              case UserRole.MERCHANT:
                context.pushReplacementNamed(Routes.merchantHome.name);
              case UserRole.DRIVER:
                if (state.driver.value == null) {
                  context.pushReplacementNamed(Routes.authSignIn.name);
                  return;
                }
                if (state.driver.value?.quizStatus != DriverQuizStatus.PASSED) {
                  context.pushReplacementNamed(Routes.driverQuiz.name);
                  return;
                }
                if (state.driver.value?.status != DriverStatus.APPROVED) {
                  context.pushReplacementNamed(Routes.driverApproval.name);
                  return;
                }
                context.pushReplacementNamed(Routes.driverHome.name);
              case UserRole.ADMIN:
              case UserRole.OPERATOR:
              case null:
                context.showMyToast(
                  context.l10n.unsupported_role_desc,
                  type: ToastType.failed,
                );
                delay(const Duration(seconds: 2));
                context.pushReplacementNamed(Routes.authSignIn.name);
            }
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.brand.svg(width: 200.h, height: 200.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state.user.isLoading) {
                    return SizedBox(
                      width: context.mediaQuerySize.width / 4,
                      child: const LinearProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
