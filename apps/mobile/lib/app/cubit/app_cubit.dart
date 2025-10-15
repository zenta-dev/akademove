import 'package:akademove/app/_export.dart';
import 'package:akademove/core/state.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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

  @override
  void reset() => emit(AppState.initial());
}
