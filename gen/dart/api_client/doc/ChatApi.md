# api_client.api.ChatApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**quickMessageCreate**](ChatApi.md#quickmessagecreate) | **POST** /quick-messages | 
[**quickMessageDelete**](ChatApi.md#quickmessagedelete) | **DELETE** /quick-messages/:id | 
[**quickMessageGet**](ChatApi.md#quickmessageget) | **GET** /quick-messages/:id | 
[**quickMessageList**](ChatApi.md#quickmessagelist) | **GET** /quick-messages | 
[**quickMessageUpdate**](ChatApi.md#quickmessageupdate) | **PATCH** /quick-messages/:id | 


# **quickMessageCreate**
> QuickMessageCreate200Response quickMessageCreate(insertQuickMessageTemplate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getChatApi();
final InsertQuickMessageTemplate insertQuickMessageTemplate = ; // InsertQuickMessageTemplate | 

try {
    final response = api.quickMessageCreate(insertQuickMessageTemplate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatApi->quickMessageCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertQuickMessageTemplate** | [**InsertQuickMessageTemplate**](InsertQuickMessageTemplate.md)|  | 

### Return type

[**QuickMessageCreate200Response**](QuickMessageCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickMessageDelete**
> AccountDeletionDelete200Response quickMessageDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getChatApi();
final String id = id_example; // String | 

try {
    final response = api.quickMessageDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatApi->quickMessageDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AccountDeletionDelete200Response**](AccountDeletionDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickMessageGet**
> QuickMessageCreate200Response quickMessageGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getChatApi();
final String id = id_example; // String | 

try {
    final response = api.quickMessageGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatApi->quickMessageGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**QuickMessageCreate200Response**](QuickMessageCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickMessageList**
> QuickMessageList200Response quickMessageList(role, orderType, locale, isActive)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getChatApi();
final String role = role_example; // String | 
final String orderType = orderType_example; // String | 
final String locale = locale_example; // String | 
final bool isActive = true; // bool | 

try {
    final response = api.quickMessageList(role, orderType, locale, isActive);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatApi->quickMessageList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | [optional] 
 **orderType** | **String**|  | [optional] 
 **locale** | **String**|  | [optional] 
 **isActive** | **bool**|  | [optional] 

### Return type

[**QuickMessageList200Response**](QuickMessageList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quickMessageUpdate**
> QuickMessageCreate200Response quickMessageUpdate(id, updateQuickMessageTemplate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getChatApi();
final String id = id_example; // String | 
final UpdateQuickMessageTemplate updateQuickMessageTemplate = ; // UpdateQuickMessageTemplate | 

try {
    final response = api.quickMessageUpdate(id, updateQuickMessageTemplate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatApi->quickMessageUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateQuickMessageTemplate** | [**UpdateQuickMessageTemplate**](UpdateQuickMessageTemplate.md)|  | 

### Return type

[**QuickMessageCreate200Response**](QuickMessageCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

