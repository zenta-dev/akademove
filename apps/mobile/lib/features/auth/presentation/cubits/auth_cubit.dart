import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required DriverRepository driverRepository,
    required MerchantRepository merchantRepository,
  }) : _authRepository = authRepository,
       _driverRepository = driverRepository,
       _merchantRepository = merchantRepository,
       super(const AuthState());

  final AuthRepository _authRepository;
  final DriverRepository _driverRepository;
  final MerchantRepository _merchantRepository;

  void reset() => emit(const AuthState());

  Future<void> signIn(String email, String password) async =>
      await taskManager.execute('SC-sI1-$email', () async {
        emit(state.copyWith(user: const OperationResult.loading()));
        try {
          final res = await _authRepository.signIn(
            SignInRequest(email: email, password: password),
          );

          Driver? driver;
          Merchant? merchant;
          final role = res.data.role;
          if (role == UserRole.DRIVER) {
            driver = (await _driverRepository.getMine()).data;
          } else if (role == UserRole.MERCHANT) {
            merchant = (await _merchantRepository.getMine()).data;
          }

          emit(
            state.copyWith(
              user: OperationResult.success(res.data, message: res.message),
              driver: OperationResult.success(driver),
              merchant: OperationResult.success(merchant),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[AuthCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(user: OperationResult.failed(e)));
        }
      });

  Future<void> signUpUser({
    required String name,
    required String email,
    required Phone phone,
    required UserGender gender,
    required String password,
    required String confirmPassword,
    required String? photoPath,
  }) async => await taskManager.execute('SC-sU1-$email', () async {
    try {
      emit(state.copyWith(user: const OperationResult.loading()));
      final photo = photoPath != null
          ? await MultipartFile.fromFile(photoPath)
          : null;
      final res = await _authRepository.signUpUser(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        password: password,
        confirmPassword: confirmPassword,
        photo: photo,
      );
      emit(
        state.copyWith(
          user: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(user: OperationResult.failed(e)));
    }
  });

  Future<void> signUpDriver({
    required String name,
    required String email,
    required Phone phone,
    required UserGender gender,
    required String password,
    required String confirmPassword,
    required String photoPath,
    required int studentId,
    required String licensePlate,
    required String studentCardPath,
    required String driverLicensePath,
    required String vehicleCertificatePath,
    required BankProvider bankProvider,
    required int bankNumber,
  }) async => await taskManager.execute('SC-sD1-$email', () async {
    try {
      emit(state.copyWith(user: const OperationResult.loading()));
      final photo = await MultipartFile.fromFile(photoPath);
      final res = await _authRepository.signUpDriver(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        password: password,
        confirmPassword: confirmPassword,
        photo: photo,
        studentId: studentId,
        licensePlate: licensePlate,
        studentCard: await MultipartFile.fromFile(studentCardPath),
        driverLicense: await MultipartFile.fromFile(driverLicensePath),
        vehicleCertificate: await MultipartFile.fromFile(
          vehicleCertificatePath,
        ),
        bank: Bank(provider: bankProvider, number: bankNumber),
      );
      emit(
        state.copyWith(
          user: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(user: OperationResult.failed(e)));
    }
  });

  Future<void> signUpMerchant({
    required String ownerName,
    required String ownerEmail,
    required Phone ownerPhone,
    required String ownerPassword,
    required String ownerConfirmPassword,

    required String outletName,
    required String outletEmail,
    required Phone outletPhone,
    required Coordinate outletLocation,
    required String outletAddress,
    required MerchantCategory category,

    required BankProvider bankProvider,
    required int bankNumber,

    required String? photoPath,
    required String? documentPath,
  }) async => await taskManager.execute('SC-sM1-$ownerEmail', () async {
    try {
      emit(state.copyWith(user: const OperationResult.loading()));
      final photo = photoPath != null
          ? await MultipartFile.fromFile(photoPath)
          : null;

      final document = documentPath != null
          ? await MultipartFile.fromFile(documentPath)
          : null;

      final res = await _authRepository.signUpMerchant(
        ownerName: ownerName,
        ownerEmail: ownerEmail,
        ownerPhone: ownerPhone,
        ownerPassword: ownerPassword,
        ownerConfirmPassword: ownerConfirmPassword,
        outletName: outletName,
        outletEmail: outletEmail,
        outletPhone: outletPhone,
        outletLocation: outletLocation,
        outletAddress: outletAddress,
        category: category,
        bank: Bank(provider: bankProvider, number: bankNumber),
        photo: photo,
        document: document,
      );
      emit(
        state.copyWith(
          user: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(user: OperationResult.failed(e)));
    }
  });

  Future<void> authenticate() async => await taskManager.execute(
    'AC-a1',
    () async {
      emit(state.copyWith(user: const OperationResult.loading()));
      try {
        final res = await _authRepository.authenticate();

        Driver? driver;
        Merchant? merchant;

        final role = res.data.role;
        if (role == UserRole.DRIVER) {
          driver = (await _driverRepository.getMine()).data;
        } else if (role == UserRole.MERCHANT) {
          merchant = (await _merchantRepository.getMine()).data;
        }

        emit(
          state.copyWith(
            user: OperationResult.success(res.data, message: res.message),
            driver: OperationResult.success(driver),
            merchant: OperationResult.success(merchant),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
        emit(state.copyWith(user: OperationResult.failed(e)));
      }
    },
  );

  Future<void> signOut() async => await taskManager.execute('AC-sO1', () async {
    emit(state.copyWith(user: const OperationResult.loading()));
    try {
      await _authRepository.signOut();
      reset();
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(user: OperationResult.failed(e)));
    }
  });

  Future<void> forgotPassword(
    String email,
  ) async => taskManager.execute('AC-fP1', () async {
    emit(state.copyWith(forgotPasswordResult: const OperationResult.loading()));
    try {
      final res = await _authRepository.forgotPassword(email: email);
      emit(
        state.copyWith(
          forgotPasswordResult: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(forgotPasswordResult: OperationResult.failed(e)));
    }
  });

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async => await taskManager.execute('AC-rP1', () async {
    emit(state.copyWith(resetPasswordResult: const OperationResult.loading()));
    try {
      final res = await _authRepository.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(
        state.copyWith(
          resetPasswordResult: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(state.copyWith(resetPasswordResult: OperationResult.failed(e)));
    }
  });
}
