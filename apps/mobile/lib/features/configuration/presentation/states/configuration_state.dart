import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'configuration_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class ConfigurationState extends BaseState3<Configuration>
    with ConfigurationStateMappable {
  const ConfigurationState({
    super.state,
    super.message,
    super.error,
    super.list,
    super.selected,
  });

  ConfigurationState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  ConfigurationState toLoading() => copyWith(
    state: CubitState.loading,
    list: list,
    selected: selected,
    message: null,
    error: null,
  );

  ConfigurationState toSuccess({
    List<Configuration>? list,
    Configuration? selected,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    list: list ?? this.list,
    selected: selected ?? this.selected,
    message: message,
    error: null,
  );

  ConfigurationState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
}
