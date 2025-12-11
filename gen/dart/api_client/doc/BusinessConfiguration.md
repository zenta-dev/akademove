# api_client.model.BusinessConfiguration

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**minTransferAmount** | **num** |  | 
**minWithdrawalAmount** | **num** |  | 
**minTopUpAmount** | **num** |  | 
**quickTopUpAmounts** | **List&lt;num&gt;** |  | 
**userCancellationFeeBeforeAccept** | **num** |  | 
**userCancellationFeeAfterAccept** | **num** |  | 
**noShowFee** | **num** |  | 
**noShowDriverCompensationRate** | **num** |  | 
**highValueOrderThreshold** | **num** |  | 
**driverMatchingTimeoutMinutes** | **num** |  | [optional] [default to 15]
**driverMatchingInitialRadiusKm** | **num** |  | [optional] [default to 5]
**driverMatchingMaxRadiusKm** | **num** |  | [optional] [default to 20]
**driverMatchingRadiusExpansionRate** | **num** |  | [optional] [default to 0.2]
**driverMatchingIntervalSeconds** | **num** |  | [optional] [default to 30]
**driverMatchingBroadcastLimit** | **int** |  | [optional] [default to 10]
**driverMaxCancellationsPerDay** | **int** |  | [optional] [default to 3]
**paymentPendingTimeoutMinutes** | **num** |  | [optional] [default to 15]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


