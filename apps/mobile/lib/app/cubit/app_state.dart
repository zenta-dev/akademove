// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademove/core/_export.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timezone/timezone_info.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode = const OperationResult.idle(),
    this.locale = const OperationResult.idle(),
    this.timeZone = const OperationResult.idle(),
  });

  final OperationResult<ThemeMode> themeMode;
  final OperationResult<Locale> locale;
  final OperationResult<TimezoneInfo> timeZone;

  @override
  List<Object> get props => [themeMode, locale, timeZone];

  @override
  bool get stringify => true;

  AppState copyWith({
    OperationResult<ThemeMode>? themeMode,
    OperationResult<Locale>? locale,
    OperationResult<TimezoneInfo>? timeZone,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      timeZone: timeZone ?? this.timeZone,
    );
  }
}
