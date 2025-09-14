# akademove_api.api.ReportApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createReport**](ReportApi.md#createreport) | **POST** /reports | 
[**deleteReport**](ReportApi.md#deletereport) | **DELETE** /reports/{id} | 
[**getAllReport**](ReportApi.md#getallreport) | **GET** /reports | 
[**getReportById**](ReportApi.md#getreportbyid) | **GET** /reports/{id} | 
[**updateReport**](ReportApi.md#updatereport) | **PUT** /reports/{id} | 


# **createReport**
> CreateReportSuccessResponse createReport(createReportRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReportApi();
final CreateReportRequest createReportRequest = ; // CreateReportRequest | 

try {
    final response = api.createReport(createReportRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->createReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReportRequest** | [**CreateReportRequest**](CreateReportRequest.md)|  | [optional] 

### Return type

[**CreateReportSuccessResponse**](CreateReportSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteReport**
> DeleteReportSuccessResponse deleteReport(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReportApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteReport(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->deleteReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteReportSuccessResponse**](DeleteReportSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllReport**
> GetAllReportSuccessResponse getAllReport(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReportApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllReport(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->getAllReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllReportSuccessResponse**](GetAllReportSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReportById**
> GetReportByIdSuccessResponse getReportById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReportApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getReportById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->getReportById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetReportByIdSuccessResponse**](GetReportByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateReport**
> UpdateReportSuccessResponse updateReport(id, createReportRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReportApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreateReportRequest createReportRequest = ; // CreateReportRequest | 

try {
    final response = api.updateReport(id, createReportRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReportApi->updateReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createReportRequest** | [**CreateReportRequest**](CreateReportRequest.md)|  | [optional] 

### Return type

[**UpdateReportSuccessResponse**](UpdateReportSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

