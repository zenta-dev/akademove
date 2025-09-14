# akademove_api.api.ScheduleApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSchedule**](ScheduleApi.md#createschedule) | **POST** /schedules | 
[**deleteSchedule**](ScheduleApi.md#deleteschedule) | **DELETE** /schedules/{id} | 
[**getAllSchedule**](ScheduleApi.md#getallschedule) | **GET** /schedules | 
[**getScheduleById**](ScheduleApi.md#getschedulebyid) | **GET** /schedules/{id} | 
[**updateSchedule**](ScheduleApi.md#updateschedule) | **PUT** /schedules/{id} | 


# **createSchedule**
> CreateScheduleSuccessResponse createSchedule(createScheduleRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getScheduleApi();
final CreateScheduleRequest createScheduleRequest = ; // CreateScheduleRequest | 

try {
    final response = api.createSchedule(createScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->createSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createScheduleRequest** | [**CreateScheduleRequest**](CreateScheduleRequest.md)|  | [optional] 

### Return type

[**CreateScheduleSuccessResponse**](CreateScheduleSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSchedule**
> DeleteScheduleSuccessResponse deleteSchedule(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getScheduleApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteSchedule(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->deleteSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteScheduleSuccessResponse**](DeleteScheduleSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllSchedule**
> GetAllScheduleSuccessResponse getAllSchedule(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getScheduleApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllSchedule(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->getAllSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllScheduleSuccessResponse**](GetAllScheduleSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getScheduleById**
> GetScheduleByIdSuccessResponse getScheduleById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getScheduleApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getScheduleById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->getScheduleById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetScheduleByIdSuccessResponse**](GetScheduleByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSchedule**
> UpdateScheduleSuccessResponse updateSchedule(id, updateScheduleRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getScheduleApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateScheduleRequest updateScheduleRequest = ; // UpdateScheduleRequest | 

try {
    final response = api.updateSchedule(id, updateScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ScheduleApi->updateSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateScheduleRequest** | [**UpdateScheduleRequest**](UpdateScheduleRequest.md)|  | [optional] 

### Return type

[**UpdateScheduleSuccessResponse**](UpdateScheduleSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

