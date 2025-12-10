# api_client.api.EmergencyApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**emergencyGet**](EmergencyApi.md#emergencyget) | **GET** /emergencies/{id} | 
[**emergencyListByOrder**](EmergencyApi.md#emergencylistbyorder) | **GET** /emergencies/order/{orderId} | 
[**emergencyTrigger**](EmergencyApi.md#emergencytrigger) | **POST** /emergencies | 
[**emergencyUpdateStatus**](EmergencyApi.md#emergencyupdatestatus) | **PATCH** /emergencies/{id}/status | 


# **emergencyGet**
> EmergencyTrigger200Response emergencyGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**EmergencyTrigger200Response**](EmergencyTrigger200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyListByOrder**
> EmergencyListByOrder200Response emergencyListByOrder(orderId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String orderId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyListByOrder(orderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyListByOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

[**EmergencyListByOrder200Response**](EmergencyListByOrder200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyTrigger**
> EmergencyTrigger200Response emergencyTrigger(insertEmergency)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final InsertEmergency insertEmergency = ; // InsertEmergency | 

try {
    final response = api.emergencyTrigger(insertEmergency);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertEmergency** | [**InsertEmergency**](InsertEmergency.md)|  | 

### Return type

[**EmergencyTrigger200Response**](EmergencyTrigger200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyUpdateStatus**
> EmergencyTrigger200Response emergencyUpdateStatus(id, emergencyUpdateStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final EmergencyUpdateStatusRequest emergencyUpdateStatusRequest = ; // EmergencyUpdateStatusRequest | 

try {
    final response = api.emergencyUpdateStatus(id, emergencyUpdateStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **emergencyUpdateStatusRequest** | [**EmergencyUpdateStatusRequest**](EmergencyUpdateStatusRequest.md)|  | 

### Return type

[**EmergencyTrigger200Response**](EmergencyTrigger200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

