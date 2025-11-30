import 'package:akademove/core/_export.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_timezone/timezone_info.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'app_state.mapper.dart';

@MappableClass()
class AppState extends BaseState<InternalAppState> with AppStateMappable {
  const AppState({super.data, super.error, super.state});

  factory AppState.initial() => const AppState();
  factory AppState.loading() => const AppState(state: CubitState.loading);
  factory AppState.success(InternalAppState state) =>
      AppState(data: state, state: CubitState.success);
  factory AppState.failure(BaseError error) =>
      AppState(error: error, state: CubitState.failure);
}

class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(dynamic value) {
    if (value is int) {
      if (value >= 0 && value < ThemeMode.values.length) {
        return ThemeMode.values[value];
      }
    } else if (value is String) {
      final v = value.toLowerCase();
      if (v == 'light') return ThemeMode.light;
      if (v == 'dark') return ThemeMode.dark;
      if (v == 'system') return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  @override
  dynamic encode(ThemeMode self) => self.index;
}

class LocaleMapper extends SimpleMapper<Locale> {
  const LocaleMapper();

  @override
  Locale decode(dynamic value) {
    if (value is String) {
      final sep = value.contains('_')
          ? '_'
          : (value.contains('-') ? '-' : null);
      if (sep == null) return Locale(value);
      final parts = value.split(sep);
      return Locale(
        parts[0],
        parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null,
      );
    } else if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      final lang = map['languageCode'] as String? ?? 'en';
      final country = map['countryCode'] as String?;
      return Locale(lang, country);
    }
    return const Locale('en');
  }

  @override
  dynamic encode(Locale self) {
    return {'languageCode': self.languageCode, 'countryCode': self.countryCode};
  }
}

@MappableClass(includeCustomMappers: [ThemeModeMapper(), LocaleMapper()])
class InternalAppState with InternalAppStateMappable {
  const InternalAppState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.timeZone,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final TimezoneInfo? timeZone;
}
