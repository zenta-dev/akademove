part of '_export.dart';

class EmergencyState extends Equatable {
  const EmergencyState({
    this.triggerEmergency = const OperationResult.idle(),
    this.emergencies = const OperationResult.idle(),
  });

  /// Result of triggering emergency
  final OperationResult<Emergency> triggerEmergency;

  /// List of emergencies for the current order
  final OperationResult<List<Emergency>> emergencies;

  @override
  List<Object> get props => [triggerEmergency, emergencies];

  EmergencyState copyWith({
    OperationResult<Emergency>? triggerEmergency,
    OperationResult<List<Emergency>>? emergencies,
  }) {
    return EmergencyState(
      triggerEmergency: triggerEmergency ?? this.triggerEmergency,
      emergencies: emergencies ?? this.emergencies,
    );
  }

  @override
  bool get stringify => true;
}
