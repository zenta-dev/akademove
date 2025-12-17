# api_client.api.AdminApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountDeletionDelete**](AdminApi.md#accountdeletiondelete) | **DELETE** /account-deletion/{id} | 
[**accountDeletionGetById**](AdminApi.md#accountdeletiongetbyid) | **GET** /account-deletion/{id} | 
[**accountDeletionList**](AdminApi.md#accountdeletionlist) | **GET** /account-deletion | 
[**accountDeletionReview**](AdminApi.md#accountdeletionreview) | **PUT** /account-deletion/{id}/review | 
[**analyticsExportOperatorAnalytics**](AdminApi.md#analyticsexportoperatoranalytics) | **GET** /analytics/operator/export | 
[**broadcastCreate**](AdminApi.md#broadcastcreate) | **POST** /broadcasts | 
[**broadcastDelete**](AdminApi.md#broadcastdelete) | **DELETE** /broadcasts/{id} | 
[**broadcastGet**](AdminApi.md#broadcastget) | **GET** /broadcasts/{id} | 
[**broadcastList**](AdminApi.md#broadcastlist) | **GET** /broadcasts | 
[**broadcastSend**](AdminApi.md#broadcastsend) | **POST** /broadcasts/{id}/send | 
[**broadcastStats**](AdminApi.md#broadcaststats) | **GET** /broadcasts/stats | 
[**broadcastUpdate**](AdminApi.md#broadcastupdate) | **PUT** /broadcasts/{id} | 
[**contactDelete**](AdminApi.md#contactdelete) | **DELETE** /contacts/{id} | 
[**contactGetById**](AdminApi.md#contactgetbyid) | **GET** /contacts/{id} | 
[**contactList**](AdminApi.md#contactlist) | **GET** /contacts | 
[**contactRespond**](AdminApi.md#contactrespond) | **POST** /contacts/{id}/respond | 
[**contactUpdate**](AdminApi.md#contactupdate) | **PUT** /contacts/{id} | 
[**driverActivate**](AdminApi.md#driveractivate) | **POST** /drivers/{id}/activate | 
[**driverApprove**](AdminApi.md#driverapprove) | **POST** /drivers/{id}/approve | 
[**driverReject**](AdminApi.md#driverreject) | **POST** /drivers/{id}/reject | 
[**driverSuspend**](AdminApi.md#driversuspend) | **POST** /drivers/{id}/suspend | 
[**userAdminCreate**](AdminApi.md#useradmincreate) | **POST** /users/admin | 
[**userAdminDashboardStats**](AdminApi.md#useradmindashboardstats) | **GET** /users/admin/dashboard-stats | 
[**userAdminGet**](AdminApi.md#useradminget) | **GET** /users/admin/{id} | 
[**userAdminList**](AdminApi.md#useradminlist) | **GET** /users/admin | 
[**userAdminRemove**](AdminApi.md#useradminremove) | **DELETE** /users/admin/{id} | 
[**userAdminUpdate**](AdminApi.md#useradminupdate) | **PUT** /users/admin/{id} | 


# **accountDeletionDelete**
> AccountDeletionDelete200Response accountDeletionDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.accountDeletionDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->accountDeletionDelete: $e\n');
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

# **accountDeletionGetById**
> AccountDeletionSubmit201Response accountDeletionGetById(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.accountDeletionGetById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->accountDeletionGetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AccountDeletionSubmit201Response**](AccountDeletionSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountDeletionList**
> AccountDeletionList200Response accountDeletionList(page, limit, status, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String status = status_example; // String | 
final String search = search_example; // String | 

try {
    final response = api.accountDeletionList(page, limit, status, search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->accountDeletionList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 
 **status** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**AccountDeletionList200Response**](AccountDeletionList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountDeletionReview**
> AccountDeletionSubmit201Response accountDeletionReview(id, accountDeletionReviewRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AccountDeletionReviewRequest accountDeletionReviewRequest = ; // AccountDeletionReviewRequest | 

try {
    final response = api.accountDeletionReview(id, accountDeletionReviewRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->accountDeletionReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **accountDeletionReviewRequest** | [**AccountDeletionReviewRequest**](AccountDeletionReviewRequest.md)|  | 

### Return type

[**AccountDeletionSubmit201Response**](AccountDeletionSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **analyticsExportOperatorAnalytics**
> String analyticsExportOperatorAnalytics(startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.analyticsExportOperatorAnalytics(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->analyticsExportOperatorAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **DateTime**|  | 
 **endDate** | **DateTime**|  | 

### Return type

**String**

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastCreate**
> BroadcastCreate201Response broadcastCreate(broadcastCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final BroadcastCreateRequest broadcastCreateRequest = ; // BroadcastCreateRequest | 

try {
    final response = api.broadcastCreate(broadcastCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **broadcastCreateRequest** | [**BroadcastCreateRequest**](BroadcastCreateRequest.md)|  | 

### Return type

[**BroadcastCreate201Response**](BroadcastCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastDelete**
> BannerDelete200Response broadcastDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.broadcastDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastDelete: $e\n');
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

# **broadcastGet**
> BroadcastCreate201Response broadcastGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.broadcastGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BroadcastCreate201Response**](BroadcastCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastList**
> BroadcastList200Response broadcastList(cursor, limit, direction, page, query, sortBy, order, mode, status, type, targetAudience, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final String status = status_example; // String | 
final String type = type_example; // String | 
final String targetAudience = targetAudience_example; // String | 
final String search = search_example; // String | 

try {
    final response = api.broadcastList(cursor, limit, direction, page, query, sortBy, order, mode, status, type, targetAudience, search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastList: $e\n');
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
 **status** | **String**|  | [optional] 
 **type** | **String**|  | [optional] 
 **targetAudience** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**BroadcastList200Response**](BroadcastList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastSend**
> BroadcastCreate201Response broadcastSend(id, body)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final Object body = Object; // Object | 

try {
    final response = api.broadcastSend(id, body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastSend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **body** | **Object**|  | [optional] 

### Return type

[**BroadcastCreate201Response**](BroadcastCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastStats**
> BroadcastStats200Response broadcastStats()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();

try {
    final response = api.broadcastStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BroadcastStats200Response**](BroadcastStats200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **broadcastUpdate**
> BroadcastCreate201Response broadcastUpdate(id, broadcastUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BroadcastUpdateRequest broadcastUpdateRequest = ; // BroadcastUpdateRequest | 

try {
    final response = api.broadcastUpdate(id, broadcastUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->broadcastUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **broadcastUpdateRequest** | [**BroadcastUpdateRequest**](BroadcastUpdateRequest.md)|  | 

### Return type

[**BroadcastCreate201Response**](BroadcastCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactDelete**
> ContactDelete200Response contactDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.contactDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContactDelete200Response**](ContactDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactGetById**
> ContactSubmit201Response contactGetById(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.contactGetById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactGetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactList**
> ContactList200Response contactList(page, limit, status, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String status = status_example; // String | 
final String search = search_example; // String | 

try {
    final response = api.contactList(page, limit, status, search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 
 **status** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**ContactList200Response**](ContactList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactRespond**
> ContactSubmit201Response contactRespond(id, contactRespondRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ContactRespondRequest contactRespondRequest = ; // ContactRespondRequest | 

try {
    final response = api.contactRespond(id, contactRespondRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactRespond: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **contactRespondRequest** | [**ContactRespondRequest**](ContactRespondRequest.md)|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactUpdate**
> ContactSubmit201Response contactUpdate(id, updateContact)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateContact updateContact = ; // UpdateContact | 

try {
    final response = api.contactUpdate(id, updateContact);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateContact** | [**UpdateContact**](UpdateContact.md)|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverActivate**
> DriverGetMine200ResponseBody driverActivate(id, body)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final Object body = Object; // Object | 

try {
    final response = api.driverActivate(id, body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->driverActivate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **body** | **Object**|  | [optional] 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverApprove**
> DriverGetMine200ResponseBody driverApprove(id, body)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final Object body = Object; // Object | 

try {
    final response = api.driverApprove(id, body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->driverApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **body** | **Object**|  | [optional] 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverReject**
> DriverGetMine200ResponseBody driverReject(id, driverRejectRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final DriverRejectRequest driverRejectRequest = ; // DriverRejectRequest | 

try {
    final response = api.driverReject(id, driverRejectRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->driverReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverRejectRequest** | [**DriverRejectRequest**](DriverRejectRequest.md)|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverSuspend**
> DriverGetMine200ResponseBody driverSuspend(id, driverSuspendRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final DriverSuspendRequest driverSuspendRequest = ; // DriverSuspendRequest | 

try {
    final response = api.driverSuspend(id, driverSuspendRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->driverSuspend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverSuspendRequest** | [**DriverSuspendRequest**](DriverSuspendRequest.md)|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminCreate**
> UserAdminCreate200Response userAdminCreate(insertUser)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final InsertUser insertUser = ; // InsertUser | 

try {
    final response = api.userAdminCreate(insertUser);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertUser** | [**InsertUser**](InsertUser.md)|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminDashboardStats**
> UserAdminDashboardStats200Response userAdminDashboardStats(startDate, endDate, period)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final String period = period_example; // String | 

try {
    final response = api.userAdminDashboardStats(startDate, endDate, period);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminDashboardStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 
 **period** | **String**|  | [optional] 

### Return type

[**UserAdminDashboardStats200Response**](UserAdminDashboardStats200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminGet**
> UserAdminCreate200Response userAdminGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.userAdminGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminList**
> UserAdminList200Response userAdminList(cursor, limit, direction, page, query, sortBy, order, mode, filters)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final UserAdminListFiltersParameter filters = ; // UserAdminListFiltersParameter | 

try {
    final response = api.userAdminList(cursor, limit, direction, page, query, sortBy, order, mode, filters);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminList: $e\n');
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
 **filters** | [**UserAdminListFiltersParameter**](.md)|  | [optional] 

### Return type

[**UserAdminList200Response**](UserAdminList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminRemove**
> BadgeRemove200Response userAdminRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.userAdminRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminUpdate**
> UserAdminCreate200Response userAdminUpdate(id, adminUpdateUser)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final AdminUpdateUser adminUpdateUser = ; // AdminUpdateUser | 

try {
    final response = api.userAdminUpdate(id, adminUpdateUser);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **adminUpdateUser** | [**AdminUpdateUser**](AdminUpdateUser.md)|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

