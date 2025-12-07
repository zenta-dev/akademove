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
        create: (_) => sl<SignInCubit>()..reset(),
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
        create: (_) => sl<SignUpCubit>()..reset(),
        child: const SignUpUserScreen(),
      ),
    ),
    GoRoute(
      name: Routes.authSignUpDriver.name,
      path: Routes.authSignUpDriver.path,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<SignUpCubit>()..reset(),
        child: const SignUpDriverScreen(),
      ),
    ),
    GoRoute(
      name: Routes.authSignUpMerchant.name,
      path: Routes.authSignUpMerchant.path,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<SignUpCubit>()..reset(),
        child: const SignUpMerchantScreen(),
      ),
    ),
    GoRoute(
      name: Routes.authForgotPassword.name,
      path: Routes.authForgotPassword.path,
      builder: (context, state) => BlocProvider.value(
        value: sl<AuthCubit>()..reset(),
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      name: Routes.authResetPassword.name,
      path: Routes.authResetPassword.path,
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        return BlocProvider.value(
          value: sl<AuthCubit>()..reset(),
          child: ResetPasswordScreen(token: token),
        );
      },
    ),
    GoRoute(
      name: Routes.authEmailVerificationPending.name,
      path: Routes.authEmailVerificationPending.path,
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return BlocProvider(
          create: (_) => sl<EmailVerificationCubit>(),
          child: EmailVerificationPendingScreen(email: email),
        );
      },
    ),
    GoRoute(
      name: Routes.authVerifyEmail.name,
      path: Routes.authVerifyEmail.path,
      builder: (context, state) {
        final token = state.uri.queryParameters['token'];
        return BlocProvider(
          create: (_) => sl<EmailVerificationCubit>(),
          child: EmailVerificationScreen(token: token),
        );
      },
    ),
    GoRoute(
      name: Routes.driverQuiz.name,
      path: Routes.driverQuiz.path,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<DriverQuizCubit>(),
        child: const DriverQuizScreen(),
      ),
    ),
  ],
);
