import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class SharedConfigurationState extends Equatable {
  const SharedConfigurationState({
    this.configurations = const OperationResult.idle(),
    this.selectedConfiguration = const OperationResult.idle(),
    this.banners = const OperationResult.idle(),
    this.businessConfiguration = const OperationResult.idle(),
  });

  final OperationResult<List<Configuration>> configurations;
  final OperationResult<Configuration> selectedConfiguration;
  final OperationResult<List<BannerListPublic200ResponseDataInner>> banners;
  final OperationResult<BusinessConfiguration> businessConfiguration;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    configurations,
    selectedConfiguration,
    banners,
    businessConfiguration,
  ];

  SharedConfigurationState copyWith({
    OperationResult<List<Configuration>>? configurations,
    OperationResult<Configuration>? selectedConfiguration,
    OperationResult<List<BannerListPublic200ResponseDataInner>>? banners,
    OperationResult<BusinessConfiguration>? businessConfiguration,
  }) {
    return SharedConfigurationState(
      configurations: configurations ?? this.configurations,
      selectedConfiguration:
          selectedConfiguration ?? this.selectedConfiguration,
      banners: banners ?? this.banners,
      businessConfiguration:
          businessConfiguration ?? this.businessConfiguration,
    );
  }
}
