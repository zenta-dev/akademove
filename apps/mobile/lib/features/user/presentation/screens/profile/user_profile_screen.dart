import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      safeArea: true,
      body: Column(
        spacing: 16.h,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return UserProfileCardWidget(
                user: state.data ?? dummyUser,
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          Button(
            style: ButtonStyle.card(
              density: ButtonDensity(
                (val) => EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Profile',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  LucideIcons.pencil,
                  size: 14.sp,
                ),
              ],
            ),
          ),
          const SignOutButtonWidget(),
        ],
      ),
    );
  }
}
