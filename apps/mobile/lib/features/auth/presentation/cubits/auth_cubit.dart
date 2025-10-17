import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class AuthCubit extends BaseCubit<SplashState> {
  AuthCubit(this.authRepository) : super(SplashState.initial());
  final AuthRepository authRepository;

  @override
  Future<void> init() async {
    emit(SplashState.loading());
    try {
      final res = await authRepository.authenticate();
      emit(SplashState.success(res.data, message: res.message));
    } on BaseError catch (e) {
      emit(SplashState.failure(e));
    }
  }

  @override
  void reset() => emit(SplashState.initial());
}
