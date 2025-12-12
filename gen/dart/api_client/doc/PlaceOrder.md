# api_client.model.PlaceOrder

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**dropoffLocation** | [**Coordinate**](Coordinate.md) |  | 
**pickupLocation** | [**Coordinate**](Coordinate.md) |  | 
**pickupAddress** | **String** |  | [optional] 
**dropoffAddress** | **String** |  | [optional] 
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**type** | [**OrderType**](OrderType.md) |  | 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**genderPreference** | **String** |  | [optional] 
**couponCode** | **String** |  | [optional] 
**payment** | [**PlaceOrderPayment**](PlaceOrderPayment.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


