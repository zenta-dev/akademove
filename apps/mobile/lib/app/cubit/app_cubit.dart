import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit({required KeyValueService keyValueService})
    : _keyValueService = keyValueService,
      super(const AppState());

  final KeyValueService _keyValueService;

  Future<void> init() async {
    try {
      await Future.wait([loadThemeMode(), loadLocale(), loadTimeZone()]);
    } catch (e) {
      logger.e('Failed to initialize app', error: e);
    }
  }

  Future<void> loadTimeZone() async =>
      await taskManager.execute('AC-lTZ1', () async {
        try {
          final currentTimeZone = await FlutterTimezone.getLocalTimezone();
          emit(
            state.copyWith(timeZone: OperationResult.success(currentTimeZone)),
          );
        } catch (e, st) {
          logger.e('Failed to load time zone', error: e, stackTrace: st);
        }
      });

  Future<void> loadThemeMode() async => await taskManager.execute(
    'AC-lTM1',
    () async {
      try {
        final themeModeIndex =
            await _keyValueService.get<int>(KeyValueKeys.themeMode) ??
            ThemeMode.system.index;
        final themeMode = ThemeMode.values[themeModeIndex];
        emit(state.copyWith(themeMode: OperationResult.success(themeMode)));
      } catch (e, st) {
        logger.e('Failed to load theme mode', error: e, stackTrace: st);
        emit(
          state.copyWith(themeMode: OperationResult.success(ThemeMode.system)),
        );
      }
    },
  );

  Future<void> loadLocale() async =>
      await taskManager.execute('AC-lL1', () async {
        try {
          final localeTag = await _keyValueService.get<String>(
            KeyValueKeys.locale,
          );
          Locale? locale;
          if (localeTag != null) {
            final parts = localeTag.split('_');
            locale = Locale.fromSubtags(
              languageCode: parts[0],
              countryCode: parts.length > 1 ? parts[1] : null,
            );
          }
          emit(
            state.copyWith(
              locale: OperationResult.success(locale ?? const Locale('en')),
            ),
          );
          sl<AcceptLanguageInterceptor>().updateCached(
            locale?.toLanguageTag() ?? 'en',
          );
        } catch (e, st) {
          logger.e('Failed to load locale', error: e, stackTrace: st);
          emit(
            state.copyWith(locale: OperationResult.success(const Locale('en'))),
          );
        }
      });

  Future<void> updateThemeMode(ThemeMode themeMode) async =>
      await taskManager.execute('AC-uTM1', () async {
        try {
          await _keyValueService.set<int>(
            KeyValueKeys.themeMode,
            themeMode.index,
          );
          emit(state.copyWith(themeMode: OperationResult.success(themeMode)));
        } catch (e, st) {
          logger.e('Failed to update theme mode', error: e, stackTrace: st);
        }
      });

  Future<void> updateLocale(Locale locale) async =>
      await taskManager.execute('AC-uL1', () async {
        try {
          await _keyValueService.set<String>(
            KeyValueKeys.locale,
            locale.toLanguageTag(),
          );
          sl<AcceptLanguageInterceptor>().updateCached(locale.toLanguageTag());
          emit(state.copyWith(locale: OperationResult.success(locale)));
        } catch (e, st) {
          logger.e('Failed to update locale', error: e, stackTrace: st);
        }
      });
}
