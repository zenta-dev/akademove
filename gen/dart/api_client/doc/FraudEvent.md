# api_client.model.FraudEvent

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**eventType** | [**FraudEventType**](FraudEventType.md) |  | 
**severity** | [**FraudSeverity**](FraudSeverity.md) |  | 
**status** | [**FraudStatus**](FraudStatus.md) |  | 
**userId** | **String** |  | 
**driverId** | **String** |  | 
**signals** | [**List&lt;FraudSignal&gt;**](FraudSignal.md) |  | 
**score** | **num** |  | 
**location** | [**Location**](Location.md) |  | 
**previousLocation** | [**Location**](Location.md) |  | 
**distanceKm** | **num** |  | 
**timeDeltaSeconds** | **int** |  | 
**velocityKmh** | **num** |  | 
**ipAddress** | **String** |  | 
**userAgent** | **String** |  | 
**handledById** | **String** |  | 
**resolution** | **String** |  | 
**actionTaken** | **String** |  | 
**detectedAt** | [**DateTime**](DateTime.md) |  | 
**resolvedAt** | [**DateTime**](DateTime.md) |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**user** | [**FraudEventUser**](FraudEventUser.md) |  | [optional] 
**driver** | [**FraudEventDriver**](FraudEventDriver.md) |  | [optional] 
**handledBy** | [**FraudEventHandledBy**](FraudEventHandledBy.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


