import "dart:async";

import "package:akademove/core/_export.dart";
import "package:akademove/firebase_options.dart";
import "package:akademove/locator.dart";
import "package:bloc/bloc.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/services.dart"
    show DeviceOrientation, SystemChannels, SystemChrome;
import "package:flutter/widgets.dart";
import "package:timezone/data/latest.dart" as tz;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logger.d('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌀 BLOC CHANGE
\tBloc: ${bloc.runtimeType}

\tCurrent → Next:
\t${change.currentState} → ${change.nextState}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔥 BLOC ERROR
\tBloc: ${bloc.runtimeType}

\tError: $error

\tStack Trace:
\t$stackTrace
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

    // Report bloc errors to Crashlytics
    GlobalErrorHandler.instance.reportError(error, stackTrace: stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Use runZonedGuarded to catch all uncaught async errors
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Bloc.observer = const AppBlocObserver();

      setupLocator();

      await Future.wait([
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
        SystemChannels.textInput.invokeMethod("TextInput.hide"),
      ]);
      tz.initializeTimeZones();

      // Initialize Firebase first (required before Crashlytics)
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Initialize global error handler AFTER Firebase
      // Sets FlutterError.onError, PlatformDispatcher.onError, and Crashlytics
      await GlobalErrorHandler.instance.initialize();

      runApp(await builder());
    },
    // Handle uncaught async errors
    GlobalErrorHandler.instance.handleZoneError,
  );
}
