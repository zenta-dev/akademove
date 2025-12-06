import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserProfileCubit extends BaseCubit<UserProfileState> {
  UserProfileCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(UserProfileState());

  final UserRepository _userRepository;

  void reset() => emit(UserProfileState());

  Future<void> updateProfile(UpdateProfileRequest req) async =>
      await taskManager.execute('UPC-uP', () async {
        try {
          emit(state.toLoading());
          final res = await _userRepository.updateProfile(req);
          emit(
            state.toSuccess(
              updateProfileResult: res.data,
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserProfileCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> updatePassword(UserMeChangePasswordRequest req) async =>
      await taskManager.execute('UPC-uPW', () async {
        try {
          emit(state.toLoading());
          final res = await _userRepository.updatePassword(req);
          emit(
            state.toSuccess(
              updatePasswordResult: res.data,
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserProfileCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );

          emit(state.toFailure(e));
        }
      });
}
