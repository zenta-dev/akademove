import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  authSplash('/auth'),
  authSignIn('/auth/sign-in'),
  authSignUpChoice('/auth/sign-up'),
  authSignUpUser('/auth/sign-up/user'),
  authSignUpDriver('/auth/sign-up/driver'),
  authSignUpMerchant('/auth/sign-up/merchant'),
  authForgotPassword('/auth/forgot-password'),

  ///
  /// User Routes
  ///
  userHome('/user/home'),

  ///
  /// Driver Routes
  ///
  driverHome('/driver/home')
  ///
  /// Merchant Routes
  ///
  ,
  merchantHome('/merchant/home');

  const Routes(this.path);
  final String path;

  String get fullName => 'auth_$name';
}

final router = GoRouter(
  initialLocation: Routes.authSplash.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: Routes.authSplash.name,
          path: Routes.authSplash.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SplashCubit>()..init(),
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignIn.name,
          path: Routes.authSignIn.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignInCubit>()..init(),
            child: const SignInScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpChoice.name,
          path: Routes.authSignUpChoice.path,
          builder: (context, state) => const SignUpChoiceScreen(),
        ),
        GoRoute(
          name: Routes.authSignUpUser.name,
          path: Routes.authSignUpUser.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpUserScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpDriver.name,
          path: Routes.authSignUpDriver.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpDriverScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpMerchant.name,
          path: Routes.authSignUpMerchant.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpMerchantScreen(),
          ),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: Routes.userHome.name,
          path: Routes.userHome.path,
          builder: (context, state) => const UserHomeScreen(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: Routes.driverHome.name,
          path: Routes.driverHome.path,
          builder: (context, state) => const DriverHomeScreen(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: Routes.merchantHome.name,
          path: Routes.merchantHome.path,
          builder: (context, state) => const MerchantHomeScreen(),
        ),
      ],
    ),
  ],
);
