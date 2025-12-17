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
**orderCompletionTimeoutMinutes** | **num** |  | [optional] [default to 60]
**noShowTimeoutMinutes** | **num** |  | [optional] [default to 30]
**orderStaleTimestampMinutes** | **num** |  | [optional] [default to 5]
**driverLocationStaleThresholdMinutes** | **num** |  | [optional] [default to 15]
**driverRebroadcastIntervalMinutes** | **num** |  | [optional] [default to 2]
**driverRebroadcastRadiusMultiplier** | **num** |  | [optional] [default to 1.5]
**maxBadgeCommissionReduction** | **num** |  | [optional] [default to 0.5]
**scheduledOrderMinAdvanceMinutes** | **num** |  | [optional] [default to 30]
**scheduledOrderMaxAdvanceDays** | **num** |  | [optional] [default to 7]
**scheduledOrderMatchingLeadTimeMinutes** | **num** |  | [optional] [default to 15]
**scheduledOrderMinRescheduleHours** | **num** |  | [optional] [default to 1]
**onTimeDeliveryThresholdMinutes** | **num** |  | [optional] [default to 10]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


