# api_client.api.ScheduleApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**scheduleCreate**](ScheduleApi.md#schedulecreate) | **POST** /schedules | 
[**scheduleGet**](ScheduleApi.md#scheduleget) | **GET** /schedules/{id} | 
[**scheduleList**](ScheduleApi.md#schedulelist) | **GET** /schedules | 
[**scheduleRemove**](ScheduleApi.md#scheduleremove) | **DELETE** /schedules/{id} | 
[**scheduleUpdate**](ScheduleApi.md#scheduleupdate) | **PUT** /schedules/{id} | 


# **scheduleCreate**
> ScheduleCreate200Response scheduleCreate(insertScheduleRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final InsertScheduleRequest insertScheduleRequest = ; // InsertScheduleRequest | 

try {
    final response = api.scheduleCreate(insertScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertScheduleRequest** | [**InsertScheduleRequest**](InsertScheduleRequest.md)|  | 

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
> ScheduleList200Response scheduleList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.scheduleList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

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
> ScheduleCreate200Response scheduleUpdate(id, updateScheduleRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getScheduleApi();
final String id = id_example; // String | 
final UpdateScheduleRequest updateScheduleRequest = ; // UpdateScheduleRequest | 

try {
    final response = api.scheduleUpdate(id, updateScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->scheduleUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateScheduleRequest** | [**UpdateScheduleRequest**](UpdateScheduleRequest.md)|  | 

### Return type

[**ScheduleCreate200Response**](ScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

