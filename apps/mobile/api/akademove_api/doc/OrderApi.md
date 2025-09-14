# akademove_api.api.OrderApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOrder**](OrderApi.md#createorder) | **POST** /orders | 
[**deleteOrder**](OrderApi.md#deleteorder) | **DELETE** /orders/{id} | 
[**getAllOrder**](OrderApi.md#getallorder) | **GET** /orders | 
[**getOrderById**](OrderApi.md#getorderbyid) | **GET** /orders/{id} | 
[**updateOrder**](OrderApi.md#updateorder) | **PUT** /orders/{id} | 


# **createOrder**
> CreateOrderSuccessResponse createOrder(createOrderRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getOrderApi();
final CreateOrderRequest createOrderRequest = ; // CreateOrderRequest | 

try {
    final response = api.createOrder(createOrderRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->createOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createOrderRequest** | [**CreateOrderRequest**](CreateOrderRequest.md)|  | [optional] 

### Return type

[**CreateOrderSuccessResponse**](CreateOrderSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOrder**
> DeleteOrderSuccessResponse deleteOrder(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteOrder(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->deleteOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteOrderSuccessResponse**](DeleteOrderSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllOrder**
> GetAllOrderSuccessResponse getAllOrder(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getOrderApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllOrder(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->getAllOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllOrderSuccessResponse**](GetAllOrderSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrderById**
> GetOrderByIdSuccessResponse getOrderById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getOrderById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->getOrderById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetOrderByIdSuccessResponse**](GetOrderByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOrder**
> UpdateOrderSuccessResponse updateOrder(id, updateOrderRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateOrderRequest updateOrderRequest = ; // UpdateOrderRequest | 

try {
    final response = api.updateOrder(id, updateOrderRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->updateOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateOrderRequest** | [**UpdateOrderRequest**](UpdateOrderRequest.md)|  | [optional] 

### Return type

[**UpdateOrderSuccessResponse**](UpdateOrderSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

