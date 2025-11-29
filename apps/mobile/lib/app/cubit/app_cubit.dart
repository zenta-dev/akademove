import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit({
    required KeyValueService keyValueService,
  }) : _keyValueService = keyValueService,
       super(AppState.initial());

  final KeyValueService _keyValueService;

  Future<void> init() async {
    try {
      final currentTimeZone = await FlutterTimezone.getLocalTimezone();

      final themeModeIndex =
          await _keyValueService.get<int>(KeyValueKeys.themeMode) ??
          ThemeMode.system.index;
      final themeMode = ThemeMode.values[themeModeIndex];

      final localeTag = await _keyValueService.get<String>(KeyValueKeys.locale);
      Locale? locale;
      if (localeTag != null) {
        final parts = localeTag.split('_');
        locale = Locale.fromSubtags(
          languageCode: parts[0],
          countryCode: parts.length > 1 ? parts[1] : null,
        );
      }

      emit(
        AppState.success(
          InternalAppState(
            themeMode: themeMode,
            locale: locale ?? const Locale('en'),
            timeZone: currentTimeZone,
          ),
        ),
      );
    } catch (e, st) {
      logger.e('Failed to initialize app', error: e, stackTrace: st);
      emit(
        AppState.failure(
          e is BaseError ? e : UnknownError(e.toString()),
        ),
      );
    }
  }

  void reset() => emit(AppState.initial());

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    try {
      await _keyValueService.set<int>(
        KeyValueKeys.themeMode,
        themeMode.index,
      );
      final currentData = state.data;
      final newState = currentData != null
          ? currentData.copyWith(themeMode: themeMode)
          : InternalAppState(themeMode: themeMode);
      emit(AppState.success(newState));
    } on BaseError catch (e, st) {
      logger.e('Failed to update theme mode', error: e, stackTrace: st);
      emit(AppState.failure(e));
    } catch (e, st) {
      logger.e('Failed to update theme mode', error: e, stackTrace: st);
      emit(AppState.failure(UnknownError(e.toString())));
    }
  }

  Future<void> updateLocale(Locale locale) async {
    try {
      await _keyValueService.set<String>(
        KeyValueKeys.locale,
        locale.toLanguageTag(),
      );
      final currentData = state.data;
      final newState = currentData != null
          ? currentData.copyWith(locale: locale)
          : InternalAppState(locale: locale);
      emit(AppState.success(newState));
    } on BaseError catch (e, st) {
      logger.e('Failed to update locale', error: e, stackTrace: st);
      emit(AppState.failure(e));
    } catch (e, st) {
      logger.e('Failed to update locale', error: e, stackTrace: st);
      emit(AppState.failure(UnknownError(e.toString())));
    }
  }
}
