# api_client.api.NotificationApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationDelete**](NotificationApi.md#notificationdelete) | **DELETE** /notifications/{id} | 
[**notificationGetUnreadCount**](NotificationApi.md#notificationgetunreadcount) | **GET** /notifications/unread-count | 
[**notificationList**](NotificationApi.md#notificationlist) | **GET** /notifications | 
[**notificationMarkAllAsRead**](NotificationApi.md#notificationmarkallasread) | **PATCH** /notifications/read-all | 
[**notificationMarkAsRead**](NotificationApi.md#notificationmarkasread) | **PATCH** /notifications/{id}/read | 
[**notificationRemoveToken**](NotificationApi.md#notificationremovetoken) | **DELETE** /notifications/token/{token} | 
[**notificationSaveToken**](NotificationApi.md#notificationsavetoken) | **POST** /notifications/token | 
[**notificationSubscribeToTopic**](NotificationApi.md#notificationsubscribetotopic) | **POST** /notifications/subscribe | 
[**notificationUnsubscribeToTopic**](NotificationApi.md#notificationunsubscribetotopic) | **POST** /notifications/unsubscribe | 


# **notificationDelete**
> BannerDelete200Response notificationDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.notificationDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BannerDelete200Response**](BannerDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationGetUnreadCount**
> SupportChatMarkAsRead200Response notificationGetUnreadCount()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();

try {
    final response = api.notificationGetUnreadCount();
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationGetUnreadCount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SupportChatMarkAsRead200Response**](SupportChatMarkAsRead200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationList**
> NotificationList200Response notificationList(read, cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final String read = read_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.notificationList(read, cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **read** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**NotificationList200Response**](NotificationList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationMarkAllAsRead**
> SupportChatMarkAsRead200Response notificationMarkAllAsRead()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();

try {
    final response = api.notificationMarkAllAsRead();
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationMarkAllAsRead: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SupportChatMarkAsRead200Response**](SupportChatMarkAsRead200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationMarkAsRead**
> NotificationMarkAsRead200Response notificationMarkAsRead(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.notificationMarkAsRead(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationMarkAsRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**NotificationMarkAsRead200Response**](NotificationMarkAsRead200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationRemoveToken**
> BannerDelete200Response notificationRemoveToken(token)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final String token = token_example; // String | 

try {
    final response = api.notificationRemoveToken(token);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationRemoveToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

[**BannerDelete200Response**](BannerDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationSaveToken**
> BannerDelete200Response notificationSaveToken(notificationSaveTokenRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final NotificationSaveTokenRequest notificationSaveTokenRequest = ; // NotificationSaveTokenRequest | 

try {
    final response = api.notificationSaveToken(notificationSaveTokenRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationSaveToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationSaveTokenRequest** | [**NotificationSaveTokenRequest**](NotificationSaveTokenRequest.md)|  | 

### Return type

[**BannerDelete200Response**](BannerDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationSubscribeToTopic**
> NotificationSubscribeToTopic200Response notificationSubscribeToTopic(notificationSubscribeToTopicRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final NotificationSubscribeToTopicRequest notificationSubscribeToTopicRequest = ; // NotificationSubscribeToTopicRequest | 

try {
    final response = api.notificationSubscribeToTopic(notificationSubscribeToTopicRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationSubscribeToTopic: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationSubscribeToTopicRequest** | [**NotificationSubscribeToTopicRequest**](NotificationSubscribeToTopicRequest.md)|  | 

### Return type

[**NotificationSubscribeToTopic200Response**](NotificationSubscribeToTopic200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationUnsubscribeToTopic**
> NotificationSubscribeToTopic200Response notificationUnsubscribeToTopic(notificationSubscribeToTopicRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getNotificationApi();
final NotificationSubscribeToTopicRequest notificationSubscribeToTopicRequest = ; // NotificationSubscribeToTopicRequest | 

try {
    final response = api.notificationUnsubscribeToTopic(notificationSubscribeToTopicRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationApi->notificationUnsubscribeToTopic: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationSubscribeToTopicRequest** | [**NotificationSubscribeToTopicRequest**](NotificationSubscribeToTopicRequest.md)|  | 

### Return type

[**NotificationSubscribeToTopic200Response**](NotificationSubscribeToTopic200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

