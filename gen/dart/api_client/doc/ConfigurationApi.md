# api_client.api.ConfigurationApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**configurationGet**](ConfigurationApi.md#configurationget) | **GET** /configurations/{key} | 
[**configurationList**](ConfigurationApi.md#configurationlist) | **GET** /configurations | 
[**configurationUpdate**](ConfigurationApi.md#configurationupdate) | **PUT** /configurations/{key} | 


# **configurationGet**
> ConfigurationGet200Response configurationGet(key)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String key = key_example; // String | 

try {
    final response = api.configurationGet(key);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 

### Return type

[**ConfigurationGet200Response**](ConfigurationGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationList**
> ConfigurationList200Response configurationList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.configurationList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**ConfigurationList200Response**](ConfigurationList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationUpdate**
> ConfigurationGet200Response configurationUpdate(key, configurationUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String key = key_example; // String | 
final ConfigurationUpdateRequest configurationUpdateRequest = ; // ConfigurationUpdateRequest | 

try {
    final response = api.configurationUpdate(key, configurationUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 
 **configurationUpdateRequest** | [**ConfigurationUpdateRequest**](ConfigurationUpdateRequest.md)|  | 

### Return type

[**ConfigurationGet200Response**](ConfigurationGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

