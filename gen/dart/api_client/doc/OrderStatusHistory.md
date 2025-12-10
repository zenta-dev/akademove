# api_client.model.OrderStatusHistory

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **num** |  | 
**orderId** | **String** |  | 
**previousStatus** | [**OrderStatus**](OrderStatus.md) |  | 
**newStatus** | [**OrderStatus**](OrderStatus.md) |  | 
**changedBy** | **String** |  | 
**changedByRole** | [**OrderStatusHistoryRole**](OrderStatusHistoryRole.md) |  | 
**reason** | **String** |  | 
**metadata** | **Map&lt;String, Object&gt;** |  | 
**changedAt** | [**DateTime**](DateTime.md) |  | 
**changedByUser** | [**DriverUser**](DriverUser.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


