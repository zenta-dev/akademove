part of 'router.dart';

final authRouter = ShellRoute(
  builder: (context, state, child) => child,
  routes: [
    GoRoute(
      name: Routes.authSplash.name,
      path: Routes.authSplash.path,
      builder: (context, state) => BlocProvider.value(
        value: sl<AuthCubit>()..init(),
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
);
