# api_client.api.OrderApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**orderCreate**](OrderApi.md#ordercreate) | **POST** /orders | 
[**orderGet**](OrderApi.md#orderget) | **GET** /orders/{id} | 
[**orderList**](OrderApi.md#orderlist) | **GET** /orders | 
[**orderRemove**](OrderApi.md#orderremove) | **DELETE** /orders/{id} | 
[**orderUpdate**](OrderApi.md#orderupdate) | **PUT** /orders/{id} | 


# **orderCreate**
> OrderCreate200Response orderCreate(orderCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final OrderCreateRequest orderCreateRequest = ; // OrderCreateRequest | 

try {
    final response = api.orderCreate(orderCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderCreateRequest** | [**OrderCreateRequest**](OrderCreateRequest.md)|  | 

### Return type

[**OrderCreate200Response**](OrderCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderGet**
> OrderCreate200Response orderGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = id_example; // String | 

try {
    final response = api.orderGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**OrderCreate200Response**](OrderCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderList**
> OrderList200Response orderList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.orderList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**OrderList200Response**](OrderList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderRemove**
> DriverRemove200Response orderRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = id_example; // String | 

try {
    final response = api.orderRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderRemove: $e\n');
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

# **orderUpdate**
> OrderCreate200Response orderUpdate(id, orderUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = id_example; // String | 
final OrderUpdateRequest orderUpdateRequest = ; // OrderUpdateRequest | 

try {
    final response = api.orderUpdate(id, orderUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderUpdateRequest** | [**OrderUpdateRequest**](OrderUpdateRequest.md)|  | 

### Return type

[**OrderCreate200Response**](OrderCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

