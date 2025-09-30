import 'package:akademove/core/helpers.dart';
import 'package:akademove/core/state.dart';
import 'package:akademove/features/features.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  @override
  Future<void> init() async {
    emit(SplashState.loading());

    await delay(const Duration(seconds: 4));

    emit(SplashState.success());
  }
}
