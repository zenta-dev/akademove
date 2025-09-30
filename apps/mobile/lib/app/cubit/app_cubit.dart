import 'package:akademove/app/_export.dart';
import 'package:akademove/core/state.dart';
import 'package:flutter/material.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit() : super(AppState.initial());

  @override
  Future<void> init() async {
    // should emit from local storage
    emit(
      AppState.success(
        const InternalAppState(themeMode: ThemeMode.dark),
      ),
    );
  }
}
