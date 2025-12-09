# api_client.model.FraudStats

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalEvents** | **int** |  | 
**pendingEvents** | **int** |  | 
**reviewingEvents** | **int** |  | 
**confirmedEvents** | **int** |  | 
**dismissedEvents** | **int** |  | 
**eventsBySeverity** | [**FraudStatsEventsBySeverity**](FraudStatsEventsBySeverity.md) |  | 
**eventsByType** | **Map&lt;String, int&gt;** |  | 
**highRiskUsers** | **int** |  | 
**recentTrend** | [**List&lt;FraudStatsRecentTrendInner&gt;**](FraudStatsRecentTrendInner.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


