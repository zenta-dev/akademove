import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/presentation/_export.dart';
import 'package:akademove/l10n/l10n.dart';
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
      child: Button(
        style:
            ButtonStyle.destructive(
              density: ButtonDensity(
                (val) => EdgeInsets.symmetric(horizontal: 12.dg, vertical: 6.h),
              ),
            ).copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
            ),
        onPressed: () async {
          await context.read<AuthCubit>().signOut();
          if (context.mounted) context.goNamed(Routes.authSignIn.name);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.w,
          children: [
            DefaultText(
              context.l10n.sign_out,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
            Icon(LucideIcons.logOut, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
