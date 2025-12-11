# api_client.model.MerchantOperatingHoursCreateRequest

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**dayOfWeek** | [**DayOfWeek**](DayOfWeek.md) |  | 
**isOpen** | **bool** | Whether the merchant is open on this day | 
**is24Hours** | **bool** | Whether the merchant operates 24 hours on this day | 
**openTime** | [**Time**](Time.md) | Opening time (h: 0-23, m: 0-59) | [optional] 
**closeTime** | [**Time**](Time.md) | Closing time (h: 0-23, m: 0-59) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


