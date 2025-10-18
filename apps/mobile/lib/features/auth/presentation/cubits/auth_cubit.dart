import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class AuthCubit extends BaseCubit<SplashState> {
  AuthCubit(this.authRepository) : super(SplashState.initial());
  final AuthRepository authRepository;

  @override
  Future<void> init() async {
    try {
      emit(SplashState.loading());
      final res = await authRepository.authenticate();
      emit(SplashState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SplashState.failure(e));
    }
  }

  Future<void> signOut() async {
    try {
      emit(SplashState.loading());
      final res = await authRepository.signOut();
      emit(SplashState.success(null, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SplashState.failure(e));
    }
  }

  @override
  void reset() => emit(SplashState.initial());
}
