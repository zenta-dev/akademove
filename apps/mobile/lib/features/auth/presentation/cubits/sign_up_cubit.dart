import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository,
       super(SignUpState.initial());

  final AuthRepository _authRepository;

  @override
  Future<void> init() async {}

  @override
  void reset() => emit(SignUpState.initial());

  Future<void> signUpUser({
    required String name,
    required String email,
    required Phone phone,
    required UserGender gender,
    required String password,
    required String confirmPassword,
    required String? photoPath,
  }) async {
    try {
      emit(SignUpState.loading());
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
      emit(SignUpState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[SignUpCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SignUpState.failure(e));
    }
  }

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
    required BankProviderEnum bankProvider,
    required int bankNumber,
  }) async {
    try {
      emit(SignUpState.loading());
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
        bankProvider: bankProvider,
        bankNumber: bankNumber,
      );
      emit(SignUpState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[SignUpCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SignUpState.failure(e));
    }
  }

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

    required BankProviderEnum bankProvider,
    required int bankNumber,

    required String? photoPath,
    required String? documentPath,
  }) async {
    try {
      emit(SignUpState.loading());
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
        bankProvider: bankProvider,
        bankNumber: bankNumber,
        photo: photo,
        document: document,
      );
      emit(SignUpState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[SignUpCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SignUpState.failure(e));
    }
  }
}
