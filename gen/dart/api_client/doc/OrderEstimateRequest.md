# api_client.model.OrderEstimateRequest

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**dropoffLocationX** | **num** | Longitude (X-axis, East-West) | 
**dropoffLocationY** | **num** | Latitude (Y-axis, North-South) | 
**pickupLocationX** | **num** | Longitude (X-axis, East-West) | 
**pickupLocationY** | **num** | Latitude (Y-axis, North-South) | 
**notePickup** | **String** |  | [optional] 
**noteSenderName** | **String** |  | [optional] 
**noteSenderPhone** | **String** |  | [optional] 
**notePickupInstructions** | **String** |  | [optional] 
**noteDropoff** | **String** |  | [optional] 
**noteRecevierName** | **String** |  | [optional] 
**noteRecevierPhone** | **String** |  | [optional] 
**noteDropoffInstructions** | **String** |  | [optional] 
**type** | [**OrderType**](OrderType.md) |  | 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**genderPreference** | **String** |  | [optional] 
**couponCode** | **String** |  | [optional] 
**discountIds** | **List&lt;num&gt;** |  | [optional] 
**weight** | **num** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


