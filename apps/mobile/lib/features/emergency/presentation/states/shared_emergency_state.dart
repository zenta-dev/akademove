part of '_export.dart';

class SharedEmergencyState extends Equatable {
  const SharedEmergencyState({
    this.triggerEmergency = const OperationResult.idle(),
    this.selectedEmergency = const OperationResult.idle(),
    this.emergencies = const OperationResult.idle(),
    this.primaryContact = const OperationResult.idle(),
    this.logEmergency = const OperationResult.idle(),
  });

  /// Result of triggering emergency
  final OperationResult<EmergencyWithContact> triggerEmergency;

  /// Result of getting a single emergency
  final OperationResult<Emergency> selectedEmergency;

  /// List of emergencies for the current order
  final OperationResult<List<Emergency>> emergencies;

  /// Primary emergency contact for WhatsApp redirect
  final OperationResult<EmergencyContact?> primaryContact;

  /// Result of logging emergency event
  final OperationResult<bool> logEmergency;

  @override
  List<Object> get props => [
    triggerEmergency,
    selectedEmergency,
    emergencies,
    primaryContact,
    logEmergency,
  ];

  SharedEmergencyState copyWith({
    OperationResult<EmergencyWithContact>? triggerEmergency,
    OperationResult<Emergency>? selectedEmergency,
    OperationResult<List<Emergency>>? emergencies,
    OperationResult<EmergencyContact?>? primaryContact,
    OperationResult<bool>? logEmergency,
  }) {
    return SharedEmergencyState(
      triggerEmergency: triggerEmergency ?? this.triggerEmergency,
      selectedEmergency: selectedEmergency ?? this.selectedEmergency,
      emergencies: emergencies ?? this.emergencies,
      primaryContact: primaryContact ?? this.primaryContact,
      logEmergency: logEmergency ?? this.logEmergency,
    );
  }

  @override
  bool get stringify => true;
}
