import 'package:akademove/app/router.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.goNamed(Routes.authSignIn.name);
          }
        },
        child: Center(
          child: Assets.images.brand.svg(width: 200.h, height: 200.h),
        ),
      ),
    );
  }
}
