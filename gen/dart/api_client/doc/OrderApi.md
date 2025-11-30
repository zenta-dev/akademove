# api_client.api.OrderApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**orderEstimate**](OrderApi.md#orderestimate) | **GET** /orders/estimate | 
[**orderGet**](OrderApi.md#orderget) | **GET** /orders/{id} | 
[**orderList**](OrderApi.md#orderlist) | **GET** /orders | 
[**orderPlaceOrder**](OrderApi.md#orderplaceorder) | **POST** /orders | 
[**orderUpdate**](OrderApi.md#orderupdate) | **PUT** /orders/{id} | 


# **orderEstimate**
> OrderEstimate200Response orderEstimate(dropoffLocationX, dropoffLocationY, pickupLocationX, pickupLocationY, type, notePickup, noteDropoff, noteInstructions, items, gender, discountIds, weight)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final num dropoffLocationX = 8.14; // num | 
final num dropoffLocationY = 8.14; // num | 
final num pickupLocationX = 8.14; // num | 
final num pickupLocationY = 8.14; // num | 
final OrderType type = ; // OrderType | 
final String notePickup = notePickup_example; // String | 
final String noteDropoff = noteDropoff_example; // String | 
final String noteInstructions = noteInstructions_example; // String | 
final List<OrderItem> items = ; // List<OrderItem> | 
final UserGender gender = ; // UserGender | 
final List<num> discountIds = ; // List<num> | 
final num weight = 8.14; // num | 

try {
    final response = api.orderEstimate(dropoffLocationX, dropoffLocationY, pickupLocationX, pickupLocationY, type, notePickup, noteDropoff, noteInstructions, items, gender, discountIds, weight);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderEstimate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dropoffLocationX** | **num**|  | 
 **dropoffLocationY** | **num**|  | 
 **pickupLocationX** | **num**|  | 
 **pickupLocationY** | **num**|  | 
 **type** | [**OrderType**](.md)|  | 
 **notePickup** | **String**|  | [optional] 
 **noteDropoff** | **String**|  | [optional] 
 **noteInstructions** | **String**|  | [optional] 
 **items** | [**List&lt;OrderItem&gt;**](OrderItem.md)|  | [optional] 
 **gender** | [**UserGender**](.md)|  | [optional] 
 **discountIds** | [**List&lt;num&gt;**](num.md)|  | [optional] 
 **weight** | **num**|  | [optional] 

### Return type

[**OrderEstimate200Response**](OrderEstimate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderGet**
> OrderGet200Response orderGet(id)



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

[**OrderGet200Response**](OrderGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderList**
> OrderList200Response orderList(cursor, limit, direction, page, query, sortBy, order, mode, statuses)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final Object statuses = ; // Object | 

try {
    final response = api.orderList(cursor, limit, direction, page, query, sortBy, order, mode, statuses);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderList: $e\n');
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
 **statuses** | [**Object**](.md)|  | [optional] 

### Return type

[**OrderList200Response**](OrderList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderPlaceOrder**
> OrderPlaceOrder200Response orderPlaceOrder(placeOrder)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final PlaceOrder placeOrder = ; // PlaceOrder | 

try {
    final response = api.orderPlaceOrder(placeOrder);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderPlaceOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **placeOrder** | [**PlaceOrder**](PlaceOrder.md)|  | 

### Return type

[**OrderPlaceOrder200Response**](OrderPlaceOrder200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderUpdate**
> OrderGet200Response orderUpdate(id, updateOrder)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = id_example; // String | 
final UpdateOrder updateOrder = ; // UpdateOrder | 

try {
    final response = api.orderUpdate(id, updateOrder);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateOrder** | [**UpdateOrder**](UpdateOrder.md)|  | 

### Return type

[**OrderGet200Response**](OrderGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

