import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit(this.authRepository) : super(SplashState.initial());
  final AuthRepository authRepository;

  @override
  Future<void> init() async {
    emit(SplashState.loading());
    try {
      await authRepository.authenticate();
      emit(SplashState.success());
    } on BaseError catch (e) {
      emit(SplashState.failure(e));
    }
  }
}
