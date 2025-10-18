import 'package:akademove/app/router.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
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
      child: BlocListener<AuthCubit, SplashState>(
        listener: (context, state) {
          if (state.isFailure) {
            context.goNamed(Routes.authSignIn.name);
          }
          if (state.isSuccess) {
            switch (state.data?.role) {
              case UserRoleEnum.user:
                context.pushReplacementNamed(Routes.userHome.name);
              case UserRoleEnum.merchant:
                context.pushReplacementNamed(Routes.merchantHome.name);
              case UserRoleEnum.driver:
                context.pushReplacementNamed(Routes.driverHome.name);
              case UserRoleEnum.admin:
                // TODO: Handle this case.
                throw UnimplementedError();
              case UserRoleEnum.operator_:
                // TODO: Handle this case.
                throw UnimplementedError();
              case null:
                // TODO: Handle this case.
                throw UnimplementedError();
            }
          }
        },
        child: Center(
          child: Assets.images.brand.svg(width: 200.h, height: 200.h),
        ),
      ),
    );
  }
}
