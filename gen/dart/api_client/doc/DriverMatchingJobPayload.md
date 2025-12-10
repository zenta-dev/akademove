# api_client.model.DriverMatchingJobPayload

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderId** | **String** |  | 
**pickupLocation** | [**DriverMatchingJobPayloadPickupLocation**](DriverMatchingJobPayloadPickupLocation.md) |  | 
**orderType** | **String** |  | 
**genderPreference** | **String** |  | [optional] 
**userGender** | **String** |  | [optional] 
**initialRadiusKm** | **num** |  | [optional] [default to 5]
**maxMatchingDurationMinutes** | **num** |  | [optional] [default to 15]
**currentAttempt** | **int** |  | [optional] [default to 1]
**maxExpansionAttempts** | **int** |  | [optional] [default to 10]
**expansionRate** | **num** |  | [optional] [default to 0.2]
**matchingIntervalSeconds** | **num** |  | [optional] [default to 30]
**paymentId** | **String** |  | [optional] 
**wsRoomId** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


