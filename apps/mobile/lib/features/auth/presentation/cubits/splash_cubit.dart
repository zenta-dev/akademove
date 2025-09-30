import 'package:akademove/core/helpers.dart';
import 'package:akademove/features/features.dart';
import 'package:bloc/bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  Future<void> init() async {
    emit(SplashState.loading());

    await delay(const Duration(seconds: 4));

    emit(SplashState.success());
  }
}
