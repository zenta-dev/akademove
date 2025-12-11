# api_client.api.OrderApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**chatList**](OrderApi.md#chatlist) | **GET** /chat | 
[**chatSend**](OrderApi.md#chatsend) | **POST** /chat | 
[**orderCancel**](OrderApi.md#ordercancel) | **POST** /orders/{id}/cancel | 
[**orderCancelScheduledOrder**](OrderApi.md#ordercancelscheduledorder) | **POST** /orders/scheduled/{id}/cancel | 
[**orderEstimate**](OrderApi.md#orderestimate) | **POST** /orders/estimate | 
[**orderGet**](OrderApi.md#orderget) | **GET** /orders/{id} | 
[**orderGetActive**](OrderApi.md#ordergetactive) | **GET** /orders/active | 
[**orderGetStatusHistory**](OrderApi.md#ordergetstatushistory) | **GET** /orders/{id}/status-history | 
[**orderList**](OrderApi.md#orderlist) | **GET** /orders | 
[**orderListMessages**](OrderApi.md#orderlistmessages) | **GET** /orders/{id}/messages | 
[**orderListScheduledOrders**](OrderApi.md#orderlistscheduledorders) | **GET** /orders/scheduled | 
[**orderPlaceOrder**](OrderApi.md#orderplaceorder) | **POST** /orders | 
[**orderPlaceScheduledOrder**](OrderApi.md#orderplacescheduledorder) | **POST** /orders/scheduled | 
[**orderSendMessage**](OrderApi.md#ordersendmessage) | **POST** /orders/{id}/messages | 
[**orderUpdate**](OrderApi.md#orderupdate) | **PUT** /orders/{id} | 
[**orderUpdateScheduledOrder**](OrderApi.md#orderupdatescheduledorder) | **PUT** /orders/scheduled/{id} | 
[**orderUploadDeliveryProof**](OrderApi.md#orderuploaddeliveryproof) | **POST** /orders/{id}/delivery-proof | 
[**orderVerifyDeliveryOTP**](OrderApi.md#orderverifydeliveryotp) | **POST** /orders/{id}/verify-otp | 


# **chatList**
> ChatList200Response chatList(orderId, limit, cursor)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String orderId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int limit = 56; // int | 
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.chatList(orderId, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->chatList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **limit** | **int**|  | 
 **cursor** | **String**|  | [optional] 

### Return type

[**ChatList200Response**](ChatList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chatSend**
> ChatSend200Response chatSend(insertOrderChatMessage)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final InsertOrderChatMessage insertOrderChatMessage = ; // InsertOrderChatMessage | 

try {
    final response = api.chatSend(insertOrderChatMessage);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->chatSend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertOrderChatMessage** | [**InsertOrderChatMessage**](InsertOrderChatMessage.md)|  | 

### Return type

[**ChatSend200Response**](ChatSend200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderCancel**
> MerchantOrderAccept200Response orderCancel(id, orderCancelRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OrderCancelRequest orderCancelRequest = ; // OrderCancelRequest | 

try {
    final response = api.orderCancel(id, orderCancelRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderCancel: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderCancelRequest** | [**OrderCancelRequest**](OrderCancelRequest.md)|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderCancelScheduledOrder**
> MerchantOrderAccept200Response orderCancelScheduledOrder(id, orderCancelRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OrderCancelRequest orderCancelRequest = ; // OrderCancelRequest | 

try {
    final response = api.orderCancelScheduledOrder(id, orderCancelRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderCancelScheduledOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderCancelRequest** | [**OrderCancelRequest**](OrderCancelRequest.md)|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderEstimate**
> OrderEstimate200Response orderEstimate(estimateOrder)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final EstimateOrder estimateOrder = ; // EstimateOrder | 

try {
    final response = api.orderEstimate(estimateOrder);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderEstimate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **estimateOrder** | [**EstimateOrder**](EstimateOrder.md)|  | 

### Return type

[**OrderEstimate200Response**](OrderEstimate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderGet**
> MerchantOrderAccept200Response orderGet(id)



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

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderGetActive**
> OrderGetActive200Response orderGetActive()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();

try {
    final response = api.orderGetActive();
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderGetActive: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**OrderGetActive200Response**](OrderGetActive200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderGetStatusHistory**
> OrderGetStatusHistory200Response orderGetStatusHistory(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.orderGetStatusHistory(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderGetStatusHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**OrderGetStatusHistory200Response**](OrderGetStatusHistory200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderList**
> OrderList200Response orderList(cursor, limit, direction, page, query, sortBy, order, mode, statuses, type, startDate, endDate)



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
final Object type = ; // Object | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.orderList(cursor, limit, direction, page, query, sortBy, order, mode, statuses, type, startDate, endDate);
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
 **type** | [**Object**](.md)|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

### Return type

[**OrderList200Response**](OrderList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderListMessages**
> ChatList200Response orderListMessages(id, limit, cursor)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int limit = 56; // int | 
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.orderListMessages(id, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderListMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **limit** | **int**|  | 
 **cursor** | **String**|  | [optional] 

### Return type

[**ChatList200Response**](ChatList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderListScheduledOrders**
> OrderList200Response orderListScheduledOrders(cursor, limit, direction, page, query, sortBy, order, mode, statuses, type, startDate, endDate)



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
final Object type = ; // Object | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.orderListScheduledOrders(cursor, limit, direction, page, query, sortBy, order, mode, statuses, type, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderListScheduledOrders: $e\n');
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
 **type** | [**Object**](.md)|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

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

# **orderPlaceScheduledOrder**
> OrderPlaceScheduledOrder200Response orderPlaceScheduledOrder(placeScheduledOrder)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final PlaceScheduledOrder placeScheduledOrder = ; // PlaceScheduledOrder | 

try {
    final response = api.orderPlaceScheduledOrder(placeScheduledOrder);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderPlaceScheduledOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **placeScheduledOrder** | [**PlaceScheduledOrder**](PlaceScheduledOrder.md)|  | 

### Return type

[**OrderPlaceScheduledOrder200Response**](OrderPlaceScheduledOrder200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderSendMessage**
> ChatSend200Response orderSendMessage(id, orderSendMessageRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OrderSendMessageRequest orderSendMessageRequest = ; // OrderSendMessageRequest | 

try {
    final response = api.orderSendMessage(id, orderSendMessageRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderSendMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderSendMessageRequest** | [**OrderSendMessageRequest**](OrderSendMessageRequest.md)|  | 

### Return type

[**ChatSend200Response**](ChatSend200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderUpdate**
> MerchantOrderAccept200Response orderUpdate(id, updateOrder)



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

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderUpdateScheduledOrder**
> MerchantOrderAccept200Response orderUpdateScheduledOrder(id, updateScheduledOrder)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateScheduledOrder updateScheduledOrder = ; // UpdateScheduledOrder | 

try {
    final response = api.orderUpdateScheduledOrder(id, updateScheduledOrder);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderUpdateScheduledOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateScheduledOrder** | [**UpdateScheduledOrder**](UpdateScheduledOrder.md)|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderUploadDeliveryProof**
> OrderUploadDeliveryProof200Response orderUploadDeliveryProof(id, orderUploadDeliveryProofRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OrderUploadDeliveryProofRequest orderUploadDeliveryProofRequest = ; // OrderUploadDeliveryProofRequest | 

try {
    final response = api.orderUploadDeliveryProof(id, orderUploadDeliveryProofRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderUploadDeliveryProof: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderUploadDeliveryProofRequest** | [**OrderUploadDeliveryProofRequest**](OrderUploadDeliveryProofRequest.md)|  | 

### Return type

[**OrderUploadDeliveryProof200Response**](OrderUploadDeliveryProof200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderVerifyDeliveryOTP**
> OrderVerifyDeliveryOTP200Response orderVerifyDeliveryOTP(id, orderVerifyDeliveryOTPRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getOrderApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final OrderVerifyDeliveryOTPRequest orderVerifyDeliveryOTPRequest = ; // OrderVerifyDeliveryOTPRequest | 

try {
    final response = api.orderVerifyDeliveryOTP(id, orderVerifyDeliveryOTPRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderVerifyDeliveryOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **orderVerifyDeliveryOTPRequest** | [**OrderVerifyDeliveryOTPRequest**](OrderVerifyDeliveryOTPRequest.md)|  | 

### Return type

[**OrderVerifyDeliveryOTP200Response**](OrderVerifyDeliveryOTP200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

