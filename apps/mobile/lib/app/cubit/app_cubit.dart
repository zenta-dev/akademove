import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit() : super(AppState.initial());

  @override
  Future<void> init() async {
    // should emit from local storage
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();

    emit(
      AppState.success(
        InternalAppState(themeMode: ThemeMode.dark, timeZone: currentTimeZone),
      ),
    );
  }

  @override
  void reset() => emit(AppState.initial());
}
