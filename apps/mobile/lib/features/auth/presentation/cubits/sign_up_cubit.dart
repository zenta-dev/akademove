import 'package:akademove/core/state.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());
  @override
  Future<void> init() async {}

  @override
  void reset() => emit(SignUpState.initial());

  }
}
