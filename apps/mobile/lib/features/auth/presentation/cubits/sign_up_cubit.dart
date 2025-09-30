import 'package:akademove/features/features.dart';
import 'package:bloc/bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  Future<void> init() async {
    emit(SignUpState.loading());

    await Future.delayed(const Duration(seconds: 1), () => {});
  }
}
