# api_client.api.DriverApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyticsExportDriverAnalytics**](DriverApi.md#analyticsexportdriveranalytics) | **GET** /analytics/driver/{driverId}/export | 
[**driverGet**](DriverApi.md#driverget) | **GET** /drivers/{id} | 
[**driverGetAnalytics**](DriverApi.md#drivergetanalytics) | **GET** /drivers/{id}/analytics | 
[**driverGetMine**](DriverApi.md#drivergetmine) | **GET** /drivers/mine | 
[**driverGetReview**](DriverApi.md#drivergetreview) | **GET** /drivers/{id}/approval-review | 
[**driverList**](DriverApi.md#driverlist) | **GET** /drivers | 
[**driverMarkAsOffline**](DriverApi.md#drivermarkasoffline) | **POST** /drivers/{id}/mark-as-offline | 
[**driverMarkAsOnline**](DriverApi.md#drivermarkasonline) | **POST** /drivers/{id}/mark-as-online | 
[**driverNearby**](DriverApi.md#drivernearby) | **GET** /drivers/nearby | 
[**driverRemove**](DriverApi.md#driverremove) | **DELETE** /drivers/{id} | 
[**driverScheduleCreate**](DriverApi.md#driverschedulecreate) | **POST** /drivers/{driverId}/schedules | 
[**driverScheduleGet**](DriverApi.md#driverscheduleget) | **GET** /drivers/{driverId}/schedules/{id} | 
[**driverScheduleList**](DriverApi.md#driverschedulelist) | **GET** /drivers/{driverId}/schedules | 
[**driverScheduleRemove**](DriverApi.md#driverscheduleremove) | **DELETE** /drivers/{driverId}/schedules/{id} | 
[**driverScheduleUpdate**](DriverApi.md#driverscheduleupdate) | **PUT** /drivers/{driverId}/schedules/{id} | 
[**driverSubmitApproval**](DriverApi.md#driversubmitapproval) | **POST** /drivers/{id}/approval-review/submit-approval | 
[**driverSubmitRejection**](DriverApi.md#driversubmitrejection) | **POST** /drivers/{id}/approval-review/submit-rejection | 
[**driverUpdate**](DriverApi.md#driverupdate) | **PUT** /drivers/{id} | 
[**driverUpdateDocumentStatus**](DriverApi.md#driverupdatedocumentstatus) | **POST** /drivers/{id}/approval-review/update-document | 
[**driverVerifyQuiz**](DriverApi.md#driververifyquiz) | **POST** /drivers/{id}/approval-review/verify-quiz | 


# **analyticsExportDriverAnalytics**
> String analyticsExportDriverAnalytics(driverId, startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.analyticsExportDriverAnalytics(driverId, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->analyticsExportDriverAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
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

# **driverGet**
> DriverGetMine200ResponseBody driverGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverGetAnalytics**
> DriverGetAnalytics200Response driverGetAnalytics(id, period, startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final String period = period_example; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.driverGetAnalytics(id, period, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGetAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **period** | **String**|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

### Return type

[**DriverGetAnalytics200Response**](DriverGetAnalytics200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverGetMine**
> DriverGetMine200Response driverGetMine()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();

try {
    final response = api.driverGetMine();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGetMine: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DriverGetMine200Response**](DriverGetMine200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverGetReview**
> DriverGetReview200Response driverGetReview(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverGetReview(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGetReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverGetReview200Response**](DriverGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverList**
> DriverList200Response driverList(cursor, limit, direction, page, query, sortBy, order, mode, statuses, isOnline, minRating, maxRating)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final Object statuses = ; // Object | 
final Object isOnline = ; // Object | 
final num minRating = 8.14; // num | 
final num maxRating = 8.14; // num | 

try {
    final response = api.driverList(cursor, limit, direction, page, query, sortBy, order, mode, statuses, isOnline, minRating, maxRating);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverList: $e\n');
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
 **isOnline** | [**Object**](.md)|  | [optional] 
 **minRating** | **num**|  | [optional] 
 **maxRating** | **num**|  | [optional] 

### Return type

[**DriverList200Response**](DriverList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverMarkAsOffline**
> DriverGetMine200ResponseBody driverMarkAsOffline(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverMarkAsOffline(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverMarkAsOffline: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverMarkAsOnline**
> DriverGetMine200ResponseBody driverMarkAsOnline(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverMarkAsOnline(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverMarkAsOnline: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverNearby**
> DriverList200Response driverNearby(x, y, radiusKm, limit, gender)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final num x = 8.14; // num | 
final num y = 8.14; // num | 
final num radiusKm = 8.14; // num | 
final num limit = 8.14; // num | 
final UserGender gender = ; // UserGender | 

try {
    final response = api.driverNearby(x, y, radiusKm, limit, gender);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverNearby: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x** | **num**|  | 
 **y** | **num**|  | 
 **radiusKm** | **num**|  | 
 **limit** | **num**|  | 
 **gender** | [**UserGender**](.md)|  | [optional] 

### Return type

[**DriverList200Response**](DriverList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverRemove**
> BadgeRemove200Response driverRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverRemove: $e\n');
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

# **driverScheduleCreate**
> DriverScheduleCreate200Response driverScheduleCreate(driverId, driverScheduleCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final DriverScheduleCreateRequest driverScheduleCreateRequest = ; // DriverScheduleCreateRequest | 

try {
    final response = api.driverScheduleCreate(driverId, driverScheduleCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **driverScheduleCreateRequest** | [**DriverScheduleCreateRequest**](DriverScheduleCreateRequest.md)|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleGet**
> DriverScheduleCreate200Response driverScheduleGet(driverId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.driverScheduleGet(driverId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleList**
> DriverScheduleList200Response driverScheduleList(driverId, cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.driverScheduleList(driverId, cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**DriverScheduleList200Response**](DriverScheduleList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleRemove**
> BadgeRemove200Response driverScheduleRemove(driverId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.driverScheduleRemove(driverId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleUpdate**
> DriverScheduleCreate200Response driverScheduleUpdate(driverId, id, driverScheduleUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 
final DriverScheduleUpdateRequest driverScheduleUpdateRequest = ; // DriverScheduleUpdateRequest | 

try {
    final response = api.driverScheduleUpdate(driverId, id, driverScheduleUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 
 **driverScheduleUpdateRequest** | [**DriverScheduleUpdateRequest**](DriverScheduleUpdateRequest.md)|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverSubmitApproval**
> DriverGetReview200Response driverSubmitApproval(id, driverSubmitApprovalRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final DriverSubmitApprovalRequest driverSubmitApprovalRequest = ; // DriverSubmitApprovalRequest | 

try {
    final response = api.driverSubmitApproval(id, driverSubmitApprovalRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverSubmitApproval: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverSubmitApprovalRequest** | [**DriverSubmitApprovalRequest**](DriverSubmitApprovalRequest.md)|  | 

### Return type

[**DriverGetReview200Response**](DriverGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverSubmitRejection**
> DriverGetReview200Response driverSubmitRejection(id, driverSubmitRejectionRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final DriverSubmitRejectionRequest driverSubmitRejectionRequest = ; // DriverSubmitRejectionRequest | 

try {
    final response = api.driverSubmitRejection(id, driverSubmitRejectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverSubmitRejection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverSubmitRejectionRequest** | [**DriverSubmitRejectionRequest**](DriverSubmitRejectionRequest.md)|  | 

### Return type

[**DriverGetReview200Response**](DriverGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverUpdate**
> DriverGetMine200ResponseBody driverUpdate(id, studentId, licensePlate, studentCard, driverLicense, vehicleCertificate, bankProvider, bankNumber, currentLocationX, currentLocationY)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final num studentId = 8.14; // num | 
final String licensePlate = licensePlate_example; // String | 
final MultipartFile studentCard = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile driverLicense = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile vehicleCertificate = BINARY_DATA_HERE; // MultipartFile | 
final String bankProvider = bankProvider_example; // String | 
final num bankNumber = 8.14; // num | 
final num currentLocationX = 8.14; // num | Longitude (X-axis, East-West)
final num currentLocationY = 8.14; // num | Latitude (Y-axis, North-South)

try {
    final response = api.driverUpdate(id, studentId, licensePlate, studentCard, driverLicense, vehicleCertificate, bankProvider, bankNumber, currentLocationX, currentLocationY);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **studentId** | **num**|  | [optional] 
 **licensePlate** | **String**|  | [optional] 
 **studentCard** | **MultipartFile**|  | [optional] 
 **driverLicense** | **MultipartFile**|  | [optional] 
 **vehicleCertificate** | **MultipartFile**|  | [optional] 
 **bankProvider** | **String**|  | [optional] 
 **bankNumber** | **num**|  | [optional] 
 **currentLocationX** | **num**| Longitude (X-axis, East-West) | [optional] 
 **currentLocationY** | **num**| Latitude (Y-axis, North-South) | [optional] 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverUpdateDocumentStatus**
> DriverGetReview200Response driverUpdateDocumentStatus(id, driverUpdateDocumentStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final DriverUpdateDocumentStatusRequest driverUpdateDocumentStatusRequest = ; // DriverUpdateDocumentStatusRequest | 

try {
    final response = api.driverUpdateDocumentStatus(id, driverUpdateDocumentStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverUpdateDocumentStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverUpdateDocumentStatusRequest** | [**DriverUpdateDocumentStatusRequest**](DriverUpdateDocumentStatusRequest.md)|  | 

### Return type

[**DriverGetReview200Response**](DriverGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverVerifyQuiz**
> DriverGetReview200Response driverVerifyQuiz(id, driverVerifyQuizRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final DriverVerifyQuizRequest driverVerifyQuizRequest = ; // DriverVerifyQuizRequest | 

try {
    final response = api.driverVerifyQuiz(id, driverVerifyQuizRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverVerifyQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverVerifyQuizRequest** | [**DriverVerifyQuizRequest**](DriverVerifyQuizRequest.md)|  | 

### Return type

[**DriverGetReview200Response**](DriverGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

