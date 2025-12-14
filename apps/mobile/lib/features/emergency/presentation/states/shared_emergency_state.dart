part of '_export.dart';

class SharedEmergencyState extends Equatable {
  const SharedEmergencyState({
    this.triggerEmergency = const OperationResult.idle(),
    this.selectedEmergency = const OperationResult.idle(),
    this.emergencies = const OperationResult.idle(),
  });

  /// Result of triggering emergency
  final OperationResult<EmergencyWithContact> triggerEmergency;

  /// Result of getting a single emergency
  final OperationResult<Emergency> selectedEmergency;

  /// List of emergencies for the current order
  final OperationResult<List<Emergency>> emergencies;

  @override
  List<Object> get props => [triggerEmergency, selectedEmergency, emergencies];

  SharedEmergencyState copyWith({
    OperationResult<EmergencyWithContact>? triggerEmergency,
    OperationResult<Emergency>? selectedEmergency,
    OperationResult<List<Emergency>>? emergencies,
  }) {
    return SharedEmergencyState(
      triggerEmergency: triggerEmergency ?? this.triggerEmergency,
      selectedEmergency: selectedEmergency ?? this.selectedEmergency,
      emergencies: emergencies ?? this.emergencies,
    );
  }

  @override
  bool get stringify => true;
}
