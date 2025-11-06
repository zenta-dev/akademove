import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/presentation/_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SignOutButtonWidget extends StatelessWidget {
  const SignOutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button.destructive(
        onPressed: () {
          context.read<AuthCubit>().signOut();
          context.goNamed(Routes.authSignIn.name);
        },
        child: Text(
          'Sign Out',
          style: context.typography.small.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
