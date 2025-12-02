import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'driver_profile_state.mapper.dart';

@MappableClass()
class DriverProfileState with DriverProfileStateMappable {
  const DriverProfileState({
    this.myDriver,
    this.isLoading = false,
    this.error,
    this.message,
  });

  final Driver? myDriver;
  final bool isLoading;
  final BaseError? error;
  final String? message;

  bool get isSuccess => error == null && !isLoading;
  bool get isFailure => error != null;

  DriverProfileState toLoading() {
    return copyWith(isLoading: true, error: null, message: null);
  }

  DriverProfileState toSuccess({Driver? myDriver, String? message}) {
    return copyWith(
      myDriver: myDriver ?? this.myDriver,
      isLoading: false,
      error: null,
      message: message,
    );
  }

  DriverProfileState toFailure(BaseError error) {
    return copyWith(isLoading: false, error: error);
  }
}
