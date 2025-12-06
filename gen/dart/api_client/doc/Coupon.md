# api_client.model.Coupon

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**name** | **String** |  | 
**code** | **String** |  | 
**couponType** | [**CouponType**](CouponType.md) |  | [optional] [default to CouponType.GENERAL]
**rules** | [**CouponRules**](CouponRules.md) |  | 
**discountAmount** | **num** |  | [optional] 
**discountPercentage** | **num** |  | [optional] 
**usageLimit** | **num** |  | 
**usedCount** | **num** |  | 
**periodStart** | [**DateTime**](DateTime.md) |  | 
**periodEnd** | [**DateTime**](DateTime.md) |  | 
**isActive** | **bool** |  | 
**merchantId** | **String** |  | [optional] 
**eventName** | **String** |  | [optional] 
**eventDescription** | **String** |  | [optional] 
**createdById** | **String** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


