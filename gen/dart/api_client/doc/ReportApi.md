# api_client.api.ReportApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reportCreate**](ReportApi.md#reportcreate) | **POST** /reports | 
[**reportGet**](ReportApi.md#reportget) | **GET** /reports/{id} | 
[**reportList**](ReportApi.md#reportlist) | **GET** /reports | 
[**reportRemove**](ReportApi.md#reportremove) | **DELETE** /reports/{id} | 
[**reportUpdate**](ReportApi.md#reportupdate) | **PUT** /reports/{id} | 


# **reportCreate**
> ReportCreate200Response reportCreate(insertReport)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final InsertReport insertReport = ; // InsertReport | 

try {
    final response = api.reportCreate(insertReport);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertReport** | [**InsertReport**](InsertReport.md)|  | 

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
> ReportList200Response reportList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.reportList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**ReportList200Response**](ReportList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportRemove**
> BadgeRemove200Response reportRemove(id)



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

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reportUpdate**
> ReportCreate200Response reportUpdate(id, updateReport)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReportApi();
final String id = id_example; // String | 
final UpdateReport updateReport = ; // UpdateReport | 

try {
    final response = api.reportUpdate(id, updateReport);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->reportUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateReport** | [**UpdateReport**](UpdateReport.md)|  | 

### Return type

[**ReportCreate200Response**](ReportCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

