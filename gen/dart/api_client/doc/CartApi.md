# api_client.api.CartApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cartAddItem**](CartApi.md#cartadditem) | **POST** /cart/items | 
[**cartClear**](CartApi.md#cartclear) | **DELETE** /cart | 
[**cartGet**](CartApi.md#cartget) | **GET** /cart | 
[**cartRemoveItem**](CartApi.md#cartremoveitem) | **DELETE** /cart/items/{menuId} | 
[**cartUpdateItem**](CartApi.md#cartupdateitem) | **PATCH** /cart/items | 


# **cartAddItem**
> CartGet200Response cartAddItem(addToCartRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCartApi();
final AddToCartRequest addToCartRequest = ; // AddToCartRequest | 

try {
    final response = api.cartAddItem(addToCartRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CartApi->cartAddItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addToCartRequest** | [**AddToCartRequest**](AddToCartRequest.md)|  | 

### Return type

[**CartGet200Response**](CartGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cartClear**
> BadgeRemove200Response cartClear()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCartApi();

try {
    final response = api.cartClear();
    print(response);
} catch on DioException (e) {
    print('Exception when calling CartApi->cartClear: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cartGet**
> CartGet200Response cartGet()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCartApi();

try {
    final response = api.cartGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling CartApi->cartGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CartGet200Response**](CartGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cartRemoveItem**
> CartGet200Response cartRemoveItem(menuId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCartApi();
final String menuId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.cartRemoveItem(menuId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CartApi->cartRemoveItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **menuId** | **String**|  | 

### Return type

[**CartGet200Response**](CartGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cartUpdateItem**
> CartGet200Response cartUpdateItem(updateCartItemRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCartApi();
final UpdateCartItemRequest updateCartItemRequest = ; // UpdateCartItemRequest | 

try {
    final response = api.cartUpdateItem(updateCartItemRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CartApi->cartUpdateItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateCartItemRequest** | [**UpdateCartItemRequest**](UpdateCartItemRequest.md)|  | 

### Return type

[**CartGet200Response**](CartGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

