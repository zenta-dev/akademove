# api_client.api.SupportChatApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**supportChatCreateTicket**](SupportChatApi.md#supportchatcreateticket) | **POST** /support-chat/tickets | 
[**supportChatGetTicket**](SupportChatApi.md#supportchatgetticket) | **GET** /support-chat/tickets/{id} | 
[**supportChatGetUnreadCount**](SupportChatApi.md#supportchatgetunreadcount) | **GET** /support-chat/messages/unread-count | 
[**supportChatListMessages**](SupportChatApi.md#supportchatlistmessages) | **GET** /support-chat/messages | 
[**supportChatListTickets**](SupportChatApi.md#supportchatlisttickets) | **GET** /support-chat/tickets | 
[**supportChatMarkAsRead**](SupportChatApi.md#supportchatmarkasread) | **POST** /support-chat/messages/mark-read | 
[**supportChatSendMessage**](SupportChatApi.md#supportchatsendmessage) | **POST** /support-chat/messages | 
[**supportChatUpdateTicket**](SupportChatApi.md#supportchatupdateticket) | **PATCH** /support-chat/tickets/{id} | 


# **supportChatCreateTicket**
> SupportChatCreateTicket201Response supportChatCreateTicket(insertSupportTicket)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final InsertSupportTicket insertSupportTicket = ; // InsertSupportTicket | 

try {
    final response = api.supportChatCreateTicket(insertSupportTicket);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatCreateTicket: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertSupportTicket** | [**InsertSupportTicket**](InsertSupportTicket.md)|  | 

### Return type

[**SupportChatCreateTicket201Response**](SupportChatCreateTicket201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatGetTicket**
> SupportChatCreateTicket201Response supportChatGetTicket(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.supportChatGetTicket(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatGetTicket: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SupportChatCreateTicket201Response**](SupportChatCreateTicket201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatGetUnreadCount**
> SupportChatGetUnreadCount200Response supportChatGetUnreadCount(ticketId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final String ticketId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.supportChatGetUnreadCount(ticketId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatGetUnreadCount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ticketId** | **String**|  | 

### Return type

[**SupportChatGetUnreadCount200Response**](SupportChatGetUnreadCount200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatListMessages**
> SupportChatListMessages200Response supportChatListMessages(ticketId, limit, cursor)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final String ticketId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int limit = 56; // int | 
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.supportChatListMessages(ticketId, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatListMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ticketId** | **String**|  | 
 **limit** | **int**|  | 
 **cursor** | **String**|  | [optional] 

### Return type

[**SupportChatListMessages200Response**](SupportChatListMessages200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatListTickets**
> SupportChatListTickets200Response supportChatListTickets(limit, status, category, priority, assignedToId, userId, search, cursor)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final int limit = 56; // int | 
final SupportTicketStatus status = ; // SupportTicketStatus | 
final SupportTicketCategory category = ; // SupportTicketCategory | 
final SupportTicketPriority priority = ; // SupportTicketPriority | 
final String assignedToId = assignedToId_example; // String | 
final String userId = userId_example; // String | 
final String search = search_example; // String | 
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.supportChatListTickets(limit, status, category, priority, assignedToId, userId, search, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatListTickets: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | 
 **status** | [**SupportTicketStatus**](.md)|  | [optional] 
 **category** | [**SupportTicketCategory**](.md)|  | [optional] 
 **priority** | [**SupportTicketPriority**](.md)|  | [optional] 
 **assignedToId** | **String**|  | [optional] 
 **userId** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 
 **cursor** | **String**|  | [optional] 

### Return type

[**SupportChatListTickets200Response**](SupportChatListTickets200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatMarkAsRead**
> SupportChatMarkAsRead200Response supportChatMarkAsRead(supportChatMarkAsReadRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final SupportChatMarkAsReadRequest supportChatMarkAsReadRequest = ; // SupportChatMarkAsReadRequest | 

try {
    final response = api.supportChatMarkAsRead(supportChatMarkAsReadRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatMarkAsRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **supportChatMarkAsReadRequest** | [**SupportChatMarkAsReadRequest**](SupportChatMarkAsReadRequest.md)|  | 

### Return type

[**SupportChatMarkAsRead200Response**](SupportChatMarkAsRead200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatSendMessage**
> SupportChatSendMessage201Response supportChatSendMessage(insertSupportChatMessage)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final InsertSupportChatMessage insertSupportChatMessage = ; // InsertSupportChatMessage | 

try {
    final response = api.supportChatSendMessage(insertSupportChatMessage);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatSendMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertSupportChatMessage** | [**InsertSupportChatMessage**](InsertSupportChatMessage.md)|  | 

### Return type

[**SupportChatSendMessage201Response**](SupportChatSendMessage201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **supportChatUpdateTicket**
> SupportChatCreateTicket201Response supportChatUpdateTicket(id, updateSupportTicket)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getSupportChatApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateSupportTicket updateSupportTicket = ; // UpdateSupportTicket | 

try {
    final response = api.supportChatUpdateTicket(id, updateSupportTicket);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SupportChatApi->supportChatUpdateTicket: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateSupportTicket** | [**UpdateSupportTicket**](UpdateSupportTicket.md)|  | 

### Return type

[**SupportChatCreateTicket201Response**](SupportChatCreateTicket201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

