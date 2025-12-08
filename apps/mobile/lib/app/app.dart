import 'package:akademove/app/_export.dart';
import 'package:akademove/app/theme.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AppCubit>()..init()),
        BlocProvider(create: (_) => sl<AuthCubit>()..authenticate()),
        BlocProvider(create: (_) => sl<ConfigurationCubit>()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            final identifier = state.timeZone.data?.value.identifier;

            if (identifier != null) {
              try {
                final location = tz.getLocation(identifier);
                tz.setLocalLocation(location);
              } catch (_) {
                tz.setLocalLocation(tz.getLocation('UTC'));
              }
            } else {
              tz.setLocalLocation(tz.getLocation('UTC'));
            }
          },
          builder: (context, state) => ShadcnApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            locale: state.locale.data?.value,
            themeMode: state.themeMode.data?.value ?? ThemeMode.system,
          ),
        ),
      ),
    );
  }
}
