import 'package:akademove/core/state.dart';
import 'package:akademove/features/features.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  @override
  Future<void> init() async {
    emit(SignUpState.loading());

    await Future.delayed(const Duration(seconds: 1), () => {});
  }
}
