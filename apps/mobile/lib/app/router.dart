import 'package:akademove/features/features.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  authSplash('/auth'),
  authSignIn('/auth/sign-in'),
  authSignUpUser('/auth/sign-up/user'),
  authSignUpDriver('/auth/sign-up/driver'),
  authSignUpMerchant('/auth/sign-up/merchant');

  const Routes(this.path);
  final String path;
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
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: Routes.authSignIn.name,
          path: Routes.authSignIn.path,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          name: Routes.authSignUpDriver.name,
          path: Routes.authSignUpDriver.path,
          builder: (context, state) => const SignUpUserScreen(),
        ),
        GoRoute(
          name: Routes.authSignUpMerchant.name,
          path: Routes.authSignUpMerchant.path,
          builder: (context, state) => const SignUpMerchantScreen(),
        ),
        GoRoute(
          name: Routes.authSignUpUser.name,
          path: Routes.authSignUpUser.path,
          builder: (context, state) => const SignUpUserScreen(),
        ),
      ],
    ),
  ],
);
