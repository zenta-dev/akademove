import 'package:akademove/app/_export.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial());

  Future<void> init() async {
    // should emit from local storage
    emit(
      AppState.success(
        const InternalAppState(themeMode: ThemeMode.dark, locale: Locale('en')),
      ),
    );
  }
}
