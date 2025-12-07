# api_client.model.OrderMerchant

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**userId** | **String** |  | [optional] 
**name** | **String** |  | [optional] 
**email** | **String** |  | [optional] 
**phone** | [**Phone**](Phone.md) |  | [optional] 
**address** | **String** |  | [optional] 
**location** | [**Coordinate**](Coordinate.md) |  | [optional] 
**isActive** | **bool** |  | [optional] 
**isOnline** | **bool** | Whether merchant is currently online/available | [optional] 
**isTakingOrders** | **bool** | Whether merchant is actively taking orders (subset of online) | [optional] 
**operatingStatus** | **String** | Current operating status (OPEN, CLOSED, BREAK, MAINTENANCE) | [optional] 
**rating** | **num** |  | [optional] 
**document** | **String** |  | [optional] 
**image** | **String** |  | [optional] 
**category** | [**MerchantCategory**](MerchantCategory.md) |  | [optional] 
**categories** | **List&lt;String&gt;** | List of merchant item categories | [optional] 
**bank** | [**Bank**](Bank.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


