# api_client.api.DriverApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driverCreate**](DriverApi.md#drivercreate) | **POST** /drivers | 
[**driverGet**](DriverApi.md#driverget) | **GET** /drivers/{id} | 
[**driverList**](DriverApi.md#driverlist) | **GET** /drivers | 
[**driverRemove**](DriverApi.md#driverremove) | **DELETE** /drivers/{id} | 
[**driverUpdate**](DriverApi.md#driverupdate) | **PUT** /drivers/{id} | 


# **driverCreate**
> DriverCreate200Response driverCreate(driverCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final DriverCreateRequest driverCreateRequest = ; // DriverCreateRequest | 

try {
    final response = api.driverCreate(driverCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverCreateRequest** | [**DriverCreateRequest**](DriverCreateRequest.md)|  | 

### Return type

[**DriverCreate200Response**](DriverCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverGet**
> DriverCreate200Response driverGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverCreate200Response**](DriverCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverList**
> DriverList200Response driverList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.driverList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**DriverList200Response**](DriverList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverRemove**
> DriverRemove200Response driverRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverRemove: $e\n');
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

# **driverUpdate**
> DriverCreate200Response driverUpdate(id, driverUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final DriverUpdateRequest driverUpdateRequest = ; // DriverUpdateRequest | 

try {
    final response = api.driverUpdate(id, driverUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverUpdateRequest** | [**DriverUpdateRequest**](DriverUpdateRequest.md)|  | 

### Return type

[**DriverCreate200Response**](DriverCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

