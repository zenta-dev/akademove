import 'package:akademove/core/state.dart';
import 'package:akademove/features/features.dart';

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit() : super(SignInState.initial());

  @override
  Future<void> init() async {
    emit(SignInState.loading());

    await Future.delayed(const Duration(seconds: 1), () => {});
  }
}
