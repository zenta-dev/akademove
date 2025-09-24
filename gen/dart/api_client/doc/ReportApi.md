# api_client.api.ReportApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reportCreate**](ReportApi.md#reportcreate) | **POST** /reports | 
[**reportGet**](ReportApi.md#reportget) | **GET** /reports/{id} | 
[**reportList**](ReportApi.md#reportlist) | **GET** /reports | 
[**reportRemove**](ReportApi.md#reportremove) | **DELETE** /reports/{id} | 
[**reportUpdate**](ReportApi.md#reportupdate) | **PUT** /reports/{id} | 


# **reportCreate**
> ReportCreate200Response reportCreate(reportCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final ReportCreateRequest reportCreateRequest = ; // ReportCreateRequest | 

try {
    final response = api.reportCreate(reportCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reportCreateRequest** | [**ReportCreateRequest**](ReportCreateRequest.md)|  | 

### Return type

[**ReportCreate200Response**](ReportCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportGet**
> ReportCreate200Response reportGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String id = id_example; // String | 

try {
    final response = api.reportGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReportCreate200Response**](ReportCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportList**
> ReportList200Response reportList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.reportList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**ReportList200Response**](ReportList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportRemove**
> DriverRemove200Response reportRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String id = id_example; // String | 

try {
    final response = api.reportRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportRemove: $e\n');
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

# **reportUpdate**
> ReportCreate200Response reportUpdate(id, reportUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String id = id_example; // String | 
final ReportUpdateRequest reportUpdateRequest = ; // ReportUpdateRequest | 

try {
    final response = api.reportUpdate(id, reportUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reportUpdateRequest** | [**ReportUpdateRequest**](ReportUpdateRequest.md)|  | 

### Return type

[**ReportCreate200Response**](ReportCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

