# api_client.model.User

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**name** | **String** |  | 
**email** | **String** |  | 
**emailVerified** | **bool** |  | 
**image** | **String** |  | [optional] 
**role** | [**UserRole**](UserRole.md) |  | 
**banned** | **bool** |  | 
**banReason** | **String** |  | [optional] 
**banExpires** | [**DateTime**](DateTime.md) |  | [optional] 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**phone** | [**Phone**](Phone.md) |  | [optional] 
**rating** | **num** |  | [optional] [default to 0]
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**userBadges** | [**List&lt;UserBadge&gt;**](UserBadge.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


