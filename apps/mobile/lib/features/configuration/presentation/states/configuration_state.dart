import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class ConfigurationState extends Equatable {
  const ConfigurationState({
    this.configurations = const OperationResult.idle(),
    this.selectedConfiguration = const OperationResult.idle(),
  });

  final OperationResult<List<Configuration>> configurations;
  final OperationResult<Configuration> selectedConfiguration;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [configurations, selectedConfiguration];

  ConfigurationState copyWith({
    OperationResult<List<Configuration>>? configurations,
    OperationResult<Configuration>? selectedConfiguration,
  }) {
    return ConfigurationState(
      configurations: configurations ?? this.configurations,
      selectedConfiguration:
          selectedConfiguration ?? this.selectedConfiguration,
    );
  }
}
