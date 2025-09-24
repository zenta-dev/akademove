# api_client.api.ScheduleApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**scheduleCreate**](ScheduleApi.md#schedulecreate) | **POST** /schedules | 
[**scheduleGet**](ScheduleApi.md#scheduleget) | **GET** /schedules/{id} | 
[**scheduleList**](ScheduleApi.md#schedulelist) | **GET** /schedules | 
[**scheduleRemove**](ScheduleApi.md#scheduleremove) | **DELETE** /schedules/{id} | 
[**scheduleUpdate**](ScheduleApi.md#scheduleupdate) | **PUT** /schedules/{id} | 


# **scheduleCreate**
> ScheduleCreate200Response scheduleCreate(scheduleCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final ScheduleCreateRequest scheduleCreateRequest = ; // ScheduleCreateRequest | 

try {
    final response = api.scheduleCreate(scheduleCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scheduleCreateRequest** | [**ScheduleCreateRequest**](ScheduleCreateRequest.md)|  | 

### Return type

[**ScheduleCreate200Response**](ScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scheduleGet**
> ScheduleCreate200Response scheduleGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String id = id_example; // String | 

try {
    final response = api.scheduleGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ScheduleCreate200Response**](ScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scheduleList**
> ScheduleList200Response scheduleList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.scheduleList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**ScheduleList200Response**](ScheduleList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scheduleRemove**
> DriverRemove200Response scheduleRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String id = id_example; // String | 

try {
    final response = api.scheduleRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scheduleUpdate**
> ScheduleCreate200Response scheduleUpdate(id, scheduleUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String id = id_example; // String | 
final ScheduleUpdateRequest scheduleUpdateRequest = ; // ScheduleUpdateRequest | 

try {
    final response = api.scheduleUpdate(id, scheduleUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **scheduleUpdateRequest** | [**ScheduleUpdateRequest**](ScheduleUpdateRequest.md)|  | 

### Return type

[**ScheduleCreate200Response**](ScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

