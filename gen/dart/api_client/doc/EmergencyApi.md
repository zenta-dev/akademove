# api_client.api.EmergencyApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**emergencyContactCreate**](EmergencyApi.md#emergencycontactcreate) | **POST** /emergency-contacts | 
[**emergencyContactDelete**](EmergencyApi.md#emergencycontactdelete) | **DELETE** /emergency-contacts/{id} | 
[**emergencyContactGet**](EmergencyApi.md#emergencycontactget) | **GET** /emergency-contacts/{id} | 
[**emergencyContactGetPrimary**](EmergencyApi.md#emergencycontactgetprimary) | **GET** /emergency-contacts/primary | 
[**emergencyContactList**](EmergencyApi.md#emergencycontactlist) | **GET** /emergency-contacts | 
[**emergencyContactListActive**](EmergencyApi.md#emergencycontactlistactive) | **GET** /emergency-contacts/active | 
[**emergencyContactToggleActive**](EmergencyApi.md#emergencycontacttoggleactive) | **PATCH** /emergency-contacts/{id}/toggle | 
[**emergencyContactUpdate**](EmergencyApi.md#emergencycontactupdate) | **PUT** /emergency-contacts/{id} | 
[**emergencyGet**](EmergencyApi.md#emergencyget) | **GET** /emergencies/{id} | 
[**emergencyListByOrder**](EmergencyApi.md#emergencylistbyorder) | **GET** /emergencies/order/{orderId} | 
[**emergencyLog**](EmergencyApi.md#emergencylog) | **POST** /emergencies/log | 
[**emergencyTrigger**](EmergencyApi.md#emergencytrigger) | **POST** /emergencies | 
[**emergencyUpdateStatus**](EmergencyApi.md#emergencyupdatestatus) | **PATCH** /emergencies/{id}/status | 


# **emergencyContactCreate**
> EmergencyContactGetPrimary200Response emergencyContactCreate(insertEmergencyContact)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final InsertEmergencyContact insertEmergencyContact = ; // InsertEmergencyContact | 

try {
    final response = api.emergencyContactCreate(insertEmergencyContact);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertEmergencyContact** | [**InsertEmergencyContact**](InsertEmergencyContact.md)|  | 

### Return type

[**EmergencyContactGetPrimary200Response**](EmergencyContactGetPrimary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactDelete**
> BannerDelete200Response emergencyContactDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyContactDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactDelete: $e\n');
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

# **emergencyContactGet**
> EmergencyContactGetPrimary200Response emergencyContactGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyContactGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**EmergencyContactGetPrimary200Response**](EmergencyContactGetPrimary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactGetPrimary**
> EmergencyContactGetPrimary200Response emergencyContactGetPrimary()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();

try {
    final response = api.emergencyContactGetPrimary();
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactGetPrimary: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**EmergencyContactGetPrimary200Response**](EmergencyContactGetPrimary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactList**
> EmergencyContactListActive200Response emergencyContactList(cursor, limit, direction, page, query, sortBy, order, mode, isActive)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final bool isActive = true; // bool | 

try {
    final response = api.emergencyContactList(cursor, limit, direction, page, query, sortBy, order, mode, isActive);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactList: $e\n');
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
 **isActive** | **bool**|  | [optional] 

### Return type

[**EmergencyContactListActive200Response**](EmergencyContactListActive200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactListActive**
> EmergencyContactListActive200Response emergencyContactListActive()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();

try {
    final response = api.emergencyContactListActive();
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactListActive: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**EmergencyContactListActive200Response**](EmergencyContactListActive200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactToggleActive**
> EmergencyContactGetPrimary200Response emergencyContactToggleActive(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyContactToggleActive(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactToggleActive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**EmergencyContactGetPrimary200Response**](EmergencyContactGetPrimary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyContactUpdate**
> EmergencyContactGetPrimary200Response emergencyContactUpdate(id, updateEmergencyContact)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateEmergencyContact updateEmergencyContact = ; // UpdateEmergencyContact | 

try {
    final response = api.emergencyContactUpdate(id, updateEmergencyContact);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyContactUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateEmergencyContact** | [**UpdateEmergencyContact**](UpdateEmergencyContact.md)|  | 

### Return type

[**EmergencyContactGetPrimary200Response**](EmergencyContactGetPrimary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyGet**
> EmergencyGet200Response emergencyGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**EmergencyGet200Response**](EmergencyGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyListByOrder**
> EmergencyListByOrder200Response emergencyListByOrder(orderId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String orderId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.emergencyListByOrder(orderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyListByOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

[**EmergencyListByOrder200Response**](EmergencyListByOrder200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyLog**
> EmergencyLog200Response emergencyLog(logEmergency)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final LogEmergency logEmergency = ; // LogEmergency | 

try {
    final response = api.emergencyLog(logEmergency);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logEmergency** | [**LogEmergency**](LogEmergency.md)|  | 

### Return type

[**EmergencyLog200Response**](EmergencyLog200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyTrigger**
> EmergencyTrigger200Response emergencyTrigger(insertEmergency)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final InsertEmergency insertEmergency = ; // InsertEmergency | 

try {
    final response = api.emergencyTrigger(insertEmergency);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyTrigger: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertEmergency** | [**InsertEmergency**](InsertEmergency.md)|  | 

### Return type

[**EmergencyTrigger200Response**](EmergencyTrigger200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emergencyUpdateStatus**
> EmergencyGet200Response emergencyUpdateStatus(id, emergencyUpdateStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getEmergencyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final EmergencyUpdateStatusRequest emergencyUpdateStatusRequest = ; // EmergencyUpdateStatusRequest | 

try {
    final response = api.emergencyUpdateStatus(id, emergencyUpdateStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EmergencyApi->emergencyUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **emergencyUpdateStatusRequest** | [**EmergencyUpdateStatusRequest**](EmergencyUpdateStatusRequest.md)|  | 

### Return type

[**EmergencyGet200Response**](EmergencyGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

