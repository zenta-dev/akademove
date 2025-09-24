# api_client.model.CouponCreateRequest

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | 
**code** | **String** |  | 
**rules** | [**CouponCreateRequestRules**](CouponCreateRequestRules.md) |  | 
**discountAmount** | **num** |  | [optional] 
**discountPercentage** | **num** |  | [optional] 
**usageLimit** | **num** |  | 
**periodStart** | **num** | unix timestamp format | 
**periodEnd** | **num** | unix timestamp format | 
**isActive** | **bool** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


