import 'package:akademove/features/features.dart';
import 'package:bloc/bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.initial());

  Future<void> init() async {
    emit(SignInState.loading());

    await Future.delayed(const Duration(seconds: 1), () => {});
  }
}
