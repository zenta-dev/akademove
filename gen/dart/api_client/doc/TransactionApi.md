# api_client.api.TransactionApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**transactionGet**](TransactionApi.md#transactionget) | **GET** /transactions/{id} | 
[**transactionList**](TransactionApi.md#transactionlist) | **GET** /transactions | 


# **transactionGet**
> TransactionGet200Response transactionGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getTransactionApi();
final String id = id_example; // String | 

try {
    final response = api.transactionGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TransactionApi->transactionGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TransactionGet200Response**](TransactionGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **transactionList**
> TransactionList200Response transactionList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getTransactionApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.transactionList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TransactionApi->transactionList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**TransactionList200Response**](TransactionList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

