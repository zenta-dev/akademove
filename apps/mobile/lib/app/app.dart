import 'package:akademove/app/_export.dart';
import 'package:akademove/app/router.dart';
import 'package:akademove/app/theme.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AppCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            locale: state.data?.locale,
            themeMode: state.data?.themeMode,
          );
        },
      ),
    );
  }
}
