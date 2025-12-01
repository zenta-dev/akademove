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
    this.ongoingOperations = const {},
  });

  final Driver? myDriver;
  final bool isLoading;
  final BaseError? error;
  final String? message;
  final Set<String> ongoingOperations;

  bool get isSuccess => error == null && !isLoading;
  bool get isFailure => error != null;

  bool checkAndAssignOperation(String operationName) {
    if (ongoingOperations.contains(operationName)) return true;
    return false;
  }

  void unAssignOperation(String operationName) {
    ongoingOperations.remove(operationName);
  }

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
